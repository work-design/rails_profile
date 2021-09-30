# frozen_string_literal: true
module Profiled
  module Model::Area
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :full, :string
      attribute :published, :boolean, default: true
      attribute :popular, :boolean, default: false
      attribute :names, :string, array: true
      attribute :timezone, :string
      attribute :locale, :string
      attribute :code, :string

      validates :name, presence: true

      scope :popular, -> { where(popular: true) }

      default_scope -> { where(published: true) }

      after_save_commit :sync_names, if: -> { saved_change_to_name? || saved_change_to_parent_id? }
      after_commit :sync_children_names
      after_save_commit :update_timestamp, :delete_cache, on: [:create, :update]
    end

    def full_name
      names.join(' / ')
    end

    # todo sync after destroy parent
    def sync_names
      self.names = self.self_and_ancestors.pluck(:name).reverse
      self.save
    end

    def sync_children_names

    end

    def tree_lists(value_name: 'id', label_name: 'name')
      children.map do |child|
        {
          value_name => child.id,
          label_name => child.name,
          children: child.tree_lists(value_name: value_name, label_name: label_name)
        }
      end
    end

    private
    def delete_cache
      ['areas/popular', 'areas/all_nations'].each do |c|
        Rails.cache.delete(c)
      end
      #Rails.cache.delete_matched 'areas/list/*'
    end

    def update_timestamp
      t = self.updated_at.to_i
      Rails.cache.write('areas/timestamp', t)
    end

    class_methods do

      def rebuild_names
        find_each do |area|
          area.sync_names
        end
      end

      def timestamp
        Rails.cache.fetch('areas/timestamp') do
          order(updated_at: :desc).last.updated_at.to_i
        end
      end

      def list(value_name: 'id', label_name: 'name')
        Rails.cache.fetch("areas/list/#{value_name}/#{label_name}") do
          roots.map do |root|
            {
              value_name => root.id,
              label_name => root.name,
              children: root.tree_lists(value_name: value_name, label_name: label_name)
            }
          end
        end
      end

      # names must be an instance of Enumerator, first is root, child is after root
      def sure_find(names, parent = nil)
        names = names.to_enum unless names.is_a? Enumerator
        area = find_or_initialize_by(name: names.next)
        if parent
          area.parent = parent
        end
        area.save!
        sure_find(names, area)
      rescue StopIteration => e
        parent
      end

      # names must be an instance of Enumerator, first is root, child is after root
      def sure_find_full(names, parent = nil)
        names = names.to_enum unless names.is_a? Enumerator
        area = find_or_initialize_by(full: names.next)
        if parent
          area.parent = parent
        end
        area.save
        sure_find_full(names, area)
      rescue StopIteration => e
        parent
      end

    end


  end
end
