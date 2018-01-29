class AddUniverseToSuperheros < ActiveRecord::Migration[5.0]
  def change
    add_column :superheros, :universe, :integer, default: 0, null: false
  end
end
