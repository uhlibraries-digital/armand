module Armand
  module AccessControl
    extend ActiveSupport::Concern

    included do
      before_save :ip_access_controls

      def ip_access_controls
        if visibility == Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_IP
          self.read_groups = self.read_groups - ip_read_groups + ip_range(ip_address)
        else
          self.read_groups -= ip_read_groups
        end
      end

      def ip_range(ip_strings)
        ips = ip_strings.collect do |ip|
          addr = IPAddr.new(ip) rescue next
          addr.to_range.map(&:to_s)
        end
        ips.flatten.compact.uniq || []
      end

      def ip_read_groups
        self.read_groups.select {|g| IPAddr.new(g) rescue false }
      end

    end
  end
end