class ClockPolicy

  regulate_broadcast do |policy|
    policy.send_all.to(user)
  end

  allow_create { acting_user && user == acting_user }
  allow_destroy { acting_user && user == acting_user }

end
