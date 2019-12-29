# frozen_string_literal: true

module Feedjira
  module RSSEntryUtilities
    def self.included(mod)
      mod.class_exec do
        element :title

        element :"content:encoded", as: :content
        element :description, as: :summary

        element :link, as: :url

        element :author
        element :"dc:creator", as: :author

        element :pubDate, as: :published
        element :pubdate, as: :published
        element :issued, as: :published
        element :"dc:date", as: :published
        element :"dc:Date", as: :published
        element :"dcterms:created", as: :published

        element :"dcterms:modified", as: :updated

        element :guid, as: :entry_id, class: Feedjira::Parser::GloballyUniqueIdentifier
        element :"dc:identifier", as: :dc_identifier

        element :"media:thumbnail", as: :image, value: :url
        element :"media:content", as: :image, value: :url
        element :enclosure, as: :image, value: :url

        elements :category, as: :categories
      end
    end

    def entry_id
      @entry_id && @entry_id.respond_to?(:guid) ? @entry_id.guid : @entry_id
    end

    def url
      @url || (@entry_id && @entry_id.url)
    end

    def id
      entry_id || @dc_identifier || @url
    end
  end
end
