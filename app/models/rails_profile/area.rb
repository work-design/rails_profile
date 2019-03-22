class Area < ApplicationRecord
  prepend RailsTaxonNode

  attribute :nation, :string
  attribute :province, :string
  attribute :city, :string
  attribute :district, :string, default: ''

  scope :popular, -> { where(popular: true) }

  default_scope -> { where(published: true) }

  after_save :sync_names, if: -> { saved_change_to_name? || saved_change_to_parent_id? }
  after_commit :update_timestamp, :delete_cache, on: [:create, :update]

  def full_name
    names.join(' / ')
  end

  def sync_names
    self.names = self.self_and_ancestors.pluck(:name).reverse
    self.save
  end

  def self.list
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

  def tree_lists
    children.map do |child|
      {
        id: child.id,
        name: child.name,
        children: child.tree_lists
      }
    end
  end

  def self.timestamp
    Rails.cache.fetch('areas/timestamp') do
      order(updated_at: :desc).last.updated_at.to_i
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

end unless RailsProfile.config.disabled_models.include?('Area')
