require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef  = Chef.create!(chefname: "ack" , email: "ack@gmail.com",
                          password: "password",password_confirmation: "password")
  end
  
  test " Reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname:" ", email: "ack@gmail.com"}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  
  test " accept valid signup" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname:"ack ", email: "ack@gmail.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "ack",@chef.chefname
    assert_match "ack@gmail.com", @chef.email
  end
  
  
  
end
