class RemoveImageUrlFromSuperheros < ActiveRecord::Migration[5.0]
  def change
    remove_column :superheros, :image_url
  end
end
