class Banner
  attr_reader :message, :custom_width
  def initialize(message, custom_width = nil)
    @message = message
    @custom_width = custom_width
  end

  def to_s
    [horizontal_rule, empty_line, message_lines,
     empty_line, horizontal_rule].join("\n")
  end

  private

  def justified_message
    "| #{message.center(banner_width)} |"
  end

  def banner_width
    return custom_width if custom_width
    message.size
  end

  def horizontal_rule
    create_line("+", "-")
  end

  def empty_line
    create_line("|")
  end

  def message_lines
    return justified_message if !custom_width ||
      (custom_width && custom_width > message.size)
    TextLine.new(message, banner_width).all
  end

  def create_line(delimiter, sign = " ")
    signs = sign * (banner_width + 2)
    delimiter + signs + delimiter
  end
end

class TextLine
  attr_reader :string, :width
  def initialize(string, width)
    @string = string
    @width = width
  end

  def all
    create_lines_from_string(string)
  end

  private

  def split_into_lines!(lines, words)
    new_line = create_line(words)
    lines << new_line
    remaining_words = words.drop(new_line.size)
    split_into_lines!(lines, remaining_words) if !remaining_words.empty?
  end

  def create_line(words)
    char_counter = 0
    new_line = []
    words.each do |word|
      if char_counter < width && (char_counter + word.size) <= width
        char_counter += word.size + 1
        new_line << word
      else
        break
      end
    end
    new_line
  end

  def create_lines_from_string(string)
    return [string] if string.size < width
    words = string.split
    lines = []
    split_into_lines!(lines, words)
    lines.map { |sub| "| #{sub.join(' ').ljust(width)} |" }
  end
end



banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

# banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

banner = Banner.new('To boldly go where no one has gone before.', 80)
puts banner


banner = Banner.new('To boldly go where no one has gone before, even in the ass of some megapunk who makes jello for friends', 80)
puts banner

banner = Banner.new('To boldly go where no one has gone before, even in the ass of some megapunk who makes jello for friends', 30)
puts banner

banner = Banner.new('To boldly go where no one has gone before, even in the ass of some megapunk who makes jello for friends', 20)
puts banner

long_text = "This example demonstrates a block quote. Because some introductory phrases will lead naturally into the block quote, you might choose to begin the block quote with a lowercase letter. In this and the later examples we use “Lorem ipsum” text to ensure that each block quotation contains 40 words or more. Lorem ipsum dolor sit amet, consectetur adipiscing elit. (Organa, 2013, p. 234)\nModify this method so it will truncate the message if it will be too wide to fit inside a standard terminal window (80 columns, including the sides of the box). For a real challenge, try word wrapping very long messages so they appear on multiple lines, but still within a box."
banner = Banner.new(long_text, 60)
puts banner