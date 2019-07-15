class FeedbackController < ApplicationController

  def generate
    FeedbackMailer.feedback_email(
      from: ActionController::Base.helpers.strip_tags(params[:email].first),
      user_agent: request.user_agent, 
      url: ActionController::Base.helpers.strip_tags(params[:object_url]),
      type: ActionController::Base.helpers.strip_tags(params[:feedback_type]), 
      comment: ActionController::Base.helpers.strip_tags(params[:comments])
    ).deliver_now
  end
end