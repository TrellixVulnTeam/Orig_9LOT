class UserhopesController < ApplicationController
  def new
    if current_user
      @userhope = Userhope.new
    else
      flash.notice = "ログインして下さい"
      redirect_to new_user_registration_url
    end
  end
  def create
    @userhope = current_user.userhope.new(userhope_params)
    if @userhope.save
      redirect_to home_index_path
    else
      render 'new'
    end
  end

  private

  def userhope_params
    params.require(:userhope).permit(:place, :rent, :breadth)
  end
end
