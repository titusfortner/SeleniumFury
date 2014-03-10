#/* Copyright (c) 2010 HomeAway, Inc.
# * All rights reserved.  http://www.homeaway.com
# *
# * Licensed under the Apache License, Version 2.0 (the "License");
# * you may not use this file except in compliance with the License.
# * You may obtain a copy of the License at
# *
# *      http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# */

# Create a fundamental object in Ruby defining what a PageObject should be.
module SeleniumFury
  class PageObject

    class << self
      def elements
        @elements ||= []
      end

      # The class helper for creating an element
      #
      # @param element_sym [:Symbol]
      # @param element_hash [Hash]
      # @param opts [Hash
      # @return [Selenium::WebDriver::Element]
      def element(element_sym, element_hash, opts={})

        #@transient_elements ||= []
        # define a new method with the name of the symbol after locator that returns the value
        define_method(element_sym) do
          wait = Selenium::WebDriver::Wait.new(:timeout => 0.5) # seconds
          begin
            wait.until { @driver.find_element element_hash }
          rescue Selenium::WebDriver::Error::TimeOutError
            raise "Could not find element #{element_sym}"
          end
        end

        # keep a running track of all elements and transient elements
        elements << element_sym
        #@transient_elements << element_hash if opts[:transient]
      end

      element_types = Dir.entries(File.expand_path('../elements', __FILE__)).select { |f| f.match(/_element.rb$/) }
      element_types.each do |file|
        method_name = file[0..-4]
        define_method(method_name) do |element_sym, opt={}|
          class_name = method_name.camelize.constantize
          define_method(element_sym) do
            class_name.new(opt.merge(element_type: element_sym), @driver)
          end
          elements << element_sym unless elements.include? element_sym
        end
      end


    end # class << self

    attr_accessor :driver

    def initialize(driver = nil)
      @driver = driver
    end

    def missing_elements(element_list=self.class.elements)
      element_list.each_with_object({}) do |element_name, hash|
        element_obj = self.send(element_name)
        if element_obj.validate? && !(element_obj.present? && element_obj.visible?)
          hash[element_name] = element_obj.location
        end
      end
    end

    def check_for_missing_elements
      element_list = self.class.elements
      if read_only_set.present?
        element_list.select! do |el|
          self.send(el).tags.nil? || !self.send(el).tags.include?(:not_read_only)
        end
      end
      missing_elements = missing_elements(element_list)
      unless missing_elements.empty?
        puts "Missing the following elements:\n"
        missing_elements.each { |k, v| puts("  :#{k.to_s} at location #{v.to_s}\n") }
      end
      missing_elements
    end

    def expected_location?(expected_url = @expected_url)
      @driver.current_url == expected_url && check_for_missing_elements.empty?
    end

  end # PageObject
end # SeleniumFury
