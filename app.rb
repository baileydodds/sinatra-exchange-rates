
require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"

get("/aed/afn") do
  erb(:aed_afn)
end

# define a route for the homepage
get("/") do
  # Assemble the API url, including the API key in the query string
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  # Use HTTP.get to retrieve the API data
  @raw_response = HTTP.get(api_url)

  # Get the body of the response as a string
  @raw_string = @raw_response.to_s

  # Convert the string to JSON
  @parsed_data = JSON.parse(@raw_string)

  @currency_hash = @parsed_data.fetch("currencies")
  @currencies_abbv = @parsed_data.fetch("currencies").keys
  @num_currencies = @currency_hash.count
 
  # Render a view template
  erb(:home)

  # In the view template, embed the @parsed_data variable to
  # see what you're working with.
  
  # From there, use your Hash/Array skills to make the homepage 
  # match the target.
  
  # Remember to Make The Invisible Visible — View Source in 
  # Chrome to see what your templates are actually outputting, 
  # and embed as many instance variables as you need to (this 
  # is the new equivalent of pretty-printing everything).
end



get("/:first_currency") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  # Use HTTP.get to retrieve the API data
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s
  

  erb(:first_step)
end
