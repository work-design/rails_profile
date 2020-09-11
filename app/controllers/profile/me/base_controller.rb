class Profile::My::BaseController < MyController

  def current_agent
    current_member
  end

end unless defined? Profile::My::BaseController
