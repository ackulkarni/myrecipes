require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
   def setup
    @chef  = Chef.create!(chefname: "ack" , email: "ack@gmail.com",
                           password: "password",password_confirmation: "password")
    @chef1 = Chef.create!(chefname:  "john", email: "john@example.com",
                    password: "password", password_confirmation: "password") 
    @admin = Chef.create!(chefname:  "john1", email: "john1@example.com",
                    password: "password", password_confirmation: "password",admin: true) 
                         
   end
   
   test " Should get chefs listing" do 
     get chefs_path
     assert_template 'chefs/index'
     assert_select "a[href=?]" ,chef_path(@chef),text:
     @chef.chefname.capitalize
     assert_select "a[href=?]", chef_path(@chef1),text:
     @chef1.chefname.capitalize
   
   end
   
   test "should delete chef" do
    sign_in_as(@admin,"password")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count' , -1 do
     delete chef_path(@chef1)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
   end
    
   
   
end   
   
