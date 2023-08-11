class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def upvote
    current_user.increment!(:counter)
    render_counter
  end

  private

  def render_counter
    render turbo_stream:
      turbo_stream.replace(
        "counter",
        partial: "pages/counter",
        locals: { counter: current_user.counter }
      )
  end
end
