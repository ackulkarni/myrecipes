require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create!(chefname: "ack", email: "ack@example.com",
                         password: "password",password_confirmation: "password")
    
    @recipe = @chef.recipes.build(name: "vegetable" , description: "great recipe")
  end
  
  test "Recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
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
 
  