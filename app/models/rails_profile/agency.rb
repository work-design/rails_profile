module RailsProfile::Agency
  extend ActiveSupport::Concern
  
  included do
    attribute :relation, :string, default: 'unknown'
    attribute :commission_ratio, :decimal, precision: 4, scale: 2, comment: '交易时抽成比例'
    attribute :note, :string, comment: '备注'
    
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
  end
  
  def name
    "#{relation_i18n} #{client.real_name}"
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
