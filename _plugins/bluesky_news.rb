require "net/http"
require "json"
require "time"

# Populates the homepage "news" panel (site.news, i.e. the _news collection
# rendered by al_folio_core's news.liquid) with the SFBVie account's recent
# original Bluesky posts, fetched at build time from Bluesky's public,
# unauthenticated AT Protocol API. Runs alongside the hand-written _news/*.md
# announcements rather than replacing them; both are sorted together by date.
#
# Config: enable_bluesky_news (bool), bluesky_news_handle (string, defaults
# to the handle below), bluesky_news_limit (int, defaults to 5).
module BlueskyNews
  DEFAULT_HANDLE = "sfbvie.bsky.social"
  DEFAULT_LIMIT = 5
  TITLE_MAX_LENGTH = 90

  class Generator < Jekyll::Generator
    priority :low

    def generate(site)
      return unless site.config["enable_bluesky_news"]

      handle = site.config["bluesky_news_handle"] || DEFAULT_HANDLE
      limit = site.config["bluesky_news_limit"] || DEFAULT_LIMIT

      fetch_posts(handle, limit).each { |post| create_news_doc(site, handle, post) }
    rescue StandardError => e
      Jekyll.logger.warn "BlueskyNews:", "Failed to fetch posts for #{handle rescue '?'} (#{e.message}), skipping"
    end

    private

    def fetch_posts(handle, limit)
      uri = URI("https://public.api.bsky.app/xrpc/app.bsky.feed.getAuthorFeed")
      uri.query = URI.encode_www_form(actor: handle, limit: limit, filter: "posts_no_replies")

      response = Net::HTTP.get_response(uri)
      unless response.is_a?(Net::HTTPSuccess)
        Jekyll.logger.warn "BlueskyNews:", "API returned #{response.code}, skipping"
        return []
      end

      data = JSON.parse(response.body)
      (data["feed"] || []).filter_map do |item|
        next if item["reason"] # skip reposts, keep only original posts

        record = item.dig("post", "record") || {}
        text = record["text"]
        created_at = record["createdAt"]
        post_uri = item.dig("post", "uri")
        next if text.nil? || text.strip.empty? || created_at.nil? || post_uri.nil?

        { uri: post_uri, text: text, created_at: created_at }
      end
    end

    def create_news_doc(site, handle, post)
      rkey = post[:uri].to_s.split("/").last
      return if rkey.nil? || rkey.empty?

      date = Time.parse(post[:created_at]).utc
      bsky_url = "https://bsky.app/profile/#{handle}/post/#{rkey}"
      title = truncate(post[:text])

      path = site.in_source_dir("_news/bluesky-#{rkey}.md")
      doc = Jekyll::Document.new(path, { site: site, collection: site.collections["news"] })
      doc.data["layout"] = "post"
      doc.data["title"] = title
      doc.data["date"] = date
      doc.data["related_posts"] = false
      doc.content = "#{post[:text]}\n\n[Voir sur Bluesky ↗](#{bsky_url})"

      site.collections["news"].docs << doc
    end

    def truncate(text)
      single_line = text.gsub(/\s+/, " ").strip
      return single_line if single_line.length <= TITLE_MAX_LENGTH

      "#{single_line[0, TITLE_MAX_LENGTH].rstrip}…"
    end
  end
end
