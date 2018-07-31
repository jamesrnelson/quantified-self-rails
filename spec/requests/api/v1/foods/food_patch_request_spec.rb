require 'rails_helper'

describe 'patch request to /api/v1/foods' do
  it 'should be able to patch' do
    food1 = Food.create(name: 'Milkshake', calories: 875)
    new_calories = 25

    expected1 = {
        'id': food1.id,
        'name': food1.name,
        'calories': food1.calories
    }


    get "/api/v1/foods/#{food1.id}"

    expect(response).to be_success
    food = JSON.parse(response.body, symbolize_names: true)
    expect(food).to eq(expected1)

    patch "/api/v1/foods/#{food1.id}", params: { food: { name: food1.name, calories: new_calories } }

    expected2 = {
      'id': food1.id,
      'name': food1.name,
      'calories': new_calories
    }

    # expect(response).to be_success
    updated_food = JSON.parse(response.body, symbolize_names: true)
    expect(updated_food).to eq(expected2)
  end
end

describe 'failed patch to /api/v1/foods' do
  it 'should receive a 400 status code if patch request does not find food of that id' do
    food1 = Food.new(name: 'Milkshake', calories: 875)
    bad_id = 1000000

    patch "/api/v1/foods/#{bad_id}", params: { food: { name: food1.name, calories: 3000 } }

    expect(response.status).to eq(400)
  end
end

describe 'failed patch because of not all attributes provided' do
  it 'should receive a 400 status code if patch request does not contain name or calories' do
    food1 = Food.create(name: 'Milkshake', calories: 875)
    new_food_name = 'Hobgoblin'
    new_food_calories = 5000

    patch "/api/v1/foods/#{food1.id}", params: { food: { name: new_food_name } }

    expect(response.status).to eq(400)

    patch "/api/v1/foods/#{food1.id}", params: { food: { calories: new_food_calories } }

    expect(response.status).to eq(400)
  end
end
