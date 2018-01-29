class AddSlugToSuperheros < ActiveRecord::Migration[5.0]
  def change
    add_column :superheros, :slug, :string
    add_index :superheros, :slug, unique: true
  end
end
