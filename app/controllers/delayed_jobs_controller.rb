class DelayedJobsController < ApplicationController
  def run
    job = Delayed::Job.find(params[:id])

    if job.present?
      job.invoke_job # Execute the Delayed::Job immediately
      render json: { message: 'Job executed successfully' }, status: :ok
    else
      render json: { message: 'Job not found' }, status: :not_found
    end
  end
end