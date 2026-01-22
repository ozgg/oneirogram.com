# frozen_string_literal: true

module ApplicationHelper
  # @param [String] url
  # @param [String] text
  def destroy_button(url, text: t('actions.destroy'))
    button_to text, url, method: :delete, data: { confirm: t(:are_you_sure) }
  end

  def my_index_link
    link_to(t('my.index.index.nav_text'), my_index_path)
  end

  # @param [ApplicationRecord] entity
  # @param [Hash] options
  def my_entity_link(entity, **options)
    return '∅' if entity.nil?

    handler = Components::BaseComponent
    text = options.delete(:text) { handler.text_for_link(entity) }
    href = handler.entity_link(entity, :my)

    link_to(text, href, options)
  end

  # @param [ApplicationRecord] entity
  # @param [Hash] options
  def entity_link(entity, **options)
    return '' if entity.nil?
    return '' if entity.respond_to?(:visible?) && !entity.visible?

    handler = Components::BaseComponent
    text = options.delete(:text) { handler.text_for_link(entity) }
    href = handler.entity_link(entity)

    link_to(text, href, options)
  end

  # @param [String] model_name
  # @param [String] field_name
  # @param [String] key
  def enum_value(model_name, field_name, key)
    t("enums.#{model_name}.#{field_name}.#{key}")
  end

  # @param [User|nil] user
  def profile_link(user)
    return t(:anonymous) if user.blank?

    html_options = {
      itemscope: true,
      itemtype: 'http://schema.org/Person',
      class: 'profile-link'
    }

    link_to(user.slug, '#', html_options)
  end
end
