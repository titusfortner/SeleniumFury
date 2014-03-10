class TestPage < SeleniumFury::PageObject

  generic_element       :form_element, {id: 'form'}
  generic_element       :input_file_element, {id: 'input_file'}
  generic_element       :input_hidden_element, {id: 'input_hidden'}
  generic_element       :title_element, {id: 'message', require: false}
  generic_element       :message_text_element, {name: 'msgtext'}
  generic_element       :fieldset_element, {css: 'fieldset'}
  generic_element       :input_doubleclick, {id: 'input_requires_double_click'}
  generic_element       :element_not_present, {id: 'this_element_not_present', require: false}
  generic_element       :element_with_tags, {id: 'input_checkbox', tags: [:tag1, :tag2]}
  generic_element       :element_with_wait, {id: 'input_checkbox', wait: 5}
  generic_element       :title_class, {class: 'title-class'}
  generic_element       :title_class_name, {class_name: 'title-class'}
  generic_element       :message_element, {id: 'message', require: false}

  checkbox_element      :input_checkbox_element, {id: 'input_checkbox'}

  drop_down_element     :select_element, {id: 'select'}

  image_element         :input_image_element, {id: 'input_image'}

  link_element          :link_element, {id: 'link111111'}
  link_element          :dynamic_locator_css, {css: "a[__LOCATOR__='link__ID__']"}
  link_element          :dynamic_locator_css_complete, {css: "li[data-listid='__ID__']"}
  link_element          :dynamic_locator_id, {id: 'link__ID__'}
  link_element          :dynamic_locator_id_complete, {id: '__ID__'}
  link_element          :link_element_link_name, {link_name: 'Link 1'}
  link_element          :link_element_link, {link: 'Link 1'}
  link_element          :link_element_partial, {partial_link_text: 'Link'}

  radio_button_element  :input_radio_element, {id: 'input_radio'}

  submit_element        :input_button_element, {id: 'input_button'}
  submit_element        :input_msg_button_element, {id: 'input_msg_button'}
  submit_element        :input_reset_element, {id: 'input_reset'}
  submit_element        :input_submit_element, {id: 'input_submit'}

  text_element          :input_message_label_element, {css: 'label'}
  text_element          :input_message_name, {name: 'msgtext'}
  text_element          :label_xpath, {xpath: '/html//option[1]'}
  text_element          :legend_tag, {tag_name: 'legend'}
  text_element          :element_list_data, {data: 'listid'}
  text_element          :listid
  text_element          :element_list_data_dynamic, {data: "listid='__ID__'"}

  text_input_element    :input_message_element, {id: 'input_message'}
  text_input_element    :input_password_element, {id: 'input_password'}
  text_input_element    :input_text_element, {id: 'input_text'}
  text_input_element    :textarea_element, {id: 'textarea'}

end