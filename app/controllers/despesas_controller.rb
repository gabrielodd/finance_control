class DespesasController < ApplicationController
  before_action :set_despesa, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    if user_signed_in?
      @presenter = DespesaPresenter.new(current_user, params)
      @despesas = @presenter.despesas
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
      flash[:success] = I18n.t('json.success')
    else
      flash[:error] = I18n.t('json.error')
    end
    redirect_to despesas_url
  end

  def show
  end

  def new
    @despesa = Despesa.new
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
    service = DespesaService.new(despesa_params, current_user.id)
    result = service.call

    respond_to do |format|
      if result[:errors].empty?
        format.html { redirect_to despesas_url, notice: "Expenses were successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: result[:errors].flatten, status: :unprocessable_entity }
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
