class DeleteMiniMagickFilesJob < ActiveJob::Base

  def perform(*args)
    files = Dir.glob(Settings.derivatives.tmp + '/*.*')

    files.each do |file|
      time = File.mtime(file) + 1.day
      now = Time.now

      if now >= time
        begin
          File.delete(file) if File.exists?(file) && File.file?(file)
          logger.info "Deleted tmp file: #{file}"
        rescue
          logger.error "Could not delete file: #{file}"
        end
      end
    end

  end

end