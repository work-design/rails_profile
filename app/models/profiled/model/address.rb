module Profiled
  module Model::Address
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :detail, :string
      attribute :contact_person, :string
      attribute :tel, :string
      attribute :post_code, :string
      attribute :source, :string
      attribute :cached_key, :string
      attribute :principal, :boolean, default: false

      has_taxons :area
      belongs_to :area, class_name: 'Profiled::Area'
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :user, class_name: 'Auth::User', optional: true
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :member_organ, class_name: 'Org::Organ', optional: true

      belongs_to :account, -> { confirmed }, class_name: 'Auth::Account', foreign_key: :tel, primary_key: :identity, optional: true

      has_many :address_uses, inverse_of: :address, dependent: :destroy_async

      before_validation :sync_cached_key
      after_update :set_principal, if: -> { principal? && saved_change_to_principal? }
    end

    def sync_cached_key
      self.cached_key = [area_id, detail, contact_person, tel].join(',')
    end

    def content
      "#{area.full_name} #{detail}"
    end

    def contact_info
      "#{contact_person} #{tel}"
    end

    def set_principal
      self.class.where.not(id: self.id).where(user_id: self.user_id, member_id: self.member_id).update_all(principal: false)
    end

  end
end
