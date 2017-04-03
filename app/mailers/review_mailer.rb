class ReviewMailer < ApplicationMailer

  def review_received(review)
    @review = review
    mail to: review.reviewed.email, subject: "You Received A Review!"
  end
end
