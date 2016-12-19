class Clock < ApplicationRecord

  belongs_to :user

  validates :time_zone_name, inclusion: {in: ActiveSupport::TimeZone.all.map(&:name)}  unless RUBY_ENGINE == 'opal'

end
