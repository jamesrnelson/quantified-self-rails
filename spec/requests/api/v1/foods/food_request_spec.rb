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
end
