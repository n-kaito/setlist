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
    
  #---------------------------
  # collection of "artist list"
  #---------------------------
  class ArtistList extends Backbone.Collection
    model: Artist
    url: 'http://' + location.host + '/api/artists'
    initialize:->
    
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
      @collection.fetch({
        data : {
          'term' : @$artist_name.val()
        },
        dataType : 'json',
        success : console.log 'success'
      })


  #----------------------
  # model of "song" 
  #----------------------
  #class Song extends Backbone.Model

  #---------------------------
  # collection of "song list"
  #---------------------------
  #class SongList extends Backbone.Collection
  
  #---------------------------
  # view of "setlist view"
  #---------------------------
  class SetlistView extends Backbone.View
    el: ".js-event-detail"
    events: 
      #'click #js-add-song' : 'add_song'
      'keydown .js-artist' : 'search_artist'

    #add_song:(evt) ->
    #  alert 'aaa'

    search_artist:(evt) ->
      artistView.render()

  artistView  = new ArtistView
  setlistView = new SetlistView
