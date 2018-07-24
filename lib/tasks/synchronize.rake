task :synchronize => :environment do
  ExternalDb::Source.all.each(&:sync_to_dealership)
  ExternalDb::Vehicle.all.each(&:sync_to_vehicle)
  ExternalDb::Picture.all.each(&:sync_to_photo)
end