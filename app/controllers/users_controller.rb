class UsersController < ApplicationController
  def show
  	@user = User.find_by(id: params[:id])
  	#binding.pry
  end
  
  def new
  	@user =User.new
  end
end
