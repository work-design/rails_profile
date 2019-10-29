class RailsProfileInit < ActiveRecord::Migration[5.2]
  def change

    create_table :areas do |t|
      t.string :name
      t.string :names, array: true
      t.references :parent
      t.boolean :published, default: true
      t.boolean :popular, default: false
      t.timestamps
    end

    create_table :area_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
      t.index [:ancestor_id, :descendant_id, :generations], unique: true, name: 'area_anc_desc_idx'
      t.index [:descendant_id], name: 'area_desc_idx'
    end

    create_table :addresses do |t|
      t.references :area
      t.references :addressing, polymorphic: true
      t.string :address
      t.string :kind
      t.timestamps
    end

    create_table :profiles do |t|
      t.references :user
      t.references :organ
      t.string :type
      t.string :real_name
      t.string :nick_name
      t.string :gender
      t.string :birthday_type
      t.date :birthday
      t.string :identity
      t.string :degree
      t.string :major
      if connection.adapter_name == 'PostgreSQL'
        t.jsonb :extra
      else
        t.json :extra
      end
      t.timestamps
    end

    create_table :agencies do |t|
      t.references :agent, polymorphic: true
      t.references :client, polymorphic: true
      t.string :relation
      t.timestamps
    end

  end
end
