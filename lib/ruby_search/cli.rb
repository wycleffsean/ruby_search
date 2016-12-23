require 'optparse'
require "ruby_search/formatter"

module RubySearch
  class CLI
    def self.run
      cli = new
      cli.load_environment
      results = Search.new.grep(cli.options[:q])
      results.each do |file, matches|
        Formatter.new(file, matches, cli.options).print
      end
    end

    attr_reader :options

    def initialize
      @options = parse_options
    end

    def parse_options(args=ARGV)
      options = {}
      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: rs some_method [options]'
        opts.on '-e', '--escape', 'search literal string' do |e|
          options[:escape] = e
        end
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
      if options[:escape]
        options[:q] = Regexp.new(Regexp.escape(args.first))
      else
        options[:q] = Regexp.new(args.first)
      end
      options
    end

    def working_dir
      ENV['PWD']
    end

    def bundler_groups
      groups = [:default]
      groups << (ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development').to_sym
    end

    def load_environment
      # Set up gems listed in the Gemfile.
      ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', working_dir)
      Bundler.require(*bundler_groups) if File.exists?(ENV['BUNDLE_GEMFILE'])
    end
  end
end
