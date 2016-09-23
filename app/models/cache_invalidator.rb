class CacheInvalidator
  def self.invalidate(stylesheet, preview=false)
    new(stylesheet, preview).invalidate
  end

  def initialize(stylesheet, preview=false)
    @preview = preview
    @stylesheet = stylesheet
  end

  def invalidate
    response = JSON.parse(request_invalidation.body).with_indifferent_access

    if response[:success]
      true
    else
      Rails.logger.error("CacheInvalidator Error:")
      Rails.logger.error(response)
      Bugsnag.notify("Cache Invalidator Failed")
      false
    end
  end

  private

  attr_reader :stylesheet, :preview

  def root_url
    Rails.application.config.root_url
  end

  def file_url
    # http://localhost:3000/stylesheets/2.css?preview=true
    "#{root_url}/stylesheets/#{stylesheet.id}.css#{preview_link_suffix}"
  end

  def preview_link_suffix
    if preview
      "?preview=true"
    else
      ""
    end
  end

  def request_body
    { files: [file_url] }
  end

  def request_invalidation
    connection.delete do |req|
      req.headers["X-Auth-Email"] = "colinpetruno@gmail.com"
      req.headers["X-Auth-Key"] = Rails.application.secrets.cloudflare_api_key
      req.headers['Content-Type'] = "application/json"
      req.body = request_body.to_json
    end
  end

  def connection
    @connection ||= Faraday.new(url: "https://api.cloudflare.com/client/v4/zones/cf1418a16e9efc22401094f83d64de6c/purge_cache") do |faraday|
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end
end
