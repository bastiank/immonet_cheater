class ImmonetLink < ActiveRecord::Base
  belongs_to :immonet_mail

  validates_uniqueness_of :immonet_id

  def link= link
    self.immonet_id ||= link[/public_id=(\d*)/,1] || link[/object_id=(\d*)/,1] || link[/angebot\/(\d*)/,1]
    super(link)
  end

  def contact
    self.increment! :retry_count
    begin
      #driver = Selenium::WebDriver.for :phantomjs
      driver = Selenium::WebDriver.for :firefox
      driver.manage.timeouts.implicit_wait = 10

      driver.navigate.to link
      return if not_found_error(driver)
      driver.save_screenshot Rails.root.join('public','screenshots',"#{self.id}-#{self.immonet_id}-#{self.retry_count}-main.png")

      tries ||= 2
      begin
        driver.find_element(css: 'a#expkb2').click
      rescue
        retry unless (tries -= 1).zero?
        driver.find_element(css: 'a#expkb2').click
      end
      elements = {}

      form_data.each do |field, value|
        el = driver.find_element(css: '#' + field)

        if el.tag_name.eql? 'select'
          el.click
          el.find_element(css: "option[value=#{value}]").click
        else
          el.clear
          el.send_keys value
        end
      end
      driver.find_element(css: '#bc_perambulation').click
      driver.save_screenshot Rails.root.join('public','screenshots',"#{self.id}-#{self.immonet_id}-#{self.retry_count}-form.png")
      self.update status: 'contacted'
    rescue Exception=>e
      return if not_found_error(driver)
      Rails.logger.error e.to_s
      self.update status: 'error', error_message: "#{e.to_s} \n\n #{self.error_message}"
    end
  end

  private

  def not_found_error driver
    if driver.current_url.include? 'objektNichtGefunden'
      self.update status: 'not found'
      return true
    end
    return false
  end

  def form_data
    {
      'bc_salutation' => 'Herr',
      'bc_prename' => 'Bastian',
      'bc_surname' => 'Kriesten',
      'bc_email' => "bastian@kriesten.net",
      'bc_phone' => "0160 / 90151218",
      'bc_annotations' => <<eos
Guten Tag,

ihr Angebot klingt sehr zu uns passend, daher würden wir gerne zeitnah einen Termin für eine Besichtigung vereinbaren. Wir können am Wochenende und wochentags ab 17 Uhr.

Wir sind ein Akademiker-Pärchen (beide 31 Jahre alt) mit unbefristeten Jobs in Hamburg. Wir sind Nichtraucher und haben keine Haustiere. 

Ich arbeite als Software-Entwickler in der Internetbranche (http:/www.jimdo.de) und meine Partnerin ist in der Unternehmensberatung als Projektleiterin tätig (http://www.beone-hamburg.com/). 
Eine kleine Selbstauskunft finden Sie unter http://kriesten.net/Selbstauskunft_Kriesten_Peters.pdf.

Wir freuen uns über eine zeitnahe Antwort.

Mit freundlichen Grüßen,

Bastian Kriesten (Diplom Informatiker)
Annika Peters (Dr.-Ing.)


Kontakt:
Bastian Kriesten
Handy: 016090151218
Mail: bastian@kriesten.net

Professor-Brix-Weg 7
22767 Hamburg

eos

}

  end
end
