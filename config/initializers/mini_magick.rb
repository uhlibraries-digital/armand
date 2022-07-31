require 'mini_magick'
require 'fileutils'

MiniMagick.configure do |config|
  config.shell_api = "posix-spawn"

  FileUtils.mkdir_p Settings.derivatives.tmp unless Dir.exists?(Settings.derivatives.tmp)
  
  config.tmpdir = Settings.derivatives.tmp
end
