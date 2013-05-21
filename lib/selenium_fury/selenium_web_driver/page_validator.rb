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
module SeleniumFury
  module SeleniumWebDriver
    module PageValidator
      def web_driver_validate(page_class, tags=[])
        raise("Cannot find driver") if driver.nil?
        missing_elements=[]
        skipped_elements=[]
        puts "class #{page_class}"
        page_object=page_class.new(driver)
        raise "Could not find web driver elements in #{page_class}" if page_class.elements.nil?
        page_class.elements.each do |web_driver_element_name|
          puts "\tValidating #{web_driver_element_name}"
          begin
            if page_object.send(web_driver_element_name).is_a? Selenium::WebDriver::Element
              page_object.method(web_driver_element_name).call
            else
              element_obj = page_object.send(web_driver_element_name)
              #Implement something like this to pass in tags with validate
              #element_obj.verify = true if !element_obj.verify && !tags.empty && element_obj.tags.any? {|tag| tags.include? tag}
              raise if !element_obj.present? && element_obj.verify?
              skipped_elements.push(web_driver_element_name) unless element_obj.verify?
            end
          rescue
            puts "\t\t\tCould not find #{web_driver_element_name}"
            missing_elements.push(web_driver_element_name)
          end
        end
        if missing_elements.length > 0
          puts "Missing Elements:"
          missing_elements.each { |element| puts "\t#{element}" }
        end
        if skipped_elements.length > 0
          puts "Skipped Elements:"
          skipped_elements.each { |element| puts "\t#{element}" }
        end
        raise "Found Missing Elements: #{missing_elements.inspect}" if missing_elements.length > 0
      end
    end
  end
end
