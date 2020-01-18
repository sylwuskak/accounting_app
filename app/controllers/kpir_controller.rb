class KpirController < ApplicationController

  def get_kpir
    if params[:date]
      @operations = current_user.operations.select{|o| o.date.year == params[:date].to_i}.sort_by{|o| o.date}
    end
  end

end