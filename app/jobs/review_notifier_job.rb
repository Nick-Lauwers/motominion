class ReviewNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(appointment_id)
    appointment = Appointment.find(appointment_id)
    AppointmentMailer.review_request(appointment).deliver_later
  end
end