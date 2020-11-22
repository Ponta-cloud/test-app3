class ServiceUsersController < ApplicationController
  def index
    @details       = EventDetail.select(:event_title, :group_id).includes(:group)
  end  
  def show

  end
  
  def login
    @user = ServiceUser.find_by(name: params[:name],password: params[:password])
    # @userが存在するかどうかを判定するif文を作成してください
    if @user
      @group = Group.where(group_name: params[:name])
      render("users/show")
    else
      render("users/login_form")
    end
  end
  def new
    @user = ServiceUser.new
  end  
  def create
    user = ServiceUser.new(
      name: params[:name],
      password: params[:password]
      ) 
    user.save  
    redirect_to("/")
     
  end
  def login_form
  end
end
