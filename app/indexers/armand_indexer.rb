class ArmandIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata

  # Uncomment this block if you want to add custom indexing behavior:
  def generate_solr_document
    super.tap do |solr_doc|
      solr_doc['member_ids_ssim'] = object.member_ids
      solr_doc['member_of_collections_ssim']    = object.member_of_collections.map(&:first_title)
      solr_doc['member_of_collection_ids_ssim'] = object.member_of_collections.map(&:id)
      ActiveFedora.index_field_mapper.set_field(solr_doc, 'generic_type', 'Work', :facetable)

      # This enables us to return a Work when we have a FileSet that matches
      # the search query.  While at the same time allowing us not to return Collections
      # when a work in the collection matches the query.
      solr_doc['file_set_ids_ssim'] = solr_doc['member_ids_ssim']
      solr_doc['visibility_ssi'] = object.visibility

      # Adds single title value for sorting
      solr_doc['sort_title_ssi'] = object.to_s.downcase

      # Add single EDTF date value for sorting
      solr_doc['sort_date_ssi'] = object.date.join('; ')

      admin_set_label = object.admin_set.to_s
      solr_doc['admin_set_sim']   = admin_set_label
      solr_doc['admin_set_tesim'] = admin_set_label
    end
  end
end