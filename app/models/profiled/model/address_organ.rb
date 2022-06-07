module Profiled
  module Model::AddressOrgan
    extend ActiveSupport::Concern

    included do
      attribute :kind, :string
      attribute :default, :boolean, default: false

      belongs_to :organ, class_name: 'Org::Organ', inverse_of: :address_organs

      belongs_to :address, inverse_of: :address_organs
      accepts_nested_attributes_for :address

      has_many :shipments, as: :shipping

      after_update :set_default, if: -> { default? && saved_change_to_default? }
    end

    def set_default
      self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(default: false)
    end

  end
end
