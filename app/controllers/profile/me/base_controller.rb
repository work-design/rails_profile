class Profile::Me::BaseController < MeController

  def current_agent
    current_member
  end

end unless defined? Profile::Me::BaseController
