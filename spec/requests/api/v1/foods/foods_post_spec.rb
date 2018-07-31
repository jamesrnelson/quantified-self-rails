require 'rails_helper'

describe 'post request to /api/v1/foods' do
  it 'should be able to post' do
    food1 = Food.create(name: 'Milkshake', calories: 875)

    expected = {
      'id': food1.id + 1,
      'name': food1.name,
      'calories': food1.calories
    }

    post "/api/v1/foods", params: { food: { name: food1.name, calories: food1.calories } }

    expect(response).to be_success
    new_food = JSON.parse(response.body, symbolize_names: true)
    expect(new_food).to eq(expected)
  end
end

describe 'failed post to /api/v1/foods' do
  it 'should receive a 400 status code if post request does not contain name or calories' do
    food1 = Food.new(name: 'Milkshake', calories: 875)

    post "/api/v1/foods", params: { food: { calories: food1.calories } }

    expect(response.status).to eq(400)

    post "/api/v1/foods", params: { food: { name: food1.name } }

    expect(response.status).to eq(400)
  end
end
