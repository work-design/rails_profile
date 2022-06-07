module Profiled
  module Model::Address
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :detail, :string
      attribute :contact, :string
      attribute :tel, :string
      attribute :post_code, :string
      attribute :source, :string
      attribute :cached_key, :string
      attribute :principal, :boolean, default: false

      has_taxons :area
      belongs_to :area, class_name: 'Profiled::Area'
      belongs_to :user, class_name: 'Auth::User'
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :member_organ, class_name: 'Org::Organ', optional: true

      has_many :address_uses, inverse_of: :address, dependent: :destroy_async

      before_validation :sync_cached_key
    end

    def sync_cached_key
      self.cached_key = [area_id, detail, contact, tel].join(',')
    end

    def content
      "#{area.full_name} #{detail}"
    end

  end
end
