class UsersController < ApplicationController
  def new
  end

  def create
    if User.find_by({ "email" => params["email"] }) == nil
      @user = User.new
      @user["username"] = params["username"]
      @user["email"] = params["email"]
      @user["password"] = BCrypt::Password.create(params["password"])
      @user.save
      session["user_id"] = @user["id"]
      redirect_to "/places"
    else
      flash["notice"] = "Email taken."
      redirect_to "/login"
    end
  end
end