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

  def update
    if Food.exists?(params[:id])
      food = Food.find(params[:id])
      if params[:food][:name] && params[:food][:calories]
        food.update(food_params)
        render json: food
      else
        render status: 400
      end
    else
      render status: 400
    end
  end

  def destroy
    if Food.exists?(params[:id])
      Food.find(params[:id]).destroy
    else
      render status: 404
    end
  end

  private

    def food_params
      params.require(:food).permit(:name, :calories)
    end
end
