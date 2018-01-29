class Api::V1::MinimalSuperheroSerializer < ActiveModel::Serializer
  attributes :id, :page_id, :name, :urlslug, :identity, :align, :eye, :hair, :sex, :gsm, :alive, :num_appearances, :first_appearance, :year, :universe

  def urlslug
    self.urlslug.capitalize
  end
end
