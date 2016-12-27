class App < React::Component::Base

  def self.utc_time_sec
    `Date.now()/1000`.to_i
  end

  param :authenticity_token, type: String
  param :current_user, type: User, default: nil, allow_nil: true

  define_state utc_time_sec: utc_time_sec

  after_mount do
    @timer = every(0.1) do  # NOTE to keep the seconds change close to the device clock
      # NOTE I hope I can rid of the check at some point of the framework maturity
      state.utc_time_sec! self.class.utc_time_sec  if state.utc_time_sec != self.class.utc_time_sec
    end
  end

  before_unmount do
    @timer.stop
  end

  render do
    DIV.world do
      Timepiece title: "Local", utc_time_sec: state.utc_time_sec
      if params.current_user.nil?
        DIV.control do
          Signup authenticity_token: params.authenticity_token
          Signin authenticity_token: params.authenticity_token
        end
      else
        clock_time_zones = {}
        params.current_user.clocks.each do |clock|
          Timepiece title: clock.time_zone_name, clock: clock, utc_time_sec: state.utc_time_sec
          clock_time_zones[clock.time_zone_name] = true
        end

        DIV.control do
          SELECT(value: 'prompt').time_zone do
            OPTION(disabled: true, value: 'prompt') { "Add a timepiece" }
            Timepiece::TIME_ZONES.each do |time_zone_name, time_zone|
              OPTION(value: time_zone_name) do
                "#{time_zone_name} (#{time_zone[:formatted_offset]})"
              end  unless clock_time_zones[time_zone_name]
            end
          end.on(:change) do |e|
            e.target.parentElement.value = 'prompt'
            time_zone_name = e.target.value
            # TODO https://github.com/ruby-hyperloop/hyper-mesh/issues/17 params.current_user.clocks.create time_zone_name: time_zone_name  if time_zone_name != 'prompt'  # NOTE just to be certain
            Clock.create user_id: params.current_user.id, time_zone_name: time_zone_name  if time_zone_name != 'prompt'  # NOTE just to be certain
          end  unless clock_time_zones.size == Timepiece::TIME_ZONES.size

          Signout authenticity_token: params.authenticity_token
        end
      end
    end
  end
end
