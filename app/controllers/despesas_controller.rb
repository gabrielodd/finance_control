class DespesasController < ApplicationController
  before_action :set_despesa, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    if user_signed_in?
      presenter = DespesaPresenter.new(current_user, params)
      @despesas = presenter.despesas
      @newest_record = presenter.newest_record
      @despesas_grouped_by_year = presenter.despesas_grouped_by_year
      @total = presenter.total
      @total_last_month = presenter.total_last_month
      @difference = presenter.difference
      @jobs = presenter.jobs
      @years_with_despesas = presenter.years_with_despesas
    else
      @despesas = []
    end
  end

  def relatorio
    @despesas = Despesa.where(user_id: current_user.id)
  end
  
  def export_to_json
    @despesas = Despesa.where(user_id: current_user.id).order(:date)
    date = Date.today.strftime("%Y-%m-%d")
    respond_to do |format|
      format.json do
        send_data @despesas.to_json(except: [:id, :user_id, :created_at, :updated_at]), filename: "despesas-#{date}.json"
      end
    end
  end

  def import_json
    file = params[:file]

    if file.content_type == 'application/json'
      json_data = JSON.parse(file.read)

      json_data.each do |despesa_data|
        despesa_data['user_id'] = current_user.id

        Despesa.create(despesa_data)
      end

      flash[:success] = 'JSON data imported successfully!'
    else
      flash[:error] = 'Invalid JSON file format. Please upload a valid JSON file.'
    end

    redirect_to despesas_url
  end

  def show
  end

  def new
    @despesa = Despesa.new
  end

  def edit
  end

  def update_valor
    @despesa = Despesa.find(params[:id])
    @despesa.update(valor: params[:valor], descricao: params[:descricao], date: params[:date])
  
    respond_to do |format|
      format.js
    end
  end

  def add_despesa
    params = add_despesa_params.merge!(user_id: current_user.id)
    @despesa = Despesa.new(params)

    if @despesa.save
      redirect_to despesas_url, notice: "Despesa was successfully created."
    else
      render json: { errors: @despesa.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    common_params = despesa_params.except(:descricao, :valor, :date, :repeating, :categoria_id).merge(user_id: current_user.id)
    created_despesas = []
    repeating_params = []
    errors = []

    despesa_params[:repeating].each_with_index do |v, i|
      if v == "x"
        repeating_params << despesa_params[:repeating][i - 1]
      end
    end
  
    despesa_params[:descricao].each_with_index do |descricao, i|
      despesa_attributes = common_params.merge({
        descricao: descricao,
        valor: despesa_params[:valor][i],
        date: despesa_params[:date][i].present? ? despesa_params[:date][i] : Date.today,
        repeating: repeating_params[i],
        categoria_id: despesa_params[:categoria_id][i].to_i
      })
      
      @despesa = Despesa.new(despesa_attributes)
  
      if @despesa.save
        Despesa.delay(run_at: @despesa.date + 1.month).create_every_month(@despesa.id, common_params[:user_id]) if repeating_params[i] == '1'
        created_despesas << @despesa
      else
        errors << @despesa.errors.full_messages
      end
    end
  
    respond_to do |format|
      if errors.empty?
        format.html { redirect_to despesas_url, notice: "Expenses were successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: errors.flatten, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @despesa.update(despesa_params)
        format.html { redirect_to despesa_url(@despesa), notice: "Despesa was successfully updated." }
        format.json { render :show, status: :ok, location: @despesa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @despesa.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @despesa.destroy

    respond_to do |format|
      format.html { redirect_to despesas_url, notice: "Despesa was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_despesa
    @despesa = Despesa.find(params[:id])
  end

  def despesa_params
    params.require(:despesa).permit(:user_id, categoria_id: [], date: [], descricao: [], valor: [], repeating: [])
  end

  def add_despesa_params
    params.require(:despesa).permit(:descricao, :valor, :date, :categoria_id)
  end
end
