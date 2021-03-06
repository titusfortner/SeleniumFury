require 'spec_helper'

describe SeleniumFury::Elements::CheckboxElement do

  let(:test_page) { TestPage.new(driver) }
  before(:all) { start_web_driver(TEST_PAGE_URL) }
  after(:all) { stop_web_driver }

  it 'should check a checkbox not checked' do
    test_page.input_checkbox_element.check_box(false)
    test_page.input_checkbox_element.selected?.should be_false
    test_page.input_checkbox_element.check_box(true)
    test_page.input_checkbox_element.selected?.should be_true
  end

  it 'should leave a checkbox checked when already checked' do
    test_page.input_checkbox_element.check_box(false)
    test_page.input_checkbox_element.select
    test_page.input_checkbox_element.selected?.should be_true
    test_page.input_checkbox_element.check_box(true)
    test_page.input_checkbox_element.selected?.should be_true
  end

  it 'should uncheck a checkbox when checked' do
    test_page.input_checkbox_element.check_box(false)
    test_page.input_checkbox_element.select
    test_page.input_checkbox_element.selected?.should be_true
    test_page.input_checkbox_element.check_box(false)
    test_page.input_checkbox_element.selected?.should be_false
  end

  it 'should leave a checkbox alone when already checked' do
    test_page.input_checkbox_element.check_box(false)
    test_page.input_checkbox_element.selected?.should be_false
    test_page.input_checkbox_element.check_box(false)
    test_page.input_checkbox_element.selected?.should be_false
  end
end