json.array!(@immonet_links) do |immonet_link|
  json.extract! immonet_link, :immonet_mail_id, :object_id, :link, :status
  json.url immonet_link_url(immonet_link, format: :json)
end
