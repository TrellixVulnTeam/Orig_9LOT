class ProposalsController < ApplicationController
  #before_action :logged_in_user
  protect_from_forgery :except => [:create,:destroy]

  def create
    @property = Property.find(params[:property_id])
    if params[:type] == "Like"
      current_user.like(@property)
    elsif params[:type] == "Dislike"
      current_user.dislike(@property)
    else
    end
  end

  def destroy
    @property = Property.find(params[:id])
    if params[:type] == "Like"
      current_user.unhave(@property)
    elsif params[:type] == "Dislike"
      current_user.unwant(@property)
    else
    end
  end
end
