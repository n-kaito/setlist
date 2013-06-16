$ ->
  class EventView extends Backbone.View
    el: '.js-event-form'
    events: 
      'click #js-link-search-place-from-event':'goto_search_place_from_event'

    initialize:->

    goto_search_place_from_event:(evt) ->
      $form_event = $('form.form_event')
      $form_event.attr('action', '/places/for_find')
      $form_event.submit()
      false
    
  event_view = new EventView


  #----------------------
  # model of "artist" 
  #----------------------
  class Artist extends Backbone.Model
    
    initialize:->
    defaults: 
      'artist_name' : null
      'track_name'  : null
      'limit'       : 20
      'offset'      : 0
    
  #---------------------------
  # collection of "artist list"
  #---------------------------
  class ArtistList extends Backbone.Collection
    model: Artist
    url: "http://itunes.apple.com/search?entity=musicArtist&attribute=artistTerm&media=music&limit=20&offset=0"
    initialize:->
      @artist_name = $('input.js-artist').val()
      console.log '---' + $('input.js-artist').val()
      console.log @url
    
    parse : (res)->
      if res.error
        console.log 'ERROR: ' + res.error.message
      console.log res

  #----------------------
  # view of "artist" 
  #----------------------
  class ArtistView extends Backbone.View
    el: '.js-artist-list'
    model: Artist
    @collection: ArtistList

    initialize: (options) ->
      @$artist_name = $('input.js-artist')
      _.bindAll(@, 'render')
      @reset()

    reset : ->
      @collection = new ArtistList

    render : ->
      artist_name = @$artist_name.val()
      @collection.fetch({
        data : {
          'term' : artist_name 
        },
        dataType : 'json',
        success : 'success'
      })


  #----------------------
  # model of "song" 
  #----------------------
  class Song extends Backbone.Model
    @urlRoot = 'http://itunes.apple.com/search?entity=musicArtist&attribute=artistTerm&media=music&term=宇多田ヒカル&limit=20&offset=0'
    
    initialize:->
    defaults: 
      'artist_name' : ''
      'track_name'  : ''
      'limit'       : 20
      'offset'      : 0
    
    fetch:->


  #---------------------------
  # collection of "song list"
  #---------------------------
  class SongList extends Backbone.Collection
    model:Song

  objs = new SongList
  obj = new Song
  obj.set({artist_name:'宇多田ヒカル'})
  obj.set({track_name:'first love'})
  objs.add(obj)

  #console.log(obj.get('artist_name'))
  #console.log(obj.get('track_name'))
  #console.log(objs.length)
  #console.log(objs.at(0))
  


  #---------------------------
  # view of "setlist view"
  #---------------------------
  class SetlistView extends Backbone.View
    el: ".js-event-detail"
    events: 
      'click #js-add-song' : 'add_song'
      'keydown .js-artist' : 'search_artist'

    add_song:(evt) ->
      alert 'aaa'

    search_artist:(evt) ->
      artistView.render()

  artistView  = new ArtistView
  setlistView = new SetlistView
