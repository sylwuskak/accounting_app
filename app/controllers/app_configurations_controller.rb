class AppConfigurationsController < ApplicationController
    before_action :authenticate_user!

    def index
      @configurations = current_user.app_configurations
    end
  
    def create
      begin
        c = AppConfiguration.new(configuration_params)
        c.user = current_user
        c.date_from = Date.parse(params[:app_configuration][:date_from] + "-01")
        c.date_to = Date.parse(params[:app_configuration][:date_to] + "-01").end_of_month
        
        c.save!

      rescue => e
        flash[:danger] = I18n.t('configurations.save_failure')
      end
  
      redirect_to app_configurations_path
    end
  
    def update 
      begin
        @configuration = AppConfiguration.find(params[:id])
        @configuration.date_from = Date.parse(params[:app_configuration][:date_from] + "-01")
        @configuration.date_to = Date.parse(params[:app_configuration][:date_to] + "-01").end_of_month
        @configuration.update!(configuration_params)
      rescue => e
        flash[:danger] = I18n.t('configurations.save_failure')
      end
      redirect_to app_configurations_path  
    end
  
    def destroy
      AppConfiguration.destroy(params[:id])
      redirect_to app_configurations_path
    end

    def copy
      @configuration = AppConfiguration.find(params[:app_configuration_id])
      new_configuration = @configuration.dup
      last_date_to = current_user.app_configurations.order(:date_to).last.date_to
      new_configuration.date_from = last_date_to + 1.day
      new_configuration.date_to = (last_date_to + 1.day).end_of_month
      new_configuration.save!

      redirect_to app_configurations_path
    end
  
    private
  
    def configuration_params
      params.require(:app_configuration).permit(:base, :health_base, :retirement_percent, :disability_percent, :accidental_percent, :illness_percent, :fp_percent, :health_percent, :health_deduction_percent, :income_tax_threshold, :first_tax_rate, :second_tax_rate, :second_tax_amount)  
    end  
  end
  