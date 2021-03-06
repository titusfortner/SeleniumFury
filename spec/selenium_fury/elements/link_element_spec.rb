require 'spec_helper'

describe SeleniumFury::Elements::LinkElement do
  let(:test_page) { TestPage.new(driver) }
  before(:all) { start_web_driver(TEST_PAGE_URL) }
  after(:all) { stop_web_driver }

  it 'should return the link location' do
    test_page.link_element.link.should == 'http://news.ycombinator.com/'
  end
end