module RailsProfile::AreaHierarchy
  extend ActiveSupport::Concern

  included do
    attribute :ancestor_id, :integer, null: false
    attribute :descendant_id, :integer, null: false
    attribute :generations, :integer, null: false
    #t.index [:ancestor_id, :descendant_id, :generations], unique: true, name: 'area_anc_desc_idx'
    #t.index [:descendant_id], name: 'area_desc_idx'
  end

end
