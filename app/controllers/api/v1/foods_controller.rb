class Api::V1::FoodsController < ApplicationController
  def index
    render json: Food.all
  end

  def show
    if Food.exists?(params[:id])
      render json: Food.find(params[:id])
    else
      render status: 404
    end
  end

  def create
    food = Food.new(food_params)
    if food.save
      render json: food
    else
      render status: 400
    end
  end

  private

    def food_params
      params.permit(:name, :calories)
    end
end
