module RailsProfile::Agent
  extend ActiveSupport::Concern

  included do
    has_many :agent_agencies, class_name: 'Agency', as: :agent, dependent: :delete_all, inverse_of: :agent
    Agency.client_types.each do |client_type|
      has_many :"#{client_type.underscore}_clients", through: :agent_agencies, source: :client, source_type: client_type
    end
    has_many :agent_maintains, class_name: 'Maintain', foreign_key: :agent_id, inverse_of: :agent
    accepts_nested_attributes_for :agent_agencies, reject_if: :all_blank
  end


end
