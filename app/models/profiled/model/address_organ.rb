module Profiled
  module Model::AddressOrgan
    extend ActiveSupport::Concern

    included do
      attribute :kind, :string
      attribute :default, :boolean, default: false

      belongs_to :organ, class_name: 'Org::Organ'

      belongs_to :address, inverse_of: :address_organs

      has_many :shipments, as: :shipping

      enum kind: {
        transport: 'transport',
        forwarder: 'forwarder',
        invoice: 'invoice'
      }
    end

  end
end
