class DespesasController < ApplicationController
  before_action :set_despesa, only: %i[ show edit update destroy ]

  # GET /despesas or /despesas.json
  def index
    if user_signed_in?
      date = Date.current
      date_last_month = 1.month.ago
      # @despesas = Despesa.within_month_from_user(current_user.id, date)
      @despesas = Despesa.where(user_id: current_user.id).order(:date)
      @newest_record = Despesa.where(user_id: current_user.id).order(created_at: :desc).first
      @despesas_grouped = @despesas.group_by(&:mes)
      if params[:mes].present?
        # @despesas = @despesas.where("EXTRACT(MONTH FROM mes) = ?", params[:filter_month])
      end
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

    respond_to do |format|
      format.json do
        send_data @despesas.to_json(except: [:id, :user_id, :created_at, :updated_at]), filename: "despesas.json"
      end
    end
  end

  def import_json
    file = params[:file]

    if file.content_type == 'application/json'
      json_data = JSON.parse(file.read)

      # Assuming the JSON data is an array of objects, each representing a despesa
      json_data.each do |despesa_data|
        despesa_data['user_id'] = current_user.id

        # Create the Despesa object using the updated attributes
        Despesa.create(despesa_data)
      end

      flash[:success] = 'JSON data imported successfully!'
    else
      flash[:error] = 'Invalid JSON file format. Please upload a valid JSON file.'
    end

    redirect_to despesas_url
  end

  # GET /despesas/1 or /despesas/1.json
  def show
  end

  # GET /despesas/new
  def new
    @despesa = Despesa.new
  end

  # GET /despesas/1/edit
  def edit
  end

  # POST /despesas or /despesas.json
  def create
    descricoes = despesa_params.delete(:descricao)
    valores = despesa_params.delete(:valor)
    params = despesa_params.merge!(user_id: current_user.id)
    params[:date] = Date.today if params[:date].blank?

    respond_to do |format|
      descricoes.each_with_index do |descricao, i|
        @despesa = Despesa.new(params)
        @despesa.valor = valores[i]
        @despesa.descricao = descricao

        if @despesa.save
          if params[:repeating] == '1'
            Despesa.delay(run_at: 3.weeks.from_now).create_every_month(@despesa.id)
          end
          format.html { redirect_to despesas_url, notice: "Despesa was successfully created." }
          format.json { render :show, status: :created, location: @despesa }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @despesa.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /despesas/1 or /despesas/1.json
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

  # DELETE /despesas/1 or /despesas/1.json
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
    params.require(:despesa).permit(:categoria_id, :date, :repeating, :user_id, descricao: [], valor: [])
  end
end
