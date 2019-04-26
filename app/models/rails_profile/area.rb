module RailsProfile::Area
  extend ActiveSupport::Concern
  included do
    prepend RailsTaxon::Node
  
    attribute :nation, :string
    attribute :province, :string
    attribute :city, :string
    attribute :district, :string, default: ''
  
    scope :popular, -> { where(popular: true) }
  
    default_scope -> { where(published: true) }
  
    after_save :sync_names, if: -> { saved_change_to_name? || saved_change_to_parent_id? }
    after_commit :update_timestamp, :delete_cache, on: [:create, :update]
  end
  
  def full_name
    names.join(' / ')
  end

  def sync_names
    self.names = self.self_and_ancestors.pluck(:name).reverse
    self.save
  end

  def tree_lists
    children.map do |child|
      {
        id: child.id,
        name: child.name,
        children: child.tree_lists
      }
    end
  end
  
  private
  def delete_cache
    ['areas/list', 'areas/popular', 'areas/all_nations'].each do |c|
      Rails.cache.delete(c)
    end
  end

  def update_timestamp
    t = self.updated_at.to_i
    Rails.cache.write('areas/timestamp', t)
  end
  
  class_methods do
    
    def timestamp
      Rails.cache.fetch('areas/timestamp') do
        order(updated_at: :desc).last.updated_at.to_i
      end
    end

    def list
      Rails.cache.fetch('areas/list') do
        roots.map do |root|
          {
            id: root.id,
            name: root.name,
            children: root.tree_lists
          }
        end
      end
    end
    
  end
  

end
