class CreateSuperheros < ActiveRecord::Migration[5.0]
  def change
    create_table :superheros do |t|
      t.string :page_id, null: false
      t.string :name, null: false
      t.text :urlslug
      t.string :identity
      t.string :align
      t.string :eye
      t.string :hair
      t.string :sex
      t.string :gsm
      t.string :alive
      t.integer :num_appearances, default: 0
      t.string :first_appearance
      t.integer :year, default: 0
      t.timestamps
    end
  end
end
