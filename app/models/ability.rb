class Ability
  include Hydra::Ability
  
  include Hyrax::Ability
  #self.ability_logic += [:everyone_can_create_curation_concerns]

  def user_groups
    return @user_groups if @user_groups

    @user_groups = default_user_groups
    @user_groups |= current_user.groups if current_user and current_user.respond_to? :groups
    @user_groups |= ['registered'] unless current_user.new_record?
    @user_groups |= [@options[:remote_ip]] if @options.present? and @options.has_key? :remote_ip
    @user_groups
  end

  # Define any customized permissions here.
  def custom_permissions
    
    if !Settings.campus_ip.nil?
      ips = Settings.campus_ip.split(',').map(&:strip).collect do |ip|
        addr = IPAddr.new(ip) rescue next
        addr.to_range.map(&:to_s)
      end
      ip_addrs = ips.flatten.compact.uniq || []
      @user_groups |= ['registered'] if @options.present? and @options.has_key? :remote_ip and ip_addrs.include? @options[:remote_ip]
    end

  end
end
