class PropertiesController < ApplicationController
  def show
    @property = Property.find(params[:id])
    @proposal = Proposal.find_by(user_id: current_user,property_id: @property)
    @comment = @proposal.comments
    @comment_new = @proposal.comments.new
  end
end
