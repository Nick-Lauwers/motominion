class SynchronizationWorker
  include Sidekiq::Worker
  
  def perform
    ExternalDb::Source.all.each(&:sync_to_dealership)
    ExternalDb::Vehicle.all.each(&:sync_to_vehicle)
    ExternalDb::Picture.all.each(&:sync_to_photo)
  end
end