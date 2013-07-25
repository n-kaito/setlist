$ ->
  class EventView extends Backbone.View
    el: '.js-event-form'
    events: 
      'click #js-link-search-place-from-event':'goto_search_place_from_event'
    initialize:->
    #goto search place page
    goto_search_place_from_event:(evt) ->
      $form_event = $('form.form_event')
      $form_event.attr('action', '/places/for_find')
      $form_event.submit()
      false

  event_view = new EventView
          
  #----------------------
  # view of "artist" 
  #----------------------
  class ArtistView extends Backbone.View
    el: '.js-artist-area'

    #DOM
    @$text_artist: null

    initialize: (options) =>
      @$text_artist = $('input.js-text-artist')
      options = ['kaito', 'world']
      @$text_artist.typeahead({
        source: (query, process) =>
          $.get 'http://' + location.host + '/api/artists', {term: query}, (data)=>
            process data

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
    #events: 
      #'click #js-add-song' : 'add_song'
      #'keydown .js-text-artist' : 'search_artist'

    #add_song:(evt) ->
    #  alert 'aaa'

    #search_artist:(evt) ->
    #  artistView.fetch_artists()

  artistView  = new ArtistView
  setlistView = new SetlistView
