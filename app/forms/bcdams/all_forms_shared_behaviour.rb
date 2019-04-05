module Bcdams
  module AllFormsSharedBehaviour
    extend ActiveSupport::Concern
    
    included do
      self.terms += [
        :alternative,
        :series_title,
        :date,
        :format,
        :resource_type,
        :extent,
        :provenance,
        :aspaceurl,
        :donor,
        :rights_holder,
        :resource_access_rights,
        :note,
        :related_item,
        :digital_object_ark,
        :genre,
        :place,
        :time_period,
        :preservation_location,
        :ip_address,
      ]
      self.required_fields += [:resource_access_rights]

      # Remove terms
      self.terms -= [:keyword, :source, :based_near, :license, :date_created, :related_url, :rights_notes]
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

      def initialize_field(key)
        return if [:ip_address].include?(key)
        super
      end

      def secondary_terms
        terms - primary_terms -
          [:files, :visibility_during_embargo, :embargo_release_date,
           :visibility_after_embargo, :visibility_during_lease,
           :lease_expiration_date, :visibility_after_lease, :visibility,
           :thumbnail_id, :representative_id, :rendering_ids, :ordered_member_ids,
           :member_of_collection_ids, :in_works_ids, :admin_set_id, :ip_address]
      end

    end
  end
end