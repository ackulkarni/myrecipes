require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @recipe = Recipe.new(name: "vegetable" , description: "great recipe")
  end
  
  test "recipe shoud be valid" do
   assert @recipe.valid?
  end
  
  test "Name should be present" do
    assert @recipe.name = ""
    assert_not @recipe.valid?
  end
   test "Description should be present" do
    assert @recipe.description = ""
    assert_not @recipe.valid?
  end
  test "description shoudnot be lass than 5 char" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end
  
  test "Description should not be more than 500" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
 
end
 
  