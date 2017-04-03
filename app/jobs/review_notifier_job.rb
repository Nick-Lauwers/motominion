class ReviewNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(appointment)
    AppointmentMailer.review_request(appointment).deliver_later(wait_until: appointment.date)
  end
end
