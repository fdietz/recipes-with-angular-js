module ChapterFilter
  def chapter(input, chapter)
    puts "input: #{input}, chapter: #{chapter}"
    input.chapter == chapter ? input : nil
  end
end

Liquid::Template.register_filter(ChapterFilter)