module RailsProfile::Client
  extend ActiveSupport::Concern

  included do
    has_many :agencies, foreign_key: :client_id, dependent: :delete_all, inverse_of: :client
    has_many :agents, through: :agencies
    has_many :client_maintains, class_name: 'Maintain', foreign_key: :client_id, inverse_of: :client
    accepts_nested_attributes_for :agencies, reject_if: :all_blank
  end


end
