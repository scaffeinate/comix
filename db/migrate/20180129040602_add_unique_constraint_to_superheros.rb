class AddUniqueConstraintToSuperheros < ActiveRecord::Migration[5.0]
  def change
    add_index :superheros, [:universe, :page_id, :name], unique: true
  end
end
