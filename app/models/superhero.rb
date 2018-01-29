class Superhero < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  self.per_page = 25

  enum universe: {
      marvel: 1,
      dc: 2
  }
end
