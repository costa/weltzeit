class Clock < ApplicationRecord

  validates :time_zone_name, inclusion: {in: ActiveSupport::TimeZone.all.map(&:name)}  unless RUBY_ENGINE == 'opal'

  scope :by_user_id, ->(user_id) { where user_id: user_id }

end
