require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
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
  
  test "Reject an invalid edit" do
    sign_in_as(@chef,"password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname:" ", email: "ack@gmail.com"}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  
  test "accept valid edit" do
    sign_in_as(@chef,"password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname:"ack ", email: "ack@gmail.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "ack",@chef.chefname
    assert_match "ack@gmail.com", @chef.email
  end
  
  test "Accept edit attempt by  valid user" do
     sign_in_as(@admin,"password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname:"ack", email: "ack@gmail.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "ack",@chef.chefname
    assert_match "ack@gmail.com", @chef.email

  end
  
  test " redirect edit attempt by another non-admin user" do 
    sign_in_as(@chef1,"password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: {chef: { chefname: updated_name, email: updated_email}}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "ack", @chef.chefname
    assert_match "ack@gmail.com", @chef.email  
  
  end

end