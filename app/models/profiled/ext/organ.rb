module Profiled
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_many :address_organs, class_name: 'Profiled::AddressOrgan', inverse_of: :organ, dependent: :delete_all
      has_many :addresses, class_name: 'Profiled::Address'

      has_one :default_address_organ, -> { where(default: true) }, class_name: 'Profiled::AddressOrgan'
      has_one :default_address, class_name: 'Profiled::Address', through: :default_address_organ, source: :address
    end

  end
end
