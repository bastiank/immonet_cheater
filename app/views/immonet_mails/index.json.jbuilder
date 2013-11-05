json.array!(@immonet_mails) do |immonet_mail|
  json.extract! immonet_mail, :body, :subject, :headers, :raw
  json.url immonet_mail_url(immonet_mail, format: :json)
end
