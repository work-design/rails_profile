module RailsProfile::Agency
  extend ActiveSupport::Concern
  
  included do
    attribute :relation, :string, default: 'unknown'
    
    belongs_to :agent, polymorphic: true
    belongs_to :client, polymorphic: true
   
    has_many :cards, dependent: :nullify
    
    accepts_nested_attributes_for :agent, reject_if: :all_blank
    accepts_nested_attributes_for :client, reject_if: :all_blank
  
    enum relation: {
      son: 'son',
      grandson: 'grandson',
      nephew: 'nephew',
      unknown: 'unknown'
    }
  
    before_validation :sync_from_maintain, if: -> { self.maintain.present? }
  end
  
  def name
    "#{relation_i18n} #{pupil.real_name}"
  end
  
  def sync_from_maintain
    self.agent = maintain.agent
    self.client = maintain.client
  end
  
  class_methods do
    def agent_types
      self.unscoped.select(:agent_type).distinct.pluck(:agent_type).sort!
    end
    
    def client_types
      self.unscoped.select(:client_type).distinct.pluck(:client_type).sort!
    end
  end

end
