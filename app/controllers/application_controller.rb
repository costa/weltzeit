class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def acting_user
    current_user  # NOTE from devise
  end

end
