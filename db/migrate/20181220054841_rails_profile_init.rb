class RailsProfileInit < ActiveRecord::Migration[5.2]
  def change

    create_table :areas do |t|
      t.string :nation, default: ''
      t.string :province, default: ''
      t.string :city, default: ''
      t.string :district, default: ''
      t.boolean :published, default: true
      t.boolean :popular, default: false
      t.timestamps
    end

    create_table :addresses do |t|
      t.references :area
      t.references :buyer, polymorphic: true
      t.string :kind
      t.timestamps
    end

  end
end
