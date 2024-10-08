class DelayedJobsController < ApplicationController
  def run
    job = Delayed::Job.find(params[:id])

    if job.present?
      job.invoke_job # Execute the Delayed::Job immediately
      job.destroy
      redirect_to despesas_url, notice: "Job added."
    else
      redirect_to despesas_url, alert: "Job not found"
    end
  end

  def destroy
    job = Delayed::Job.find(params[:id])

    if job.present?
      handler = YAML.load(job.handler)
      despesa = Despesa.find(handler.args.first)
      despesa.update(repeating: false) if despesa.present?
      job.destroy
      redirect_to despesas_url, notice: "Job destroyed."
    end
  end
end