class App < React::Component::Base

  render(DIV) do
    clocks = Clock.all
    clock_time_zone_offsets = clocks.map{|clock| [clock.time_zone_name, true]}.to_h
    P { "Local time: NOW" }
    SELECT(value: 'prompt') do
      OPTION(disabled: true, value: 'prompt') { "Add a timepiece" }
      TimePiece::TIME_ZONES.each do |time_zone|
        time_zone_name = time_zone[:name]
        if clock_time_zone_offsets[time_zone_name]
          clock_time_zone_offsets[time_zone_name] = time_zone[:formatted_offset]  # NOTE the "beautiful" optimisation
        else
          OPTION(value: time_zone[:name]) { "#{time_zone_name} (#{time_zone[:formatted_offset]})" }
        end
      end
    end.on(:change) do |e|
      e.target.parentElement.value = 'prompt'
      time_zone_name = e.target.value
      Clock.create time_zone_name: time_zone_name  if time_zone_name != 'prompt'  # NOTE just to be certain
    end
    UL do
      clocks.each do |clock|
        LI do
          time_zone_name = clock.time_zone_name
          SPAN { "Time at #{time_zone_name}: NOW (#{clock_time_zone_offsets[time_zone_name]})" }
          BUTTON { 'x' }.on(:click) { clock.destroy }
        end
      end
    end
  end
end
