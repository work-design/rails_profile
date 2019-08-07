require 'active_support/configurable'

module RailsProfile #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_controller = 'ApplicationController'
    config.my_controller = 'OrgController'
    config.admin_controller = 'AdminController'
    config.member_controller = 'MemberController'
  end

end


