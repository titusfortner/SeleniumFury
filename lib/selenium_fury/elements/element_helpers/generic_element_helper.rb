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
  module Elements
      # Defines what we can do to all elements
      module GenericElementHelper
        def wd_element
          raise "Locator at #{locator} is not present" unless present?
          @driver.find_element(locator)
        end

        def present?
          # Set implicit wait to zero so it doesn't wait that time each method call
          implicit_wait = driver.manage.timeouts.implicit_wait
          driver.manage.timeouts.implicit_wait = 0
          present = @driver.find_elements(locator).size > 0
          driver.manage.timeouts.implicit_wait = implicit_wait
          present
        end

        # Raises error if not already present
        def visible?
          wd_element.displayed?
        end

        def accessible?
          present? && visible?
        end

        def value
          wd_element.attribute('value')
        end

        def move_to(right_by=nil, down_by=nil)
          @driver.action.move_to(wd_element, right_by, down_by).perform
          self
        end

        def drag_and_drop(target)
          @driver.action.drag_and_drop(wd_element, target.wd_element).perform
        end

        def attach_file(path)
          send_keys!(path)
        end

        def double_click
          @driver.action.double_click(wd_element).perform
        end

        def double_click!
          wd_element.click
        rescue Exception => e
          puts "Encountered #{e.class} trying to click element at #{self.locator}"
        ensure
          wd_element.click
        end

        # TODO - For proper encapsulation, need to define what is and what isn't allowed for each element type
        # Use any methods from WebDriverElement not present
        def method_missing method_sym, *args
          if wd_element.respond_to?(method_sym)
            wd_element.send(method_sym, *args)
          else
            raise NoMethodError, "No such  method #{method_sym} for #{self.class}"
          end
        end

      end # GenericElementHelper
    end # Elements
end # SeleniumFury

