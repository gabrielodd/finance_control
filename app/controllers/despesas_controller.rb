class DespesasController < ApplicationController
  before_action :set_despesa, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    if user_signed_in?
      date = Date.current
      date_last_month = 1.month.ago
      # @despesas = Despesa.within_month_from_user(current_user.id, date)
      @despesas = Despesa.where(user_id: current_user.id).order(:date)
      most_recent_created = Despesa.where(user_id: current_user.id).order(created_at: :desc).first
      most_recent_updated = Despesa.where(user_id: current_user.id).order(updated_at: :desc).first
      if most_recent_created.created_at > most_recent_updated.updated_at
        @newest_record = most_recent_created
      else
        @newest_record = most_recent_updated
      end
      @despesas_grouped = @despesas.group_by(&:mes)
      @despesas_grouped_by_year = @despesas.group_by(&:ano)
      # if params[:mes].present?
      #   # @despesas = @despesas.where("EXTRACT(MONTH FROM mes) = ?", params[:filter_month])
      # end
      @total = Despesa.total_spendings_current_month_from_user(current_user.id, date)
      @total_last_month = Despesa.total_spendings_current_month_from_user(current_user.id, date_last_month)
      @difference = @total - @total_last_month
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
    descricoes = despesa_params.delete(:descricao)
    valores = despesa_params.delete(:valor)
    dates = despesa_params.delete(:date)
    params = despesa_params.merge!(user_id: current_user.id)
    params[:date] = Date.today if params[:date].blank?

    respond_to do |format|
      descricoes.each_with_index do |descricao, i|
        @despesa = Despesa.new(params)
        @despesa.valor = valores[i]
        @despesa.descricao = descricao
        if dates[i].blank?
          @despesa.date = Date.today
        else
          @despesa.date = dates[i]
        end

        if @despesa.save
          if params[:repeating] == '1'
            Despesa.create_every_month(@despesa.id)
          end
          format.html { redirect_to despesas_url, notice: "Despesa was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @despesa.errors, status: :unprocessable_entity }
        end
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
    params.require(:despesa).permit(:categoria_id, :repeating, :user_id, date: [], descricao: [], valor: [])
  end

  def add_despesa_params
    params.require(:despesa).permit(:descricao, :valor, :date, :categoria_id)
  end
end
