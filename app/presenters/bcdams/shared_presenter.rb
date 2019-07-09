module Bcdams
  module SharedPresenter
    extend ActiveSupport::Concern
    require 'edtf-humanize'
    
    included do
      delegate :alternative, :date, :extent, :format, :genre,
               :place, :series_title, :time_period, :resource_access_rights,
               :aspaceurl, :donor, :note, :related_item, :preservation_location, 
               :digital_object_ark, :rights_holder, :provenance, :download_option,
               to: :solr_document
    
      def permalink
        return Settings.greens.base_url + digital_object_ark.first unless digital_object_ark.first.nil? || digital_object_ark.first.blank?
        request.original_url
      end

      def download_all?
        download_option.first == Armand::DownloadControl::DOWNLOAD_TEXT_VALUE_ALL || download_option.first.nil?
      end

      def download_low?
        download_option.first == Armand::DownloadControl::DOWNLOAD_TEXT_VALUE_LOW
      end

      def download_none?
        download_option.first == Armand::DownloadControl::DOWNLOAD_TEXT_VALUE_NONE
      end

      def humanize_date
        begin
          date.collect {|d| Date.edtf(d).humanize}
        rescue NoMethodError => e
          Rails.logger.error(e)
          date
        end
      end

      def iiif_viewer
        :armand_viewer
      end
    
    end
  end
end