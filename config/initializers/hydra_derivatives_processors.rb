require 'mini_magick'
require 'nokogiri'

Hydra::Derivatives::Processors::Image.class_eval do
  def create_image
    xfrm = selected_layers(load_image_transformer)
    yield(xfrm) if block_given?
    xfrm.format(directives.fetch(:format))
    xfrm.quality(quality.to_s) if quality
    write_image(xfrm)
    clear_working_files(xfrm.path.dup)
  end

  def clear_working_files(workingfile)
    filename = File.basename(workingfile, '.*')
    path = File.dirname(workingfile)

    list = Dir.glob("#{File.join(path, filename)}.*")
    list.each do |file|
      File.delete(file) if File.exist?(file)
    end
  end
end

Hydra::Derivatives::Processors::Jpeg2kImage.class_eval do
  def process
    image = MiniMagick::Image.open(source_path)
    quality = image['%[channels]'] == 'gray' ? 'gray' : 'color'
    long_dim = self.class.long_dim(image)
    file_path = self.class.tmp_file('.tif')
    to_srgb = directives.fetch(:to_srgb, true)
    if directives[:resize] || to_srgb
      preprocess(image, resize: directives[:resize], to_srgb: to_srgb, src_quality: quality)
    end
    image.write file_path
    File.delete(image.path) if File.exist?(image.path)
    recipe = self.class.kdu_compress_recipe(directives, quality, long_dim)
    encode_file(recipe, file_path: file_path)
    File.unlink(file_path) unless file_path.nil?
  end
end