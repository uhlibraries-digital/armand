# Generated via
#  `rails generate hyrax:work Text`
module Hyrax
  # Generated form for Text
  class TextForm < Hyrax::Forms::WorkForm
    include Bcdams::AllFormsSharedBehaviour

    self.model_class = ::Text

    def self.model_class?(field)
      if [:title].include? field.to_sym
        false
      else
        super
      end
    end

    def self.model_attributes(_)
      attrs = super
      attrs[:title] = Array(attrs[:title]) if attrs[:title]
      attrs
    end

    def title
      super.first || ""
    end

  end
end
