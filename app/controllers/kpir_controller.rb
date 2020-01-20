class KpirController < ApplicationController

  def get_kpir
    if params[:date]
      # require 'pry'
      # binding.pry
      @operations = current_user.operations.select{|o| o.date.year == params[:date].to_i}.group_by{|o| [o.date, o.invoice_no]}.sort_by{|k, v| [k[0], -v.first.amount] }
    end
  end

end