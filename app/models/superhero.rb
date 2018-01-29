class Superhero < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  self.per_page = 25

  enum universe: {
      marvel: 1,
      dc: 2
  }

  def wiki_url
    "#{self.universe}.wikia.com/wiki/#{self.urlslug[2..urlslug.length-1]}"
  end
end
