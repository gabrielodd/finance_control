class DespesaPresenter
  def initialize(user, params)
    @user = user
    @params = params
    @date = Date.current
    @date_last_month = 1.month.ago
  end

  def despesas
    @despesas ||= Despesa.where(user_id: @user.id).tap do |scope|
      scope.where!("EXTRACT(YEAR FROM date) = ?", @params[:year]) if @params[:year].present?
    end
  end

  def newest_record
    most_recent_created = despesas.order(created_at: :desc).first
    most_recent_updated = despesas.order(updated_at: :desc).first

    if most_recent_created && most_recent_created.created_at > most_recent_updated.updated_at
      most_recent_created
    else
      most_recent_updated
    end
  end

  def despesas_grouped_by_month
    despesas.group_by(&:mes)
  end

  def despesas_grouped_by_year
    despesas.order(:date).group_by(&:ano)
  end

  def total_current_month
    @total_current_month ||= Despesa.total_spendings_current_month_from_user(@user.id, @date)
  end

  def total_last_month
    @total_last_month ||= Despesa.total_spendings_current_month_from_user(@user.id, @date_last_month)
  end

  def difference
    total_current_month - total_last_month
  end

  def current_month_year
    @date.strftime("%B %Y")
  end

  def jobs
    Delayed::Job.all.select do |job|
      handler = YAML.load(job.handler)
      user_id = handler.args.last if handler.respond_to?(:args)
      user_id == @user.id
    end.map do |job|
      handler = YAML.load(job.handler)
      despesa = Despesa.find_by(id: handler.args.first)
      {
        job_id: job.id,
        descricao: despesa&.descricao,
        valor: despesa&.valor,
        date: despesa&.date
      }
    end.compact.sort_by { |job| job[:date] }
  end

  def years_with_despesas
    @years_with_despesas ||= Despesa.where(user_id: @user.id).pluck("DISTINCT EXTRACT(YEAR FROM date)").map(&:to_i)
  end
end