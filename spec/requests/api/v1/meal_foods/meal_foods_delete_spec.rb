require 'rails_helper'

describe 'delete /api/v1/meals/:meal_id/foods/:id' do
  it 'should return a status code of 201 with a specific message' do
    meal1 = Meal.create(name: 'Breakfast')
    food1 = Food.create(name: 'Banana', calories: 150)
    MealFood.create(meal_id: meal1.id, food_id: food1.id)

    expected = {
      "id": meal1.id,
      "name": meal1.name,
      "foods": [
        {
          "id": food1.id,
          "name": food1.name,
          "calories": food1.calories
        }
      ]
    }

    get "/api/v1/meals/#{meal1.id}/foods"

    meal = JSON.parse(response.body, symbolize_names: true)
    expect(meal).to eq(expected)

    message = { "message": "Successfully removed #{food1.name} from #{meal1.name}" }

    delete "/api/v1/meals/#{meal1.id}/foods/#{food1.id}"

    expect(response.status).to eq(201)
    successful_response = JSON.parse(response.body, symbolize_names: true)
    expect(successful_response).to eq(message)

    get "/api/v1/meals/#{meal1.id}/foods"

    new_expectation = {
      "id": meal1.id,
      "name": meal1.name,
      "foods": []
    }

    new_meal = JSON.parse(response.body, symbolize_names: true)

    expect(new_meal).to eq(new_expectation)
  end
end

describe 'failed delete request to meal foods api' do
  it 'should return a 404 if food id is not found' do
    meal1 = Meal.create(name: 'Breakfast')
    food1 = Food.create(name: 'Banana', calories: 150)
    MealFood.create(meal_id: meal1.id, food_id: food1.id)
    nonexistent_id = 1000000

    delete "/api/v1/meals/#{meal1.id}/foods/#{nonexistent_id}"

    expect(response.status).to eq(404)
  end

  it 'should return a 404 if meal id is not found' do
    meal1 = Meal.create(name: 'Breakfast')
    food1 = Food.create(name: 'Banana', calories: 150)
    MealFood.create(meal_id: meal1.id, food_id: food1.id)
    nonexistent_id = 1000000

    delete "/api/v1/meals/#{nonexistent_id}/foods/#{food1.id}"

    expect(response.status).to eq(404)
  end
end
