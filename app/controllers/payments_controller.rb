class PaymentsController < ApplicationController
  def index
    @payments = Payment.where(user_id: current_user.id)
  end

  def create
    @payment = current_user.payments.build(payment_params)
    if @payment.save
      redirect_to payments_path, notice: "Payment created successfully."
    else
      render :index, alert: "Failed to create payment."
    end
  end
  
  def edit 
  end

  def update
    @payment = current_user.payments.find(params[:id])
    if @payment.update(payment_params)
      redirect_to payments_path, notice: "Payment updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @payment = current_user.payments.find(params[:id])
    @payment.destroy
    redirect_to payments_path, notice: "Payment deleted successfully."
  end

  private

  def payment_params
    params.require(:payment).permit(:name)
  end
end