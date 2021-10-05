module Profiled
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_many :address_organs, class_name: 'Profiled::AddressOrgan', dependent: :delete_all
      has_many :addresses, class_name: 'Profiled::Address', through: :address_organs
    end

  end
end
