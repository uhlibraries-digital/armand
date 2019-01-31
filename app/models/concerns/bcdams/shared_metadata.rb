module Bcdams
  module SharedMetadata
    extend ActiveSupport::Concern

    included do
      property :alternative, predicate: ::RDF::Vocab::DC.alternative do |index|
        index.as :stored_searchable
      end
    
      property :date, predicate: ::RDF::Vocab::DC.date do |index|
        index.as :stored_searchable
      end
    
      property :extent, predicate: ::RDF::Vocab::DC.extent do |index|
        index.as :stored_searchable
      end
    
      property :format, predicate: ::RDF::Vocab::DC.format do |index|
        index.as :stored_searchable
      end
    
      property :genre, predicate: ::RDF::URI.new("http://www.europeana.eu/schemas/edm/hasType") do |index|
        index.as :stored_searchable
      end
    
      property :place, predicate: ::RDF::Vocab::DC.spatial do |index|
        index.as :stored_searchable
      end
    
      property :series_title, predicate: ::RDF::Vocab::BF2.partOf do |index|
        index.as :stored_searchable
      end
    
      property :time_period, predicate: ::RDF::Vocab::DC.temporal do |index|
        index.as :stored_searchable
      end
    
      property :resource_access_rights, predicate: ::RDF::Vocab::DC.accessRights, multiple: false
      
      property :aspaceurl, predicate: ::RDF::URI.new("https://vocab.lib.uh.edu/bcdams-map#aSpaceUri"), multiple: false  do |index|
        index.as :stored_searchable
      end
      
      property :donor, predicate: ::RDF::URI.new("http://id.loc.gov/vocabulary/relators/dnr") do |index|
        index.as :stored_searchable
      end

      property :note, predicate: ::RDF::URI.new("https://vocab.lib.uh.edu/bcdams-map#note") do |index|
        index.as :stored_searchable
      end

      property :preservation_location, predicate: ::RDF::Vocab::DC.source, multiple: false
    end

  end
end