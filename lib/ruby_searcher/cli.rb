module RubySearcher
  class CLI
    def self.run
      cli = new
      cli.load_environment
      Search.new.grep(ARGV.first)
    end

    def initialize(args=ARGV)
      opts = parse_options(args)
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
