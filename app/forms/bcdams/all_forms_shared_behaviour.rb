module Bcdams
  module AllFormsSharedBehaviour
    extend ActiveSupport::Concern
    
    included do
      self.terms += [
        :resource_type,
        :alternative,
        :date,
        :extent,
        :format,
        :genre,
        :place,
        :series_title,
        :time_period,
        :resource_access_rights,
        :aspaceurl,
        :donor,
        :note,
        :preservation_location
      ]
      self.required_fields += [:resource_access_rights]

      # Remove terms
      self.terms -= [:keyword, :source, :based_near, :license, :date_created]
      self.required_fields -= [:keyword, :creator]
    end
  end
end