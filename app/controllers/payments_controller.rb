class PaymentsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_password_change_required
    before_action :authenticate_admin!, only: [:edit, :update, :index, :destroy]

    def new
        @payment = Payment.new
    end

    def edit
        @payment = Payment.find(params[:id])
    end

    def update
        @payment = Payment.find(params[:id])
       
        if @payment.update(payment_params)
          redirect_to @payment
        else
          render 'edit'
        end
    end

    def create
        @payment = Payment.new(payment_params)
        if @payment.save
            redirect_to @payment
        else
            render 'new'
        end
    end

    def index
        @payments = Payment.all
        respond_to do |format|
            format.html
        end
      end

    def show
        @payment = Payment.find(params[:id])
    end

    def destroy
        @payment = Payment.find(params[:id])
        @payment.destroy
       
        redirect_to payments_path
    end

    private
    def payment_params
        params.require(:payment).permit(:building_id, :unit, :date, :name, :amount, :comments, :user_id, :building_name)
    end

    def check_password_change_required
      puts "current_user #{current_user}"
      if current_user.is_password_change_required
        redirect_to edit_user_registration_path, alert: "Su contraseña debe ser cambiada."
      end
    end

end
