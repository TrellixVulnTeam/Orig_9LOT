class PropertiesController < ApplicationController
  def show
    @property = Property.find(params[:id])
    @proposal = Proposal.find_by(user_id: current_user,property_id: @property,type: params[:type])
  end
end
