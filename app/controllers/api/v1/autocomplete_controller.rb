class Api::V1::AutocompleteController < ApplicationController
  def index
    autocomplete = Autocomplete.new
    results = autocomplete.fetch_results(autocomplete_params)
    if results.nil? || results.empty?
      render json: { error: "No results found" }, status: :not_found
    else
      render json: results, status: :ok
    end
  end

  private
  def autocomplete_params
    params.permit(:query, :num_results)
  end
end
