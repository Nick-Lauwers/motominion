module Paperclip
  class Rotator < Processor
    attr_accessor :file, :rotation, :source_file_options, :convert_options, :whiny, :current_format, :basename
 
    def initialize(file, options = {}, attachment = nil)
      super
      @file                = file
      @rotation            = options[:rotation].to_i
      @source_file_options = options[:source_file_options]
      @convert_options     = options[:convert_options]
      @whiny               = options[:whiny].nil? ? true : options[:whiny]
      @current_format      = File.extname(@file.path)
      @basename            = File.basename(@file.path, @current_format)
    end
 
    def make
      if @rotation != 0
        dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
        dst.binmode
 
        begin
          parameters = []
          parameters << source_file_options
          parameters << ":source"
          parameters << transformation_command
          parameters << convert_options
          parameters << ":dest"
 
          parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")
          success = Paperclip.run("convert", parameters, :source => File.expand_path(@file.path), :dest => File.expand_path(dst.path))
        rescue Cocaine::ExitStatusError => e
          raise PaperclipError, "There was an error processing the image rotation for #{@basename}" if @whiny
        rescue Cocaine::CommandNotFoundError => e
          raise Paperclip::CommandNotFoundError.new("Could not run the `convert` command. Please install ImageMagick.")
        end
 
        dst
      else
        @file
      end
    end
 
  private
 
    def transformation_command
      "-rotate #{@rotation}"
    end
  end
end