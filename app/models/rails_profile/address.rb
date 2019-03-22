class Address < ApplicationRecord
  belongs_to :area, optional: true
  belongs_to :addressing, polymorphic: true

  enum kind: {
    transport: 'transport',
    forwarder: 'forwarder',
    invoice: 'invoice'
  }


end unless RailsProfile.config.disabled_models.include?('Address')
