module Profiled
  module Ext::User
    extend ActiveSupport::Concern

    included do
      has_many :addresses, class_name: 'Profiled::Address', dependent: :destroy_async
      has_many :principal_addresses, class_name: 'Profiled::Address'
    end

  end
end
