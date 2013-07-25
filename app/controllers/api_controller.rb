# coding: utf-8
class ApiController < UserappController
  def artists
  	term = params[:term]
  	content = HTTPClient.new.get_content(
		"http://itunes.apple.com/search",
		"entity" => "musicArtist",
		"attribute" => "artistTerm",
		"media" => "music",
		"limit" => 20,
		"offset" => 0,
		"term" => term
	)
  	
	parsed = JSON.parse(content)

	artists = []
	parsed['results'].each do |results|
		#artists.push({'artist_name' => results['artistName']})
		artists.push results['artistName']
	end

	#artists = {'aaa' => 'nnn'}	

  	render :json => artists

  end
  
end
