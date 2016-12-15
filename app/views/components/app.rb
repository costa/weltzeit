class App < React::Component::Base

  before_mount do
    @utc_time_sec = utc_time_sec
  end
  after_mount do
    @timer = every(0.1) do
      next unless @utc_time_sec != utc_time_sec
      @utc_time_sec = utc_time_sec
      @timepieces.each do |timepiece|
        # XXX Doesn't work just yet! timepiece.utc_time_sec! @utc_time_sec
      end
    end
  end

  before_unmount do
    @timer.stop
  end

  render do

    DIV.world do
      clocks = Clock.all
      @timepieces = [Timepiece(title: "Local", utc_time_sec: @utc_time_sec)]
      clock_time_zones = {}
      clocks.each do |clock|
        @timepieces << Timepiece(title: clock.time_zone_name, clock: clock, utc_time_sec: @utc_time_sec)
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
          Clock.create time_zone_name: time_zone_name  if time_zone_name != 'prompt'  # NOTE just to be certain
        end  unless clock_time_zones.size == Timepiece::TIME_ZONES.size
      end
    end
  end

  def utc_time_sec
    `Date.now()/1000`.to_i
  end
end
