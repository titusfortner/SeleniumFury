require 'spec_helper'

describe SeleniumFury::Elements::GenericElement do

  let(:test_page) { TestPage.new(driver) }
  before(:all) { start_web_driver(TEST_PAGE_URL) }
  after(:all) { stop_web_driver }

  describe "Element Types" do
    it 'should find an element by css' do
      test_page.input_message_label_element.should be_present
    end

    it 'should find an element by id' do
      test_page.input_radio_element.should be_present
    end

    it 'should find an element by name' do
      test_page.input_message_name.should be_present
    end

    it 'should find an element by class_name' do
      test_page.title_class_name.should be_present
    end

    it 'should find an element by class' do
      test_page.title_class.should be_present
    end

    it 'should find an element by tag_name' do
      test_page.legend_tag.should be_present
    end

    it 'should find an element by link_name' do
      test_page.link_element_link_name.should be_present
    end

    it 'should find an element by link' do
      test_page.link_element_link.should be_present
    end

    it 'should find an element by partial_link_name' do
      test_page.link_element_partial.should be_present
    end

    it 'should find an element by xpath' do
      test_page.label_xpath.should be_present
    end

    it 'should find an element by data' do
      test_page.element_list_data.should be_present
    end

    it 'should default to finding element by data tag' do
      test_page.listid.should be_present
    end

    it 'should find dynamic element using data tag' do
      specific_element = test_page.element_list_data_dynamic.update_locator(id: '2')
      specific_element.locator.should == {css: "[data-listid='2']"}
      specific_element.text.should == 'Two'
    end

  end

  it 'should return correct object type' do
    test_page.input_checkbox_element.should be_an SeleniumFury::Elements::CheckboxElement
  end

  it 'should return correct superclass object type' do
    test_page.input_checkbox_element.should be_an SeleniumFury::Elements::GenericElement
  end

  it 'should provide locator' do
    test_page.form_element.locator.should == {id: 'form'}
  end

  it 'should provide locator for dynamic element' do
    test_page.dynamic_locator_id.locator.should == {id: 'link__ID__'}
  end

  it 'should store the driver' do
    driver.should == test_page.form_element.driver
  end

  it 'should not store whether the element required to be present' do
    test_page.element_not_present.should_not be_required
    test_page.form_element.should be_required
  end

  it 'should store a wait value for the an element' do
    test_page.input_checkbox_element.wait.should == 10
    test_page.element_with_wait.wait.should == 5
  end

  it 'should store tags for an element' do
    test_page.element_with_tags.tags.should == [:tag1, :tag2]
  end

  it 'should store the web driver element' do
    test_page.form_element.wd_element.should be_an Selenium::WebDriver::Element
  end

  it 'should determine if elements are present' do
    test_page.element_not_present.should_not be_present
    test_page.input_hidden_element.should be_present
  end

  it 'should determine if elements are visible ' do
    test_page.form_element.should be_visible
    test_page.input_hidden_element.should_not be_visible
  end

  it 'should error if element is not present when ask if visible' do
    expect { test_page.element_not_present.present?.to raise_error }
  end

  it 'should determine if element is inaccessible whether not present or visible without giving an error' do
    test_page.element_not_present.should_not be_accessible
  end

  it 'should return the value' do
    test_page.input_button_element.value.should == 'Click me'
  end

  it 'should move to an element'
  it 'should move to a coordinate offset from an element'
  it 'should attach a file'
  it 'should drag and drop'

  describe '#double_click' do
    it 'should double-click the given element' do
      status_before = test_page.input_doubleclick['readonly']
      test_page.input_doubleclick.double_click
      status_after = test_page.input_doubleclick['readonly']

      status_after.should_not == status_before
    end
  end

  describe '#double_click!' do
    it 'should simply invoke click twice, ignoring any errors encountered on the initial click' do
      status_before = test_page.input_doubleclick['readonly']
      test_page.input_doubleclick.double_click!
      status_after = test_page.input_doubleclick['readonly']

      status_after.should == status_before # Because two #click()'s does not equal one #dblclick()
    end
  end

  describe 'Dynamic Locators' do
    it 'should allow a single dynamic selection of an element with id' do
      specific_element = test_page.dynamic_locator_id.update_locator(id: '222222')
      specific_element.locator.should == {id: 'link222222'}
      specific_element.link.should == 'http://yahoo.com/'
    end

    it 'should allow a single dynamic selection of an element with id being only value' do
      specific_element = test_page.dynamic_locator_id_complete.update_locator(id: '444444')
      specific_element.locator.should == {id: '444444'}
      specific_element.link.should == 'http://google.com/'
    end

    it 'should allow multiple dynamic selections of an element with css' do
      specific_element = test_page.dynamic_locator_css.update_locator(locator: 'id', id: '333333')
      specific_element.locator.should == {css: "a[id='link333333']"}
      specific_element.link.should == 'http://google.com/'
    end

    it 'should allow a single dynamic selection of an element with css being only value' do
      specific_element = test_page.dynamic_locator_css_complete.update_locator(id: '3')
      specific_element.locator.should == {css: "li[data-listid='3']"}
      specific_element.text == 'Three'
    end

    it 'should allow changing the selector to allow for different selections with the same element' do
      specific_element = test_page.dynamic_locator_css.update_locator(locator: 'id', id: '333333')
      specific_element.locator.should == {css: "a[id='link333333']"}
      specific_element.link.should == 'http://google.com/'
      specific_element = test_page.dynamic_locator_css.update_locator(locator: 'id', id: '222222')
      specific_element.locator.should == {css: "a[id='link222222']"}
      specific_element.link.should == 'http://yahoo.com/'
    end
  end

  describe Selenium::WebDriver::Element do
    it 'should return the correct value of a method defined in WebDriver::Element, but not GenericElement class' do
      test_page.input_button_element.tag_name.should == 'input'
    end

    it 'should throw an WebDriver Element error when using a method not defined in either WebDriver::Element or GenericElement classes' do
      expect { test_page.input_checkbox.clickit_good }.to raise_error(NoMethodError)
    end
  end
end