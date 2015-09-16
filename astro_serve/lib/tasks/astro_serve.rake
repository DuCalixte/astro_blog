require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'rest_client'

require_relative '../../app/models/astro_blog'
namespace :blog do

  desc 'Clear database completely'
  task :clear do
    Rake::Task['config:all'].invoke
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
  end

  desc 'Basic reset with data'
  task :basic_blog do
    Rake::Task['blog:clear'].invoke

    data = [
      {title: 'Perihelion Approaches', description: '2015 August 15: Perihelion Approaches', url: 'http://apod.nasa.gov/apod/ap150815.html', explanation: 'Explanation: This dramatic outburst from the nucleus of Comet 67P/Churyumov-Gerasimenko occured on August 12, just hours before perihelion, its closest approach to the Sun. Completing an orbit of the Sun once every 6.45 years, perihelion distance for this periodic comet is about 1.3 astronomical units (AU), still outside the orbit of planet Earth (at 1 AU). The stark image of the 4 kilometer wide, double-lobed nucleus in bright sunlight and dark shadows was taken by the Rosetta spacecraft\'s science camera about 325 kilometers away. Too close to see the comet\'s growing tail, Rosetta maintains its ringside seat to watch the nucleus warm and become more active in coming weeks, as primordial ices sublimating from the surface produce jets of gas and dust. Of course, dust from the nucleus of periodic comet Swift-Tuttle, whose last perihelion passage was in 1992 at a distance of 0.96 AU, fell to Earth just this week.', picture_url: 'http://apod.nasa.gov/apod/image/1508/ESA_Rosetta_OSIRIS_NAC_20150812_T1735c.jpg', date: DateTime.parse('2015 August 15')},
      {title: 'Comet Dust over Enchanted Rock', description: '2015 August 14: Comet Dust over Enchanted Rock', url: 'http://apod.nasa.gov/apod/ap150814.html', explanation: 'Explanation: Dusty debris from periodic Comet Swift-Tuttle was swept up by planet Earth this week. Vaporized by their passage through the dense atmosphere at 59 kilometers per second, the tiny grains produced a stream of Perseid meteors. A bright, colorful Perseid meteor flash was captured during this 20 second exposure. It made its ephemeral appearance after midnight on August 12, in the moonless skies over the broad granite dome of Enchanted Rock State Natural Area, central Texas, USA. Below the Perseid meteor, trees stand in silhouette against scattered lights along the horizon and the faint Milky Way, itself cut by dark clouds of interstellar dust.', picture_url: 'http://apod.nasa.gov/apod/image/1508/perseid2015tennant_DSC1241-1024.jpg', date: DateTime.parse('2015 August 14')},
      {title: 'Moonless Meteors and the Milky Way', description: '2015 August 13: Moonless Meteors and the Milky Way', url: 'http://apod.nasa.gov/apod/ap150813.html', explanation: 'Explanation: Have you watched the Perseid meteor shower? Though the annual shower\'s predicted peak was last night, meteor activity should continue tonight (August 13/14), best enjoyed by just looking up in clear, dark skies after midnight. Of course, this year\'s Perseid shower has the advantage of being active near the August 14 New Moon. Since the nearly New Moon doesn\'t rise before the morning twilight many fainter meteors are easier to spot until then, with no interference from bright moonlight. The Perseid meteor shower last occurred near a New Moon in 2013. That\'s when the exposures used to construct this image were made, under dark, moonless skies from Hvar Island off the coast of Croatia. The widefield composite includes 67 meteors streaming from the heroic constellation Perseus, the shower\'s radiant, captured during 2013 August 8-14 against a background of faint zodiacal light and the Milky Way. The next moonless Perseid meteor shower will be in August 2018.', picture_url: 'http://apod.nasa.gov/apod/image/1508/viz_2013_08_08-14_Perseidy_1024a.jpg', date: DateTime.parse('2015 August 13')}
    ]

    data.each{|d| AstroBlog.create!(d)}
    # {title: '', description: '', url: '', explanation: '', picture_url: '', date: DateTime.parse('')},
  end

  desc 'Reset database and scrap Astronomy picture of the day'
  task :create_blog do
    Rake::Task['blog:clear'].invoke
    site = 'http://apod.nasa.gov/apod'
    archivepix = 'archivepix.html'

    months = '(?:(?:[Jj]an|[Ff]ebr)uary|(?:[Oo]cto|(?:[Ss]ept|[Nn]ov|[Dd]ec)em)ber|(?:[Mm]a)(?:rch|y)|(?:[Jj]u(?:ne|ly))|(?:[Aa](?:pril|ugust)))'
    regex_date = Regexp.new(/(?:.*|)\s*((?:[1-9]\d{3} #{months} (?:[1-9]$|[0-2][0-9]|3[0-1])|#{months} (?:[1-9]|[0-2][0-9]|3[0-1])\, [1-9]\d{3}))/)
    regex_title_date = Regexp.new(/([1-9]\d{3} #{months} (?:[0-2]?\d|3[0-1])|#{months} (?:[0-2]?\d|3[0-1]), [1-9]\d{3})/)
    # regex_date = Regexp.new(/[0-3]\d{3} (?:(?:[Jj]an|[Ff]ebr)uary|(?:[Oo]cto|(?:[Ss]ept|[Nn]ov|[Dd]ec)em)ber|(?:[Mm]a)(?:rch|y)|(?:[Jj]u(?:ne|ly))|(?:[Aa](?:pril|ugust))) (?:[1-9]$|[0-2][0-9]|3[0-1])/)
    regex_img = Regexp.new(/image\/.*\.(?:png|jpg|gif|tiff)/i)
    regex_expl = Regexp.new(/Explanation:(?:\s*.*\s*\r*\n*)*/)

    archive = Nokogiri::HTML(open(File.join(site, archivepix))) do |config|
      config.strict.noblanks.nonet
    end

    pages = archive.xpath("//b/a").collect {|node| [node.text.strip, node['href']]}
    puts pages.count
    error_count = 0
    count = 0
    pages.collect do |page|
      begin
        title = page[0]
        link = File.join(site, page[1])

        regex_desc = Regexp.new(/^(?:#{title}|\s+[^Astronomy Picture of the Day Discover]|)(?:\s*.*\s*\r*\n*)*/)

        current  = Nokogiri::HTML(open(link)) do |config|
          config.strict.noblanks.nonet
        end
        # puts current.css('title').text.strip
        date = current.css('title').text.strip.try(:scan, regex_title_date).flatten.first
        # date = current.xpath('//title').collect{|node| node.text.strip.try(:scan, regex_title_date)}.flatten.first
        date = DateTime.parse(date) if date

        picture_url = current.xpath('//a').collect{|node| node['href'].try(:scan,regex_img)}.flatten.first
        picture_url = File.join(site, picture_url) if picture_url

        # puts link
        # puts current.text
        # date = current.xpath('//p').collect{|node| node.text.strip.try(:scan, regex_date)}.flatten.first if picture_url
        # date = DateTime.parse(date) if date


        # description = current.xpath('//center').collect{|node| node.text.strip.scan(regex_desc)}.flatten.first.sub(/#{title}/, "#{title} - ").gsub(/([&,:,\,])/,'\1 ').gsub(/\s+/, ' ')
        if picture_url
          begin
            description = current.xpath('//center').collect{|node| node.text.gsub(/\r*\n*/, "").strip}[1].sub(/#{title}/, "#{title} - ").gsub(/([&,:,\,])/,'\1 ').gsub(/\s+/, ' ')
          rescue
            description = current.css('title').text.strip
          end
        end

        explanation = ((current.xpath('//p').collect{|node| node.text.strip.try(:scan, regex_expl)} || current.xpath('//td').collect{|node| node.text.strip.try(:scan, regex_expl)}).flatten.first || '').gsub(/\r*\n*/, "").gsub(/([&,:,\,\.])/,'\1 ').gsub(/\s+/, ' ') if picture_url

        data = {title: title, description: description, url: link, date: date, explanation: explanation, picture_url: picture_url}  if picture_url
        AstroBlog.create!(data) if picture_url

        # open('myfile.out', 'a') do |f|
        #   count += 1
        #   f.puts '>>>>>>>>>>>>>>>>>>>'
        #   f.puts date
        #   f.puts count
        #   f.puts '-------------------' unless date
        #   f.puts current unless date
        #   f.puts '<<<<<<<<<<<<<<<<<<<'
        # end
      rescue Exception => e
        error_count+=1
        puts "#{error_count} errors. #{e.message}"
      end
    end
    puts 'done with database update....'
    # puts AstroBlog.all.size
    puts '---------------------------------'
  end

end
