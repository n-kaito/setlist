# coding: utf-8
class ApiController < UserappController
  def artist
  	term = params[:term]
  	content = HTTPClient.new.get_content(
		"http://itunes.apple.com/search",
		"entity" => "musicArtist",
		"attribute" => "artistTerm",
		"media" => "music",
		"country" => "JP",
		"limit" => 10,
		"offset" => 0,
		"term" => term
	)
  	
	parsed = JSON.parse(content)

	artists = []
	parsed['results'].each do |results|
		artists.push results['artistName']
	end
  	render :json => artists
  end

  def track
  	term = params[:term]
  	content = HTTPClient.new.get_content(
		"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch",
		"entity" => "musicTrack",
		#"attribute" => "songTerm",
		"media" => "music",
		"country" => "jp",
		"limit" => 100,
		"offset" => 0,
		"term" => term
	)
  	
	parsed = JSON.parse(content)

	tracks = []
	parsed['results'].each do |results|
		tracks.push results['trackName']
	end
  	render :json => tracks
  end

  
end
