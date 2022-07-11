module Profiled
  module Ext::Account
    extend ActiveSupport::Concern

    included do
      has_many :profiles, class_name: 'Profiled::Profile', primary_key: :identity, foreign_key: :identity
      #has_many :proteges, through: :profiles
      #has_many :maintains, through: :proteges, source: :maintains
    end

  end
end
