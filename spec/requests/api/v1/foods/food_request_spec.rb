require 'rails_helper'

describe 'Foods API' do
  it 'returns all foods currently in the database' do
    food1 = Food.create(name: 'Banana', calories: 150)
    food2 = Food.create(name: 'Apple', calories: 100)
    food3 = Food.create(name: 'cherry', calories: 50)

    expected = [
      {
        'id': food1.id,
        'name': food1.name,
        'calories': food1.calories,
      },
      {
        'id': food2.id,
        'name': food2.name,
        'calories': food2.calories,
      },
      {
        'id': food3.id,
        'name': food3.name,
        'calories': food3.calories,
      }
    ]

    get '/api/v1/foods'

    expect(response).to be_success

    foods = JSON.parse(response.body, symbolize_names: true)
    expect(foods.count).to eq(3)
    expect(foods).to eq(expected)
  end

  it 'can show an individual food' do
    food1 = Food.create(name: 'Steak', calories: 600)
    id = food1.id

    get "/api/v1/foods/#{id}"

    expect(response).to be_success

    food = JSON.parse(response.body)
    expect(food['id']).to eq(id)
    expect(food['name']).to eq(food1.name)
    expect(food['calories']).to eq(food1.calories)
  end

  it 'returns a 404 if that specific food is not found' do
    id = 100000

    get "/api/v1/foods/#{id}"

    expect(response.status).to eq(404)
  end
end
