require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "ack",email: "ack@gmail.com")
  end
  
  # test "should be valid" do
  # assert @chef.valid?
  # end
  
  test  " chefname should be valid" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname shoud be lass than 30 character" do  
   @chef.chefname = "a"*31
    assert_not @chef.valid?
  end
  
  test "email shoud be present" do
    @chef.email =" "
    assert_not @chef.valid?
  end
  
  test "email should not be too long" do
    @chef.email = "a"*245 + "@example.com"
    assert_not @chef.valid?
    end
  
  test "email should be correct format" do
    valid_emails = %w[john@yahoo.co.uk ACK.kj@yahoo.org johns+tssy@aol.com] 
    valid_emails.each do  |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "Should reject invalid address" do
    invalid_emails = %w[msd@example ack@example,com ack.foo@gmail.coe@f00+bar]
    invalid_emails.each do |invalids|
      @chef.email = invalids
    end
  end
  
  test "Email should be unique and case sensitive" do 
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  
  test "Email should be lower case before hitting db " do
    mixed_email = 'JobHn@gmail.com'
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end
  
end
