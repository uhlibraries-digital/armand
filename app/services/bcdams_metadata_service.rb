class BcdamsMetadataService < HydraEditor::FieldMetadataService
  def self.multiple?(model_class, field)
    case field.to_s
    when 'rights_statement', 'title'
      false
    when 'ordered_member_ids', 'in_works_ids', 'member_of_collection_ids'
      true
    else
      super
    end
  end
end