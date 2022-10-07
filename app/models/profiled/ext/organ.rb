module Profiled
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_many :addresses, class_name: 'Profiled::Address'

      has_one :default_address, class_name: 'Profiled::Address'
    end

  end
end
