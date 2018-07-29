class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :foods

  def foods
    {
      'id': food.id,
      'name': food.name,
      'calories': food.calories
    }
  end
end
