# require 'test_helper'

# class PhotoTest < ActiveSupport::TestCase
  
#   def setup
#     @vehicle = vehicles(:avalanche)
#     @photo = Photo.new(vehicle_id: @vehicle.id, 
#                       image:      appointment_photo("fixture-photo.jpg"))
#   end

#   test "should be valid" do
#     assert @photo.valid?
#   end

#   test "vehicle id should be present" do
#     @photo.vehicle_id = nil
#     assert_not @photo.valid?
#   end
  
#   test "image should be present" do
#     @photo.image = nil
#     assert_not @photo.valid?
#   end
# end