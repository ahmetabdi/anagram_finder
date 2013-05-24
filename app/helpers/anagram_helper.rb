module AnagramHelper
  def anagram_output finder
    if finder.results.size == 0
    <<-HTML.html_safe
    <div class="text-error" style="padding-bottom:0.5cm;">
      #{Time.now.strftime("%Y.%m.%d %I:%M:%S %P")} <br />
      #{finder.results.size} anagrams found for #{finder.anagram} in #{finder.msecs}ms
    </div>
    HTML
    else
    <<-HTML.html_safe
    <div class="text-success" style="padding-bottom:0.5cm;">
      #{Time.now.strftime("%Y.%m.%d %I:%M:%S %P")} <br />
      #{finder.results.size} anagrams found for #{finder.anagram} in #{finder.msecs}ms <br />
      #{finder.results.join(',')}
    </div>
    HTML
    end
  end
end