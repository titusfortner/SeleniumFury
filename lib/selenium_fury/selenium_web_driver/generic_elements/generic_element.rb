module SeleniumFury
  module SeleniumWebDriver
    module PageObjectComponents

      class GenericElement
        include GenericElementHelpers
        include ElementWaitHelpers

        def initialize(locator, driver=nil, opt={})
          @location = locator
          @driver = driver

          # You can access tags for any additional functionality desired in your implementation
          @tags = opt[:tags]

          # You can dynamically set an element to not verify by
          # passing in a tags: [:foo] in opt, and implement a foo? method to return false
          matches_tag = @tags.any? { |tag| send("#{tag.to_s}?")}  unless @tags.nil?
          @verify = !(matches_tag || opt[:verify] == false)
        end

        attr_accessor :location, :driver, :tags
        attr_writer :verify

        def verify?
          @verify
        end
      end

      class CheckboxElement < GenericElement
        include CheckboxElementHelpers
        include SelectableElementHelpers
      end

      class DropDownElement < GenericElement
        include DropDownHelpers
        include SelectableElementHelpers
      end

      class ImageElement < GenericElement
        include ImageElementHelpers
      end

      class LinkElement < GenericElement
        include LinkElementHelpers
        include SelectableElementHelpers
      end

      class RadioButtonElement < GenericElement
        include SelectableElementHelpers
      end

      class SubmitElement < GenericElement
        include SelectableElementHelpers
      end

      class TextElement < GenericElement
      end

      class TextInputElement < GenericElement
        include TextElementHelpers
      end
    end
  end
end