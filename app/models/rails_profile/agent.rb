module RailsProfile::Agent
  extend ActiveSupport::Concern

  included do
    has_many :proteges, class_name: 'Agency', foreign_key: :agent_id, dependent: :delete_all, inverse_of: :agent
    has_many :clients, through: :proteges
    has_many :agent_maintains, class_name: 'Maintain', foreign_key: :agent_id, inverse_of: :tutelar
    accepts_nested_attributes_for :proteges, reject_if: :all_blank
  end


end
