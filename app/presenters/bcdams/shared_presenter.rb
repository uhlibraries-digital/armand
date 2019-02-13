module Bcdams
  module SharedPresenter
    extend ActiveSupport::Concern
    
    included do
      delegate :alternative, :date, :extent, :format, :genre,
               :place, :series_title, :time_period, :resource_access_rights,
               :aspaceurl, :donor, :note, :related_item, :preservation_location, :digital_object_ark,
               to: :solr_document
    end
  end
end