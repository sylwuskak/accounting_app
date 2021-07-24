class ContributionsController < ApplicationController
    before_action :authenticate_user!

    def index
      @contributions = current_user.contributions.order(date: :desc).paginate(:page => params[:page], :per_page => 10)
    end
  
    def create
      begin
        c = Contribution.new(contribution_params)
        c.user = current_user
        c.save!

      rescue => e
        flash[:danger] = I18n.t('contributions.save_failure')
      end
  
      redirect_to contributions_path
    end
  
    def update 
      begin
        @contribution = Contribution.find(params[:id])
        @contribution.update!(contribution_params)
      rescue => e
        flash[:danger] = I18n.t('contributions.save_failure')
      end
      redirect_to contributions_path  
    end
  
    def destroy
      Contribution.destroy(params[:id])
      redirect_to contributions_path
    end
  
    private
  
    def contribution_params
      params.require(:contribution).permit(:contribution_type, :date, :amount)  
    end  
  end
  