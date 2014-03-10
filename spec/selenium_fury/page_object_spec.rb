require 'spec_helper'

describe SeleniumFury::PageObject do
  let(:test_page) { TestPage.new(driver) }
  before(:all) { start_web_driver(TEST_PAGE_URL) }
  after(:all) { stop_web_driver }
  after(:each) do
    Object.instance_eval { remove_const :TestPage } if Object.const_defined? :TestPage
    load 'test_page/test_page.rb'
  end

  it "PageObject provides a method to return all SeleniumFury::Elements::GenericElement defined in the class" do
    test_page.class.elements.should have(42).elements
    test_page.send(test_page.class.elements[0]).should be_a(SeleniumFury::Elements::GenericElement)
  end

  it "should return a list of unexpected missing elements" do
    test_page.missing_elements.should == {:input_hidden_element=>{:id=>"input_hidden"}}
  end

  it "should return a list of unexpected missing elements when provided a list of elements" do
    test_page.missing_elements([:input_button_element, :input_msg_button_element, :input_reset_element]).should be_empty
    test_page.missing_elements([:input_hidden_element]).should  == {:input_hidden_element=>{:id=>"input_hidden"}}
  end

  it "should show on expected page" do
    test_page.expected_location?('spec/test_page/test_page.html').should be_false
  end

end
