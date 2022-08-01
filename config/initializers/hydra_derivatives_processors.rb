require 'mini_magick'
require 'nokogiri'

Hydra::Derivatives::Processors::Image.class_eval do
  def create_image
    xfrm = selected_layers(load_image_transformer)
    workingfiles = [xfrm.path.dup]
    yield(xfrm) if block_given?
    xfrm.format(directives.fetch(:format))
    xfrm.quality(quality.to_s) if quality
    write_image(xfrm)
    workingfiles << xfrm.path.dup

    clear_working_files(workingfiles)
  end

  def clear_working_files(workingfiles)
    workingfiles.each do |file|
      path = clean_path(file)
      File.delete(path) if File.exist?(path)
    end
  end

  def layer?(file)
    file =~ /\[\d+\]$/
  end

  def clean_path(file)
    newfile = file
    newfile = file.match(/(.*)\[\d+\]/)[1] if layer?(file)
    newfile
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