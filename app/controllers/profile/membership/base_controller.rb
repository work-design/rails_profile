class Profile::Membership::BaseController < RailsProfile.config.membership_controller.constantize

  def current_agent
    current_member
  end
  
end
