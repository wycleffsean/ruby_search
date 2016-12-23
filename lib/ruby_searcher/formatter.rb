require 'colorize'

module RubySearcher
  class Formatter < Struct.new(:file, :matches, :options)
    def to_str
      string = ''
      string << "====#{file}\n".colorize(:cyan)
      matches.each do |match, i|
        string << i.to_s
        string << "\t"
        string << [
          match.pre_match,
          match.to_s.colorize(:red),
          match.post_match
        ].join.chomp
        string << "\n"
      end
      string
    end

    def print
      if !matches.empty? || options[:verbose]
        if block_given?
          yield to_str
        else
          puts to_str
        end
      end
    end
  end
end
