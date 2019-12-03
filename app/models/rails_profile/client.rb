module RailsProfile::Client
  extend ActiveSupport::Concern

  included do
    has_many :client_agencies, class_name: 'Agency', as: :client, dependent: :delete_all, inverse_of: :client
    Agency.agent_types.each do |agent_type|
      has_many :"#{agent_type.underscore}_agents", through: :client_agencies, source: :agent, source_type: agent_type
    end
    has_many :client_maintains, class_name: 'Maintain', foreign_key: :client_id, inverse_of: :client
    accepts_nested_attributes_for :client_agencies, reject_if: :all_blank
  end


end
