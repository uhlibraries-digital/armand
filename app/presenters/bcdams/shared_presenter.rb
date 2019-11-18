module Bcdams
  module SharedPresenter
    extend ActiveSupport::Concern
    require 'edtf-humanize'
    
    included do
      delegate :alternative, :date, :extent, :format, :genre,
               :place, :series_title, :time_period, :resource_access_rights,
               :aspaceurl, :donor, :note, :related_item, :preservation_location, 
               :digital_object_ark, :rights_holder, :provenance, :download_option,
               :transcript,
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

      def thumbnail_path
        return '' if thumbnail_id.nil?
        Hyrax::Engine.routes.default_url_options[:host] = Settings.armand.host
        Hyrax::Engine.routes.url_helpers.download_url(thumbnail_id, file: 'thumbnail')
      end

      def location_info
        return '' if aspaceurl.first.blank?

        # Get the archival object
        aspace_uri = aspaceurl.first.gsub(/https?:\/\/[^\/]+/, '')
        object = Aspace::ArchivalObject.find(aspace_uri)
        return '' if object.nil?

        # Filter instances for containers, don't want other instance types
        containers = object[:instances].select do |instance|
          !(instance[:sub_container].nil? || instance[:sub_container][:top_container].nil?)
        end
        return '' if containers.empty?

        # Only want the first container
        container = containers.first[:sub_container]
        # Get the top container i.e. Box, Drawer, Shelf, etc.
        top_container = Aspace::TopContainer.find(container[:top_container][:ref])

        # Get the resource
        # Used to get the accession number
        resource = Aspace::Resource.find(object[:resource][:ref])

        # Build location string
        location_str =  ""
        location_str << "#{resource[:id_0]}, " unless resource.nil?
        location_str << "#{top_container[:type]} #{top_container[:indicator]}" unless top_container.nil?
        location_str << ", #{container[:type_2]} #{container[:indicator_2]}" unless container[:type_2].blank?
        location_str << ", #{container[:type_3]} #{container[:indicator_3]}" unless container[:type_3].blank?

        # Build HTML for metadata table
        markup = ""
        markup << "<tr><th>Location Information</th>"
        markup << "<td><ul class='tabular'>"
        markup << "<li class='attribute attribute-resource_type'>#{location_str}</li>"
        markup << "</ul></td>"
        markup << "</tr>"

        markup.html_safe
      end
    
    end
  end
end