require "ruby_searcher/formatter"

module RubySearcher
  class Search
    def grep(regex)
      $LOADED_FEATURES
        .select {|f| f =~ /\.rb\z/ }
        .lazy
        .select {|f| File.exist?(f) }
        .map {|f| [f, File.read(f)] }
        .reject {|x| x[1].to_s.empty? }
        .map do |file, stream|
          matches = stream
            .each_line
            .map { |line| regex.match(line) }
            .reject(&:nil?)
            .each.with_index(1)
            .to_a
          [file, matches]
        end
    end
  end
end
