class Tools::IncomeTaxCalculator

  def initialize(date, user)
    date_params = date.split('-').map{|a| a.to_i}
    @date = Date.new(*date_params) - 1.day
    @revenues = user.operations.select{|o| o.operation_type.downcase == "revenue" && o.date >= @date.beginning_of_year && o.date <= @date} 
    @costs = user.operations.select{|o| o.operation_type.downcase == "cost" && o.date >= @date.beginning_of_year && o.date <= @date} 
    @civil_contributions = user.contributions.select{|c| c.contribution_type.downcase == "civil" && c.date >= @date.beginning_of_year && c.date <= @date}
    @health_contributions = user.contributions.select{|c| c.contribution_type.downcase == "health" && c.date >= @date.beginning_of_year && c.date <= @date}
    @tax_contributions = user.contributions.select{|c| c.contribution_type.downcase == "tax" && c.date >= @date.beginning_of_year && c.date <= @date}
    @app_configuration = AppConfiguration.where(year: @date.year).first
  end

  def calculate_tax
    revenues_sum = @revenues.map{|r| r.amount}.sum.round(2)
    costs_sum = @costs.map{|c| c.amount}.sum.round(2).to_f + @costs.map{|c| c.other_cost_amount || 0}.sum.round(2).to_f
    income = revenues_sum - costs_sum
    civil_contributions_sum = @civil_contributions.map{|c| c.amount}.sum.round(2).to_f
    tax_base = (income - civil_contributions_sum).round
    income_tax = (@app_configuration.first_tax_rate * tax_base / 100).round(2).to_f
    
    health_contributions_for_deduction_sum = @health_contributions.map do |hc| 
      @app_configuration.health_amount_reduction
    end.sum.round(2)
    tax_contributions_sum = @tax_contributions.map{|c| c.amount}.sum.round(2)
    income_tax_threshold_reduction = @app_configuration.income_tax_threshold
    advance = (income_tax - health_contributions_for_deduction_sum - tax_contributions_sum - income_tax_threshold_reduction ).round

    {
        revenues_sum: revenues_sum,
        costs_sum: costs_sum,
        income: income,
        civil_contributions_sum: civil_contributions_sum,
        tax_base: tax_base,
        income_tax: income_tax,
        health_contributions_for_deduction_sum: health_contributions_for_deduction_sum,
        tax_contributions_sum: tax_contributions_sum,
        income_tax_threshold_reduction: income_tax_threshold_reduction,
        advance: advance
    }
  end
end