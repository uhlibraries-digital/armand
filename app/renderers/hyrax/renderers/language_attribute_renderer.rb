module Hyrax
  module Renderers
    class LanguageAttributeRenderer < AttributeRenderer
      private

      def li_value(value)
        label = LanguageService.label(value) { value }
        link_to(label, search_path(value))
      end

      def search_path(value)
        Rails.application.routes.url_helpers.search_catalog_path(:"f[#{search_field}][]" => value, locale: I18n.locale)
      end

      def search_field
        ERB::Util.h(ActiveFedora.index_field_mapper.solr_name(options.fetch(:search_field, field), :facetable, type: :string))
      end

    end
  end
end