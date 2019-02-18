module Bcdams
  module SharedPresenter
    extend ActiveSupport::Concern
    require 'edtf-humanize'
    
    included do
      delegate :alternative, :date, :extent, :format, :genre,
               :place, :series_title, :time_period, :resource_access_rights,
               :aspaceurl, :donor, :note, :related_item, :preservation_location, 
               :digital_object_ark, :rights_holder,
               to: :solr_document
    
      def permalink
        return Settings.greens.base_url + digital_object_ark.first unless digital_object_ark.first.nil? || digital_object_ark.first.blank?
        request.original_url
      end

      def humanize_date
        begin
          date.collect {|d| Date.edtf(d).humanize}
        rescue NoMethodError => e
          Rails.logger.error(e)
          date
        end
      end
    
    end
  end
end