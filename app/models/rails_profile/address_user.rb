module RailsProfile::AddressUser
  extend ActiveSupport::Concern

  included do
    attribute :commission_ratio, :decimal, precision: 4, scale: 2, default: 0, comment: '佣金比例'
    attribute :kind, :string

    belongs_to :address, inverse_of: :adddress_users
    belongs_to :user
    belongs_to :inviter, class_name: 'User', optional: true

    has_many :shipments, as: :shipping

    enum kind: {
      transport: 'transport',
      forwarder: 'forwarder',
      invoice: 'invoice'
    }
  end

end
