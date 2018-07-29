require 'rails_helper'

describe 'get request to /api/v1/meals' do
  it 'should return all meals with associated foods' do
    meal1 = Meal.create(name: 'Breakfast')
    meal2 = Meal.create(name: 'Snack')
    meal3 = Meal.create(name: 'Lunch')
    meal4 = Meal.create(name: 'Dinner')

    food1 = Food.create(name: 'Banana', calories: 150)
    food2 = Food.create(name: 'Yogurt', calories: 550)
    food3 = Food.create(name: 'Apple', calories: 220)
    food4 = Food.create(name: 'Gum', calories: 50)
    food5 = Food.create(name: 'Cheese', calories: 400)
    food6 = Food.create(name: 'Bagel Bites - Four Cheese', calories: 650)
    food7 = Food.create(name: 'Chicken Burrito', calories: 800)

    MealFood.create(meal_id: meal1.id, food_id: food1.id)
    MealFood.create(meal_id: meal1.id, food_id: food2.id)
    MealFood.create(meal_id: meal1.id, food_id: food3.id)

    MealFood.create(meal_id: meal2.id, food_id: food1.id)
    MealFood.create(meal_id: meal2.id, food_id: food4.id)
    MealFood.create(meal_id: meal2.id, food_id: food5.id)

    MealFood.create(meal_id: meal3.id, food_id: food6.id)
    MealFood.create(meal_id: meal3.id, food_id: food7.id)
    MealFood.create(meal_id: meal3.id, food_id: food3.id)

    MealFood.create(meal_id: meal4.id, food_id: food1.id)
    MealFood.create(meal_id: meal4.id, food_id: food6.id)
    MealFood.create(meal_id: meal4.id, food_id: food7.id)

    expected = [
      {
        "id": meal1.id,
        "name": meal1.name,
        "foods": [
          {
            "id": food1.id,
            "name": food1.name,
            "calories": food1.calories
          },
          {
            "id": food2.id,
            "name": food2.name,
            "calories": food2.calories
          },
          {
            "id": food3.id,
            "name": food3.name,
            "calories": food3.calories
          }
        ]
      },
      {
        "id": meal2.id,
        "name": meal2.name,
        "foods": [
          {
            "id": food1.id,
            "name": food1.name,
            "calories": food1.calories
          },
          {
            "id": food4.id,
            "name": food4.name,
            "calories": food4.calories
          },
          {
            "id": food5.id,
            "name": food5.name,
            "calories": food5.calories
          }
        ]
      },
      {
        "id": meal3.id,
        "name": meal3.name,
        "foods": [
          {
            "id": food3.id,
            "name": food3.name,
            "calories": food3.calories
          },
          {
            "id": food6.id,
            "name": food6.name,
            "calories": food6.calories
          },
          {
            "id": food7.id,
            "name": food7.name,
            "calories": food7.calories
          }
        ]
      },
      {
        "id": meal4.id,
        "name": meal4.name,
        "foods": [
          {
            "id": food1.id,
            "name": food1.name,
            "calories": food1.calories
          },
          {
            "id": food6.id,
            "name": food6.name,
            "calories": food6.calories
          },
          {
            "id": food7.id,
            "name": food7.name,
            "calories": food7.calories
          }
        ]
      }
    ]

    get '/api/v1/meals'

    expect(response).to be_success

    meals = JSON.parse(response.body, symbolize_names: true)
    expect(meals.count).to eq(4)
    expect(meals).to eq(expected)
  end
end
