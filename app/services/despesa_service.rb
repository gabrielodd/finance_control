class DespesaService
  def initialize(despesa_params, user_id)
    @despesa_params = despesa_params
    @user_id = user_id
    @common_params = despesa_params.except(:descricao, :valor, :date, :repeating, :categoria_id).merge(user_id: user_id)
    @created_despesas = []
    @errors = []
    @repeating_params = extract_repeating_params
  end

  def call
    create_despesas
    { created_despesas: @created_despesas, errors: @errors }
  end

  private

  def extract_repeating_params
    repeating = []
    @despesa_params[:repeating].each_with_index do |v, i|
      repeating << @despesa_params[:repeating][i - 1] if v == "x"
    end
    repeating
  end

  def create_despesas
    @despesa_params[:descricao].each_with_index do |descricao, i|
      despesa_attributes = @common_params.merge({
        descricao: descricao,
        valor: @despesa_params[:valor][i],
        date: @despesa_params[:date][i].presence || Date.today,
        repeating: @repeating_params[i],
        categoria_id: @despesa_params[:categoria_id][i].to_i
      })
      
      despesa = Despesa.new(despesa_attributes)

      if despesa.save
        if @repeating_params[i] == '1'
          Despesa.delay(run_at: despesa.date + 1.month).create_every_month(despesa.id, @user_id)
        end
        @created_despesas << despesa
      else
        @errors << despesa.errors.full_messages
      end
    end
  end
end