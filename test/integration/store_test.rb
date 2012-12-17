require 'test_helper'

class StoreTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  describe "Store" do
  	describe "index" do
  		it "should_have content 'Our Store'"
  		visit '/store/index'
  		page.should have_content('Our Store')  
 end
