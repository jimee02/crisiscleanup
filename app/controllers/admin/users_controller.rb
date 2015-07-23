module Admin
  class UsersController < ApplicationController
    include ApplicationHelper
    before_filter :check_admin?
    # add logic to only allow ccu admins to access this
    # before_filter :deny_access, :unless => :is_ccu_admin?
    def index
        # todo implement search and sort and paginate
        @users = User.paginate(:page => params[:page])
    end
    def new
    	@user = User.new
    end
    def create       
        @user = User.new(site_params) 
        if @user.save
         	redirect_to admin_users_path
        else
            render :new
        end 
    end
    def edit        
        @user = User.find(params[:id])
    end
    def update
        @user = User.find(params[:id])
        if  @user.update_attributes(site_params)
            redirect_to admin_users_path
        else
            redirect_to edit_admin_user_path(@user.id)
        end
    end
    private
	    def site_params
	        params.require(:user).permit(
            :admin, :email, :name, :password,
            :legacy_organization_id, :verified)
	    end
  end
end