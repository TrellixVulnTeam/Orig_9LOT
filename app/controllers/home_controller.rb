class HomeController < ApplicationController
  def index
    @likes = current_user.likes
    @dislikes = current_user.dislikes
    @properties = current_user.properties
    @nonevaluations = current_user.nonevaluations
  end

end
