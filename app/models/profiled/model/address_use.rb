module Profiled
  module Model::AddressUse
    extend ActiveSupport::Concern

    included do
      enum kind: {
        transport: 'transport',
        forwarder: 'forwarder',
        invoice: 'invoice'
      }

      belongs_to :address, inverse_of: :address_uses
    end

  end
end
