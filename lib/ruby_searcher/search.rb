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
        .each do |file, stream|
          matches = stream
            .each_line
            .with_index
            .select { |line, _| line =~ regex }
          Formatter.new(
            file,
            matches
          ).print
        end
    end
  end
end
