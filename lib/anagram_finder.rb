class AnagramFinder
  attr_reader :anagram, :time, :results

  def initialize file, anagram
    @anagram = anagram
    #words = File.open(file, &:readlines).uniq
    words = File.open(file)
    words = words.read.split.uniq
    @results = []
    @time = Benchmark.realtime do
      words.each do |word|
        if word.chars.sort == @anagram.chars.sort
          @results << word
        end
      end
    end
  end

  def msecs
    (time*1000).round
  end
end