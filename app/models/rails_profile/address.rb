class Address < ApplicationRecord
  belongs_to :area, optional: true
  belongs_to :buyer, polymorphic: true

  enum kind: {
    transport: 'transport',
    forwarder: 'forwarder',
    invoice: 'invoice'
  }


end unless RailsTrade.config.disabled_models.include?('Address')
