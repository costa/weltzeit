class Clock < ApplicationRecord

  validates :time_zone_name, inclusion: {in: ActiveSupport::TimeZone.all.map(&:name)}  unless RUBY_ENGINE == 'opal'

end
