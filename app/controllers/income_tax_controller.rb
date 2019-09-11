class IncomeTaxController < ApplicationController

  def get_income_tax
    if params[:date]
      @calculator = Tools::IncomeTaxCalculator.new(params[:date], current_user)
      @income_tax_calculation = @calculator.calculate_tax
    end
  end

end