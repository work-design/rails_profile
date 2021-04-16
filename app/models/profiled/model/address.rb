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

      has_taxons :area
      belongs_to :area, class_name: 'Profiled::Area'

      has_many :address_users, dependent: :delete_all
      has_many :users, through: :address_users

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
