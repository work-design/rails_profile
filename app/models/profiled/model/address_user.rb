module Profiled
  module Model::AddressUser
    extend ActiveSupport::Concern

    included do
      attribute :commission_ratio, :decimal, precision: 4, scale: 2, default: 0, comment: '佣金比例'
      attribute :kind, :string
      attribute :role, :string, default: 'ordinary'

      belongs_to :address, inverse_of: :address_users
      belongs_to :user, class_name: 'Auth::User'
      belongs_to :inviter, class_name: 'Auth::User', optional: true

      has_many :shipments, as: :shipping

      enum role: {
        principal: 'principal',
        ordinary: 'ordinary'
      }

      enum kind: {
        transport: 'transport',
        forwarder: 'forwarder',
        invoice: 'invoice'
      }
    end

  end
end
