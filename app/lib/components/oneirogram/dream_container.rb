# frozen_string_literal: true

module Components
  module Oneirogram
    class DreamContainer
      NAME_PATTERN = /{(?<name>[^}]{1,30})}(?:\((?<text>[^)]{1,30})\))?/

      attr_accessor :user, :dream

      delegate :id, :created_at, :comment_count, :privacy, to: :dream

      # @param [User|nil] user
      # @param [Dream] dream
      def initialize(user, dream)
        @user = user
        @dream = dream
      end

      def title
        dream.title.presence || I18n(:untitled)
      end

      def owner
        dream.user
      end

      def date
        dream.created_at.to_date
      end

      def preview
        words = body.gsub(%r{</?[^>]*>}, ' ').split(/\s+/)
        ellipsis = words.count > 50 ? '…' : ''
        "#{words.first(50).join(' ')}#{ellipsis}"
      end

      def body
        strings = dream.body.split("\n").map(&:squish).compact_blank
        strings.map { |s| parse(s) }.join
      end

      # Parse fragments like {Real Name}(text)
      #
      # @param [String] string
      # @return [String]
      def parse_names(string)
        pattern = NAME_PATTERN
        string.gsub(pattern) do |chunk|
          match = pattern.match chunk
          name  = match[:text] || match[:name].split(/[\s-]+/).map(&:first).join

          title = user == owner ? match[:name] : ''
          %(<span class="name-in-dream" title="#{title}">#{name}</span>)
        end
      end

      # @param [String] string
      def parse(string)
        output = string.gsub('<', '&lt;').gsub('>', '&gt;')
        output = parse_names(output) unless owner.nil?
        "<p>#{output}</p>\n"
      end
    end
  end
end
