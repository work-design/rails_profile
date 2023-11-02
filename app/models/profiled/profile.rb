module Profiled
  class Profile < ApplicationRecord
    include Model::Profile
    if defined? RailsCrm
      include Crm::Ext::Client
      include Crm::Ext::Agent
    end
    include Wechat::Ext::Profile if defined? RailsWechat
  end
end
