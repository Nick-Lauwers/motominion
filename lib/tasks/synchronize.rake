task :synchronize => :environment do
  SynchronizationWorker.perform_async
end