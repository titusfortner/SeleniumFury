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
  module Utilities
    #@return [Selenium::WebDriver::Driver]
    def driver
      return $driver
    end

    # @param url [string]
    # @return [Selenium::WebDriver::Driver]
    def launch_web_driver url=nil
      $driver = Selenium::WebDriver.for :chrome
      $driver.navigate.to url unless url.nil?
    end

    def stop_web_driver
      begin
        $driver.quit unless driver.nil?
      rescue => e
        if /(CLIENT_STOPPED_SESSION|Errno::ECONNREFUSED)/ === e.inspect
          puts "Ignoring #{e.class} because it was thrown by Driver#quit being called on an already-closed driver"
        else
          raise e
        end
      end
    end
  end # Utilities
end # SeleniumFury
