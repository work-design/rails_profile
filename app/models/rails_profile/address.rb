module RailsProfile::Address
  extend ActiveSupport::Concern
  included do
    belongs_to :area, optional: true
    belongs_to :addressing, polymorphic: true
  
    enum kind: {
      transport: 'transport',
      forwarder: 'forwarder',
      invoice: 'invoice'
    }
  end

end
