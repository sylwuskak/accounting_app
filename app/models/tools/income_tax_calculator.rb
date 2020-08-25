class Tools::IncomeTaxCalculator

  def initialize(date, user)
    date_params = date.split('-').map{|a| a.to_i}
    @date = Date.new(*date_params) - 1.day
    @revenues = user.operations.select{|o| o.operation_type.downcase == "revenue" && o.date >= @date.beginning_of_year && o.date <= @date} 
    @costs = user.operations.select{|o| o.operation_type.downcase == "cost" && o.date >= @date.beginning_of_year && o.date <= @date} 
    @civil_contributions = user.contributions.select{|c| c.contribution_type.downcase == "civil" && c.date >= @date.beginning_of_year && c.date <= @date}
    @health_contributions = user.contributions.select{|c| c.contribution_type.downcase == "health" && c.date >= @date.beginning_of_year && c.date <= @date}
    @tax_contributions = user.contributions.select{|c| c.contribution_type.downcase == "tax" && c.date >= @date.beginning_of_year + 1.month && c.date <= @date}
    @app_configuration = AppConfiguration.where(year: @date.year).first
    @last_year_app_configuration = AppConfiguration.where(year: @date.year - 1).first
  end

  def calculate_tax
    revenues_sum = @revenues.map{|r| r.amount}.sum.round(2)
    costs_sum = @costs.map{|c| c.amount}.sum.round(2).to_f + @costs.map{|c| c.other_cost_amount || 0}.sum.round(2).to_f
    income = revenues_sum - costs_sum
    civil_contributions_sum = @civil_contributions.map{|c| c.amount}.sum.round(2).to_f
    tax_base = (income - civil_contributions_sum).round
    income_tax = (@app_configuration.first_tax_rate * tax_base / 100).round(2).to_f
    
    health_contributions_for_deduction_sum = @health_contributions.map do |hc| 
      if hc.amount == @app_configuration.health_amount 
        @app_configuration.health_amount_reduction
      elsif hc.amount == @last_year_app_configuration.health_amount 
        @last_year_app_configuration.health_amount_reduction
      else
        0
      end
    end.sum.round(2)
    tax_contributions_sum = @tax_contributions.map{|c| c.amount}.sum.round(2)
    income_tax_threshold_reduction = @app_configuration.income_tax_threshold
    all_advance = (income_tax - health_contributions_for_deduction_sum - income_tax_threshold_reduction ).round
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
        advance: advance,
        all_advance: all_advance
    }
  end

  def self.year_tax_summary(year, user)
    first_quarter_calculator = self.new(year + "-4", user) 
    second_quarter_calculator = self.new(year + "-7", user) 
    third_quarter_calculator = self.new(year + "-10", user) 
    fourth_quarter_calculator = self.new((year.to_i + 1).to_s + "-1", user) 
    
    year_summary = fourth_quarter_calculator.calculate_tax

    date = Date.new(year.to_i)

    contributions = user.contributions.select{|c| c.contribution_type.downcase == "tax" && c.date >= date + 1.month && c.date <= (date.end_of_year + 1.month)}

    {
      first_quarter_advance: 
        { 
          needed: first_quarter_calculator.calculate_tax[:advance],
          paid: (contributions.select{|c| c.date.month == 4}.first&.amount || 0)
        },
      second_quarter_advance: 
        {
          needed: second_quarter_calculator.calculate_tax[:advance],
          paid: (contributions.select{|c| c.date.month == 7}.first&.amount || 0)
        },
      third_quarter_advance: 
        {
          needed: third_quarter_calculator.calculate_tax[:advance],
          paid: (contributions.select{|c| c.date.month == 10}.first&.amount || 0)
        },
      fourth_quarter_advance: 
        {
          needed: year_summary[:advance],
          paid: (contributions.select{|c| c.date.month == 1}.first&.amount || 0)
        },
      revenues_sum: year_summary[:revenues_sum],
      costs_sum: year_summary[:costs_sum],
      all_advance: year_summary[:all_advance],
      civil_contributions_sum: year_summary[:civil_contributions_sum],
      health_contributions_for_deduction_sum: year_summary[:health_contributions_for_deduction_sum]
    }
  end
end