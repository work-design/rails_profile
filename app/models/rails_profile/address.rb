module RailsProfile::Address
  extend ActiveSupport::Concern
  included do
    attribute :name, :string
    attribute :detail, :string
    attribute :contact, :string
    attribute :tel, :string

    belongs_to :area, optional: true
    has_many :address_users, dependent: :delete_all
    has_many :users, through: :address_users
  end

end
