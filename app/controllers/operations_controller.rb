class OperationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @operations = nil
    @operations = current_user.operations.order(date: :desc)   
  end
    
  def create
    begin
      o = Operation.new(operation_params)
      o.user = current_user
      o.save!
    rescue => e
      flash[:danger] = I18n.t('operations.save_failure')
    end

    redirect_to operations_path
  end

  def destroy
    Operation.destroy(params[:id])
    redirect_to operations_path
  end

  def update
    begin    
      @operation = Operation.find(params[:id])
      @operation.update!(operation_params)
    rescue => e
      flash[:danger] = I18n.t('operations.save_failure')
    end
    redirect_to operations_path    
    
  end

  private
  def operation_params
    permit_params = params.require(:operation).permit(:date, :operation_type, :description, :amount, :category_id)
    permit_params['amount'] = permit_params['amount'].gsub(',', '.').to_f.round(2).to_s
    permit_params
  end

end