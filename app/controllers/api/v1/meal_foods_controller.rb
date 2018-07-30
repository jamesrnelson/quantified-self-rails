class Api::V1::MealFoodsController < ApplicationController
  def create
    if Meal.exists?(params[:meal_id]) && Food.exists?(params[:id])
      meal = Meal.find(params[:meal_id])
      food = Food.find(params[:id])
      MealFood.create(meal_id: meal.id, food_id: food.id)
      render json: { message: "Successfully added #{food.name} to #{meal.name}" }.to_json , status: 201
    else
      render status: 404
    end
  end
end
