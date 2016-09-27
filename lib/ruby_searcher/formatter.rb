module RubySearcher
  class Formatter < Struct.new(:file, :matches)
    def print
      string = ''
      string << "====#{file}\n"
      matches.each {|line, i| string << "#{i}:\t#{line}\n" }
      puts string
    end
  end
end
