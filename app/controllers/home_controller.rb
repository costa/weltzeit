class HomeController < ApplicationController

  def app
    render_component authenticity_token: form_authenticity_token, current_user: current_user
  end
end
