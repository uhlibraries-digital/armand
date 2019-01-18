module Hyrax
  module Serializers
    def to_s
      if title.present?
        title
      elsif label.present?
        label
      else
        'No Title'
      end
    end
  end
end