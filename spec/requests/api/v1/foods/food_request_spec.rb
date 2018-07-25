require 'rails_helper'

describe 'Foods API' do
  it 'returns all foods currently in the database' do
    food1 = Food.create(name: 'Banana', calories: 150)
    food2 = Food.create(name: 'Apple', calories: 100)
    food3 = Food.create(name: 'cherry', calories: 50)

    get '/api/v1/foods'

    expect(response).to be_success

    foods = JSON.parse(response.body)
    expect(foods.count).to eq(3)
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
end
