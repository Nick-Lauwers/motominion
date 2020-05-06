# Preview all emails at http://localhost:3000/rails/mailers/review_mailer
class ReviewMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/review_mailer/review_received
  def review_received
    review = Review.first
    ReviewMailer.review_received(review)
  end
end