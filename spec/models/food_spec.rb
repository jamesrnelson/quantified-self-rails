require 'rails_helper'

describe Food do
  it 'Attributes' do
    food1 = Food.create(name: 'Banana', calories: 150)

    expect(food1.name).to eq('Banana')
    expect(food1.calories).to eq(150)
  end
end
