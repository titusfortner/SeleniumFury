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
    # Defines what we can do to a selectable element
    module  SelectableElementHelper

      def selected?
        wd_element.selected?
      end

      # Immediately Raises error if not selectable
      def select!
        raise "Locator at #{locator} is not visible" unless visible?
        begin
          wd_element.click
        rescue
          raise "Locator at #{locator} can not be interacted with" unless visible?
        end
        check_errors
      end

      def select
        wait_visible
        begin
          wd_element.click
        rescue Exception => e
          raise "Locator at #{locator} can not be interacted with - Failed with #{e.message}"
        end
        check_errors
      end

      # Overwrite in your project if desired
      def check_errors;
      end

    end # SelectableElementHelper
  end # Elements
end # SeleniumFury

