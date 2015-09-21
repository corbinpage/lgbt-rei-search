require 'json'
require 'csv'
require 'capybara'
require 'capybara/dsl'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'https://www.bing.com'

module MyCapybaraTest
	class Test
		include Capybara::DSL
		def get_bing_results_count(data, csv, min_index)
			# keywords = ['LGBT','lesbian','gay']
			keywords = ['gay','lesbian','alternative','non-traditional','same-sex','same sex','trans','transgender','bisexual','homosexual','LGBT','LGBTQ','LGBTQI','queer','orientation','female-to-male','male-to-female']

			visit('/search?q=hello')

			data.each do |data| 
				if data[0].to_i > min_index
					keywords.each do |keyword|
						query = keyword + ' site:' + data[1]
						fill_in "sb_form_q", :with => query
						click_button 'Search'
						sleep(1)
						result_count = all('.b_algo').length
						links = ""
						if result_count > 0 
							result_count = first('.sb_count').text.gsub(' RESULTS','')
							all('.b_algo h2 a').each do |r|
								links = links + r[:href] + ', '
							end
						end

						puts result_count.to_s + ": " + keyword + " site:" + data[1]
						csv << [data[0], data[1], data[2], data[3], data[4], keyword,result_count,links]
					end
				end
			end


		end

		def get_bing_top_result(id, data, csv)
			visit('/')

			query = data[0] + " " + data[1] + " " + data[2] + " fertility clinic"
			fill_in "sb_form_q", :with => query
			click_button 'Search'
			sleep(1)
			first('.b_algo h2 a')[:href]
			csv << [id, first('.b_algo h2 a')[:href], data[0], data[1], data[2]]
		end

	end
end

CSV.open('./output.csv', 'w+') do |csv|
	csv << ["Id","Link","Center","City","State","Keyword","Count","First 8 Links"]
	data = CSV.read("inputs-final.csv")
	# data = CSV.read("input-sites.csv")
	data.shift


	t = MyCapybaraTest::Test.new
	t.get_bing_results_count(data, csv, 181)
end

# inputs = CSV.read("inputs.csv")
# inputs = inputs[1...-1]

# CSV.open('./input-sites.csv', 'w+') do |csv|
# 	csv << ["Id","Links","Center","City","State"]

# 	inputs.reverse.each_with_index do |data,i|
# 		t = MyCapybaraTest::Test.new
# 		t.get_bing_top_result(i, data, csv)
# 	end
# end