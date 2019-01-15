# Generated via
#  `rails generate hyrax:work Text`
module Hyrax
  class TextPresenter < Hyrax::WorkShowPresenter
    delegate :alternative, :date, :extent, :format, :genre,
             :place, :series_title, :time_period, :resource_access_rights,
             :aspaceurl, :donor, :note, :preservation_location,
             to: :solr_document
  end
end
