require 'optparse'

module RubySearcher
  class CLI
    def self.run
      cli = new
      #cli.load_environment
      Search.new.grep(cli.options[:q])
    end

    attr_reader :options

    def initialize
      @options = parse_options
    end

    def parse_options(args=ARGV)
      options = {}
      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: rs some_method [options]'
        opts.on '-v', '--[no-]verbose', 'verbose output' do |v|
          options[:verbose] = v
        end
        opts.on '-c', '--[no-]colorize', 'colored output' do |v|
          options[:colorize] = v
        end
      end
      opt_parser.parse!(args)
      if args.empty?
        puts opt_parser.help
        exit
      end
      options[:q] = Regexp.new(args.first)
      options
    end

    def working_dir
      ENV['PWD']
    end

    def bundler_groups
      groups = [:default]
      groups << ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
    end

    def load_environment
      # Set up gems listed in the Gemfile.
      ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', working_dir)
      Bundler.require(*bundler_groups) if File.exists?(ENV['BUNDLE_GEMFILE'])
    end
  end
end
