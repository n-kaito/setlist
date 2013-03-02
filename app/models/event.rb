class Event < ActiveRecord::Base
  attr_accessible :name, :open_at, :place_id
  belongs_to :place

end
