module Hyrax
  module Permissions
    module Readable
      extend ActiveSupport::Concern
      def public?
        read_groups.include?(Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC)
      end

      def registered?
        read_groups.include?(Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_AUTHENTICATED)
      end

      def ip_restricted?
        read_groups.include?(Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_IP)
      end

      def private?
        !(public? || registered?)
      end
    end
  end
end
