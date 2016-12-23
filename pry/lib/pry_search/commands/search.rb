module RubySearch::Pry
  class Search < Pry::ClassCommand
    match 'search'
    group 'ruby-search'
    description ''

    def process
      regexp = Regexp.new(arg_string)
      results = ::RubySearch::Search.new.grep(regexp)
      results.each do |file, matches|
        ::RubySearch::Formatter.new(file, matches, opts).print do |message|
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
