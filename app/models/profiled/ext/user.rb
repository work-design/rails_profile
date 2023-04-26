module Profiled
  module Ext::User
    extend ActiveSupport::Concern

    included do
      has_many :profiles, class_name: 'Profiled::Profile'
      has_many :addresses, class_name: 'Profiled::Address'
      has_many :principal_addresses, class_name: 'Profiled::Address'
    end

  end
end
