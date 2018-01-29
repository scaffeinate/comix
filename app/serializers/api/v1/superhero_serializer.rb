class Api::V1::SuperheroSerializer < Api::V1::MinimalSuperheroSerializer
  attributes :page_id, :identity, :align, :eye, :hair, :sex, :gsm, :alive, :num_appearances, :first_appearance, :year
end
