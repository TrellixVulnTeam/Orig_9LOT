class CommentsController < ApplicationController
  def create
    binding.pry
    @comment = Property.find(params[:property_id]).new
    def create
      @property = Property.find(params[:property_id])
      if params[:type] == "Like"
        current_user.like(@property)
      elsif params[:type] == "Dislike"
        current_user.dislike(@property)
      else
      end
    end
  end
end
