require 'rubygems'
require 'nokogiri'
require 'restclient'
require 'csv'
require 'gmail'


gmail_address = 'puthere'
gmail_password = 'puthere'


REQUEST_URL = "http://www.libertyguide.com/jobs/"

form_page = Nokogiri::HTML(RestClient.get(REQUEST_URL))

radius = 10
zip = 'City%2C+State%2C+Zip%2C+or+Address'
searchingJobs = 'Y'
job_latitude = ''
job_longitude = ''

if page = RestClient.post(REQUEST_URL, {'radius'=>radius, 'zip'=>zip, 'searchingJobs'=>searchingJobs, 'job_latitude'=>job_latitude, 'job_longitude'=>job_longitude})
    puts "Success!"
    File.open("data.html", 'w'){|f| f.write page.body}
    doc = Nokogiri::HTML(page)
    gmail = Gmail.new(gmail_address, gmail_password)
    CSV.open("data.csv", "w") do |csv|
        csv << ["Job Title", "Link", "Date Posted", "Organization", "Location", "Commitment", "Excerpt", "Categories"]
        doc.xpath('//div[@class = "post_entry"]').each do |post|
        link = post.xpath('h4/a')
        title = link.text
        link_address = link.xpath('@href')
        date_posted = post.xpath('p[@class = "post_meta_date"]').text.sub("Posted: ", "")
        org = post.xpath('div//p[@class = "post_meta_organization"]').text
        location = post.xpath('div//p[@class = "post_meta_location"]').text
        commitment = post.xpath('div//p[@class = "post_meta_url"]').text
        description = post.xpath('p[@class = "post_excerpt"]').text
        categories = post.xpath('p[@class = "post_categories"]').text
            
        if Date.parse(date_posted) >= (Date.today - 1) then
            
                gmail.deliver do
                    to gmail_address
                    subject "#{org}: #{title}"
                    text_part do
                        body "Title: #{title} \n Link: #{link_address} \n Date: #{date_posted} \n Org: #{org} \n Time: #{commitment} \n Description: #{description} \n Categories: #{categories} \n"
            
                    end
                    html_part do
                        body "Title: #{title} \n Link: #{link_address} \n Date: #{date_posted} \n Org: #{org} \n Time: #{commitment} \n Description: #{description} \n Categories: #{categories} \n"
                    end
                end
                
            puts "sent email: Title: #{title} \n Link: #{link_address} \n Date: #{date_posted} \n Org: #{org} \n Time: #{commitment} \n Description: #{description} \n Categories: #{categories} \n"
        end
            
        csv << [title, link_address, date_posted, org, location, commitment, description, categories]
            #puts " Title: #{title} Link: #{link_address} Date: #{date_posted} Org: #{org} \n"
        end
        
    end
    gmail.logout

end

