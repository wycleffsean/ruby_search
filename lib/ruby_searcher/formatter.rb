require 'colorize'

module RubySearcher
  class Formatter < Struct.new(:file, :matches, :options)
    def print
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
      puts string if !matches.empty? || options[:verbose]
    end
  end
end
