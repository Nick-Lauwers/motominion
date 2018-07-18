module ExternalDb
  class Record < ActiveRecord::Base
    establish_connection EXTERNAL_DB
    self.abstract_class = true
  end
end