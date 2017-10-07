require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef  = Chef.create!(chefname: "ack" , email: "ack@gmail.com")
    @recipe = Recipe.create(name:" vegetable saute" , description: "great vegetable saute add vegetable and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name:" vegetablegrill" , description: "great vegetable saute add vegetable and oil")
    @recipe2.save
    
  end
  
  test "Should get recipe index " do 
    get recipes_url
    assert_response :success
  end 
  
  test "Should get recipe listing " do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name,response.body
  end   
end
