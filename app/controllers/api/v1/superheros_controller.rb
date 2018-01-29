class Api::V1::SuperherosController < ApplicationController
  def index
    # page = params[:page] ? params[:page] : 1
    # order_by = params[:order_by] ? params[:order_by] : :id
    # superheros = Superhero.where(universe: universe).order(order_by).paginate(page: page)
    # if superheros.empty?
    #   render json: { error: "No superhero found" }, status: :not_found
    # else
    #   render json: {
    #     superheros: ActiveModelSerializers::SerializableResource.new(
    #                 superheros,
    #                 each_serializer: Api::V1::MinimalSuperheroSerializer),
    #     page: page
    #   }, status: :ok
    # end
  end

  def show
    @superhero = Superhero.friendly.find(params[:id])
    render json: @superhero, serializer: Api::V1::SuperheroSerializer
  end
end
