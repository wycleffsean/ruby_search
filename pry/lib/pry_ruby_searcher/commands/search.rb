module RubySearcher::Pry
  class Search < Pry::ClassCommand
    match 'search'
    group 'ruby-searcher'

    def process(query)
    end

    Commands.add_command(self)
  end
end
