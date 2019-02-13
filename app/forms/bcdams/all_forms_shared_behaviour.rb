module Bcdams
  module AllFormsSharedBehaviour
    extend ActiveSupport::Concern
    
    included do
      self.terms += [
        :resource_type,
        :alternative,
        :date,
        :extent,
        :format,
        :genre,
        :place,
        :series_title,
        :time_period,
        :resource_access_rights,
        :aspaceurl,
        :digital_object_ark,
        :donor,
        :note,
        :related_item,
        :preservation_location,
        :rights_holder
      ]
      self.required_fields += [:resource_access_rights]

      # Remove terms
      self.terms -= [:keyword, :source, :based_near, :license, :date_created, :related_url]
      self.required_fields -= [:keyword, :creator]

      self.field_metadata_service = BcdamsMetadataService

      def title
        super.first || ""
      end

      def self.model_attributes(_)
        attrs = super
        attrs[:title] = Array(attrs[:title]) if attrs[:title]
        attrs
      end

    end
  end
end