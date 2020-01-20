class KpirController < ApplicationController

  def get_kpir
    if params[:date]
      @operations = current_user.operations.select{|o| o.date.year == params[:date].to_i}.group_by{|o| [o.date, o.invoice_no]}.sort_by{|k, v| [k[0], v.first.created_at] }
    end
  end

  def get_kpir_by_month
    if params[:date]
      @operations = current_user.operations.select{|o| o.date.year == params[:date].to_i}.group_by{|o| o.date.month}.map do |month, operations|
        {
          date: month, 
          col_7: operations.select{|o| o.operation_subtype == "col_7"}.map{|o| o.amount}.sum.round(2),
          col_8: operations.select{|o| o.operation_subtype == "col_8"}.map{|o| o.amount}.sum.round(2),
          col_9: operations.select{|o| ['col_7', 'col_8'].include?(o.operation_subtype)}.map{|o| o.amount}.sum.round(2),
          col_10: operations.select{|o| o.operation_subtype == "col_10"}.map{|o| o.amount}.sum.round(2),
          col_11: operations.select{|o| o.operation_subtype == "col_10"}.map{|o| o.other_cost_amount || 0}.sum.round(2),
          col_12: operations.select{|o| o.operation_subtype == "col_12"}.map{|o| o.amount}.sum.round(2),
          col_13: operations.select{|o| o.operation_subtype == "col_13"}.map{|o| o.amount}.sum.round(2),
          col_14: operations.select{|o| ['col_12', 'col_13'].include?(o.operation_subtype)}.map{|o| o.amount}.sum.round(2),
          col_16: operations.select{|o| o.operation_subtype == "col_16"}.map{|o| o.amount}.sum.round(2)
        } 
      end.sort_by{|h| h[:date]}
    end
  end

end


# grouped_incomings_operations = @operations.select{|o| o.is_a? Incoming}.group_by{|o| o.category_id}.map do |category_id, operations|
#   {category_id: category_id, category: @categories.find(category_id).category_name, sum: operations.map{|o| o.amount}.sum.round(2), operations: operations.sort_by{|o| o.date}.reverse}
# end.sort_by{|h| h[:category]}