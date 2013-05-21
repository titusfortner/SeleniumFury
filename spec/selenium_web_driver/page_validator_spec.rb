require 'spec_helper'
describe SeleniumFury::SeleniumWebDriver::PageValidator do

  before(:each) do
    launch_web_driver TEST_PAGE_URL
  end

  context "with present elements" do

    it "should not raise an error when validating" do
      expect { validate(TestPage) }.to_not raise_error
    end
  end

  context "with missing elements" do
    class MissingElement < PageObject
      element :not_a_element1, {:id => "not a element1"}
      element :not_a_element2, {:id => "not a element2"}
      generic_element :not_a_element3, {:id => "not a element3"}
      generic_element :not_a_element4, {:id => "not a element4"}
    end

    it "should find missing elements for both old and new element types" do
      expect { validate(MissingElement) }.
          to raise_exception(RuntimeError, "Found Missing Elements: [:not_a_element1, :not_a_element2, :not_a_element3, :not_a_element4]")
    end
  end

  context "with skipped elements" do
    before(:each) do
      ENV['FOO'] = nil
      ENV['BAR'] = nil
    end

    class SkippedElement < PageObject
      generic_element :_skip_underscored_element, {id: 'not_here'}
      generic_element :skip_hard_coded_element, {id: 'not_here'}, {verify: false}
      generic_element :skip_dynamically, {css: 'element_not_here'}, {tags: [:foo, :bar]}
    end

    it "should not raise an error when set to skip :foo, though not :bar" do
      ENV['FOO'] = 'true'
      ENV['BAR'] = 'false'
      expect { validate(SkippedElement) }.to_not raise_error
    end

    it "should not raise an error when set to skip :bar, though not :foo" do
      ENV['FOO'] = 'false'
      ENV['BAR'] = 'true'
      expect { validate(SkippedElement) }.to_not raise_error
    end

    it "should not raise an error when set to skip either :foo or :bar" do
      ENV['FOO'] = 'true'
      ENV['BAR'] = 'true'
      expect { validate(SkippedElement) }.to_not raise_error
    end

    it "should raise an error when set to skip  neither :foo, nor :bar" do
      ENV['FOO'] = 'false'
      ENV['BAR'] = nil
      expect { validate(SkippedElement) }.
          to raise_exception(RuntimeError, "Found Missing Elements: [:skip_dynamically]")
    end

    it "should validate based on parameters input to method" do
      web_driver_validate(SkippedElement)
      web_driver_validate(SkippedElement, verify_all: [:foo, :bar])
      web_driver_validate(SkippedElement, verify_all: [:foo])
      web_driver_validate(SkippedElement, verify_all: [:missing])
      web_driver_validate(SkippedElement, verify_any: [:foo, :bar])
      web_driver_validate(SkippedElement, verify_any: [:foo])
      web_driver_validate(SkippedElement, verify_any: [:missing])
    end
  end
end
