class ImmonetMail < ActiveRecord::Base
  serialize :headers, Hash

  has_many :immonet_links, dependent: :destroy

  after_create :create_immonet_links

  def create_immonet_links
    links.each do |link|
      immonet_links.create link: link
    end
  end

  def links
    return body.gsub(/(http.*immonet.*(angebot|exposeanzeige|exposeansicht).*)(>|\s)/).map{ $1 }.uniq
    #if subject.strip.eql? 'contact!'
    #  body.each_line.map(&:strip).select{|l| l.start_with? 'http'}
    #else
    #end
  end

  def self.fetch
    Mail.defaults do
      retriever_method :imap, { :address             => "arrowsoft.de",
                                :user_name           => 'immonet@arrowsoft.de',
                                :password            => ''}
    end

    mails = Mail.find(keys: "NEW")


    mails.each do |mail|
      data = {}
      text_part = mail.parts.find{|p| p.content_type.include? 'text/plain'}
      data[:body] = text_part.decoded
      data[:raw] = mail.raw_source
      data[:subject] = mail.subject
      data[:headers] = {}

      data[:headers] = {}

      mail.header.fields.each do |field|
        data[:headers][field.name.to_s] = field.value
      end

      immonet_mail = create(data)
      #immonet_mail.immonet_links.where(status: nil).each(&:contact)
    end
  end
end
