class DelayedJobsController < ApplicationController
  def run
    job = Delayed::Job.find(params[:id])

    if job.present?
      job.invoke_job # Execute the Delayed::Job immediately
      job.destroy
      redirect_to despesas_url, notice: "Job added."
    else
      redirect_to despesas_url, alert: "Error"
    end
  end
end