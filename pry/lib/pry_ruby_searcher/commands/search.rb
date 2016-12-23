module RubySearcher::Pry
  class Search < Pry::ClassCommand
    match 'search'
    group 'ruby-searcher'
    description ''

    def process
      regexp = Regexp.new(arg_string)
      results = ::RubySearcher::Search.new.grep(regexp)
      results.each do |file, matches|
        ::RubySearcher::Formatter.new(file, matches, opts).print do |message|
          output.puts message
        end
      end
    end

    private

    def options(opt)
    end

    Commands.add_command(self)
    Commands.alias_command '\\', 'search'
  end
end
