class AddImageUrlToSuperheros < ActiveRecord::Migration[5.0]
  def change
    add_column :superheros, :image_url, :text
  end
end
