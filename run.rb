require 'json'
require 'csv'
# require 'open-uri'
require 'net/http'
require 'pry'

API_KEY = ''

keywords = ['LGBT','lesbian','gay']
# keywords = ['Lesbian','lesbians','gay','gays','alternative','non-traditional','same-sex','gay','transgender','cis','cisgender','cisman','cismen','ciswoman','ciswomen','homosexual','pangendered','pansexual','pansexuals','polyamory','hijara','transitioning,' 'transitioned','transitional']
# keywords = ['Lesbian','lesbians','gay','gays','alternative','non-traditional','same-sex','gay','single lesbian','single gay','transgender','transgendered','transgender','transgendered','transman','transmen','transwoman','transwomen','LGBT','LGBTQ','LGBTQI','GLMA','bisexual','bisexual','bigender','bigendered','cis','cisgender','cisman','cismen','ciswoman','ciswomen','homosexual','homosexuals','Queer','queers','Genderqueer','M2F','F2M','FTM','MTF','male-to-female','female-to-male','asexual','asexuals','pangender','pangendered','pansexual','pansexuals','polyamory','polyamorous','two-spirit','two-spirted','hijara','transitioning,' 'transitioned','transitional','transitioning,' 'intersex','intergender','orientation']

# sites = ['http://beverlyhills.reproductivepartners.com','http://coloradofertility.com']
sites = ['www.azfertility.com','http://beverlyhills.reproductivepartners.com','http://coloradofertility.com','http://fertilityprogramalabama.com','http://pacificreproductivecenter.com','http://www.columbiafertility.com','http://www.conceptionsrepro.com','http://www.ctfertility.com','http://www.drbachus.com','http://www.goivf.com','http://www.greenwichivf.com','http://www.novaivf.com','http://www.pacificfertilitycenter.com','http://www.pamf.org/fertility','http://www.parkavefertility.com','http://www.rmact.com','http://www.rmfcfertility.com','http://www.rockymountainfertility.com','http://www.uconnfertility.com','https://www.arcfertility.com/arc-fertility-clinics/arc-practices-colorado/advanced-reproductive-medicine-university-colorado','https://www.ccrmivf.com']

CSV.open('./output.csv', 'w+') do |csv|

  sites.each do |site|
    keywords.each do |keyword|

      # uri = URI('http://www.google.com/uds/GwebSearch?v=1.0&q='+keyword+'+site:'+site)
      uri = URI('https://www.googleapis.com/customsearch/v1?cx=017576662512468239146:omuauf_lfve&key='+API_KEY+'&q='+keyword+'+site:'+site)
      res = Net::HTTP.get_response(uri)

      # binding.pry

    # puts res.body if res.is_a?(Net::HTTPSuccess)

    hash = JSON.parse(res.body)

    # binding.pry

    if res.is_a?(Net::HTTPSuccess) && !hash.nil? && hash.has_key?("queries") 
      puts site + ' - ' + keyword + ": " +  hash["queries"]["request"][0]["totalResults"] + " results"

      csv << [keyword,site,"Ok",hash["queries"]["request"][0]["totalResults"]]

      # results.each do |result|
      #   csv << [keyword,site,"Ok",result["visibleUrl"],result["url"],result["title"]]
      #   # file.write %(LGBT,#{result["visibleUrl"]},#{result["url"]},#{result["title"]},#{result["content"]},)
      # end
    else
      csv << [keyword,site,"No Results",hash.to_json]
    end


  end
end
end

# File.open('./output.csv', 'w+') do |file|
#   Google::Search::Image.new(:query => 'http://imgur.com/').each do |image|
#     file.write %(<img src="#{image.uri}">)
#   end
# end