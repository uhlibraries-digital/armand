# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document
  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Hyrax behaviors to the SolrDocument.
  include Hyrax::SolrDocumentBehavior


  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Do content negotiation for AF models. 

  use_extension( Hydra::ContentNegotiation )

  attribute :alternative, Solr::Array, solr_name('alternative')
  attribute :date, Solr::Array, solr_name('date')
  attribute :extent, Solr::Array, solr_name('extent')
  attribute :format, Solr::Array, solr_name('format')
  attribute :genre, Solr::Array, solr_name('genre')
  attribute :place, Solr::Array, solr_name('place')
  attribute :series_title, Solr::Array, solr_name('series_title')
  attribute :time_period, Solr::Array, solr_name('time_period')
  attribute :resource_access_rights, Solr::Array, solr_name('resource_access_rights')
  attribute :aspaceurl, Solr::Array, solr_name('aspaceurl')
  attribute :donor, Solr::Array, solr_name('donor')
  attribute :note, Solr::Array, solr_name('note')

end