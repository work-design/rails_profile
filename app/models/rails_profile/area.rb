class Area < ApplicationRecord
  has_many :provinces, -> { where(city: '').where.not(province: '') }, class_name: 'Area', primary_key: :nation, foreign_key: :nation, dependent: :destroy
  has_many :cities, -> { where.not(city: '') }, class_name: 'Area', primary_key: :province, foreign_key: :province, dependent: :destroy

  scope :all_provinces, -> { where(city: '').where.not(province: '')}

  scope :popular, -> { where(popular: true) }

  scope :nations, ->(region_name){ where(region: region_name).group(:nation).pluck(:nation, :nation) }
  scope :provinces, ->(nation_name){ select(:province).distinct.where(nation: nation_name) }
  scope :cities, ->(province_name){ select(:city).distinct.where(province: province_name) }

  default_scope -> { where(published: true) }

  after_commit :update_timestamp, :delete_cache, on: [:create, :update]

  def self.list
    Rails.cache.fetch('areas/list') do
      nations.includes(provinces: :cities).map do |nation|
        {
          id: nation.id,
          name: nation.nation,
          provinces: nation.provinces.map do |province|
            {
              id: province.id,
              name: province.province,
              cities: province.cities.map do |city|
                { id: city.id, name: city.city }
              end
            }
          end
        }
      end
    end
  end

  def self.timestamp
    Rails.cache.fetch('areas/timestamp') do
      order(updated_at: :desc).last.updated_at.to_i
    end
  end

  def self.all_nations
    Rails.cache.fetch('areas/all_nations') do
      select(:nation).distinct.pluck(:nation)
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

end unless RailsTrade.config.disabled_models.include?('Area')
# :region
# :nation
# :province
# :city