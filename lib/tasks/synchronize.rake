task :synchronize => :environment do
  ExternalDb::Picture.all.each(&:sync_to_photo)
end