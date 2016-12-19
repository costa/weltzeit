class ClockPolicy

  regulate_broadcast do |policy|
    policy.send_all.to(user)
  end

end
