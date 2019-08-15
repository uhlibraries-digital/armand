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
        index.as :stored_searchable, :facetable
      end
    
      property :place, predicate: ::RDF::Vocab::DC.spatial do |index|
        index.as :stored_searchable, :facetable
      end
    
      property :series_title, predicate: ::RDF::Vocab::BF2.partOf do |index|
        index.as :stored_searchable
      end
    
      property :time_period, predicate: ::RDF::Vocab::DC.temporal do |index|
        index.as :stored_searchable, :facetable
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

      property :related_item, predicate: ::RDF::Vocab::DC.relation do |index|
        index.as :stored_searchable
      end

      property :preservation_location, predicate: ::RDF::Vocab::DC.source, multiple: false
      
      property :digital_object_ark, predicate: ::RDF::URI.new("http://www.europeana.eu/schemas/edm/isShownAt"), multiple: false do |index|
        index.as :stored_searchable 
      end 

      property :rights_holder, predicate: ::RDF::Vocab::DC.rightsHolder do |index|
        index.as :stored_searchable 
      end

      property :ip_address, predicate: ::RDF::URI.new("https://www.w3.org/ns/auth/acl#Authorization") do |index|
        index.as :stored_searchable
      end

      property :download_option, predicate: ::RDF::URI.new("https://www.w3.org/ns/auth/acl#accessControl"), multiple: false do |index|
        index.as :stored_searchable
      end

      property :provenance, predicate: ::RDF::URI.new("https://vocab.lib.uh.edu/bcdams-map#isPartOf") do |index|
        index.as :stored_searchable, :facetable
      end

      property :douuid, predicate: ::RDF::URI.new("https://vocab.lib.uh.edu/bcdams-map#doUuid"), multiple: false

    end
  end
end