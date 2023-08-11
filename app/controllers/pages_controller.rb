class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def upvote
    current_user.increment!(:counter)
    redirect_to root_path
  end
end
