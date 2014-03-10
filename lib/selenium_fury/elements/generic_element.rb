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
    class GenericElement
      include GenericElementHelper
      include WaitElementHelper

      def initialize(opt={}, driver=nil)
        @original_locator = get_locator(opt).freeze
        @locator = Marshal.load(Marshal.dump(@original_locator))
        @driver = driver
        @tags = opt[:tags]
        # Should require if opt[:require] is nil, should not require if doing dynamic matching
        @require = opt[:require] != false && !@original_locator.values.first.match(/__/)
        # This is different from implicit_wait. This explicitly waits for this element, not for entire driver session.
        @wait = opt[:wait] || 10
      end

      attr_accessor :locator, :driver, :tags, :wait, :implicit_wait
      attr_writer :require

      def required?
        @require
      end

      def update_locator(variables)
        locator = Marshal.load(Marshal.dump(@original_locator))
        variables.each { |key, value| locator.first[1].gsub! ('__' + key.to_s.upcase + '__'), value.to_s }
        @locator = locator
        self
      end

      private
      def get_locator(opt)
        if opt[:css]
          {css: opt[:css]}
        elsif opt[:id]
          {id: opt[:id]}
        elsif opt[:name]
          {name: opt[:name]}
        elsif opt[:class_name] || opt[:class]
          {class: opt[:class_name] || opt[:class]}
        elsif opt[:tag_name]
          {tag_name: opt[:tag_name]}
        elsif opt[:link_name] || opt[:link]
          {link: opt[:link_name] || opt[:link]}
        elsif opt[:partial_link_text]
          {partial_link_text: opt[:partial_link_text]}
        elsif opt[:xpath]
          {xpath: opt[:xpath]}
        elsif opt[:data]
          {css: "[data-#{opt[:data]}]"}
        else
          {css: "[data-#{opt[:element_type]}]"}
        end

      end
    end # GenericElement
  end # Elements
end # SeleniumFury