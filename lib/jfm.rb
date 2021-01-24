require "pathname"
require "yaml"

require "jfm/version"

module Jfm
  class Error < StandardError; end

  class Site
    def initialize(dir)
      @working_dir = Pathname(dir)
    end

    def posts
      post_files.map { |file| Post.new(file) }
    end

    private

    def post_files
      Dir[@working_dir + "**" + "_posts" + "*"]
    end
  end

  class Post
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def frontmatter
      @frontmatter ||= YAML.load(raw_frontmatter)
    end

    def frontmatter=(new_frontmatter)
      @frontmatter = new_frontmatter
    end

    def match?(query)
      case query
      when /(.+?):\s*~(.+)/
        frontmatter[$1] != $2
      when /(.+?):\s*(.+)/
        frontmatter[$1] == $2
      else
        frontmatter.has_key?(query)
      end
    end

    def save
      backmatter = content.lines.drop_while { |l| l.chomp == "---" }.drop_while { |l| l.chomp != "---" }.drop(1).join
      File.open(filename, "w") do |file|
        file.write YAML::dump(frontmatter)
        file.puts "---"
        file.write backmatter
      end
    end

    private

    def content
      @content ||= File.read(filename)
    end

    def raw_frontmatter
      content.lines.drop_while { |l| l.chomp == "---" }.take_while { |l| l.chomp != "---" }.join
    end
  end
end
