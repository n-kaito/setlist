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
      @$text_artist.typeahead({
        source: (query, process) =>
          $.get 'http://' + location.host + '/api/artist', {term: query}, (data)=>
            process data
      })

  #----------------------
  # view of "track" 
  #----------------------
  class TrackView extends Backbone.View
    el: '.js-track-area'

    #DOM
    @$text_artist: null

    initialize: (options) =>
      @$text_track  = $('input.js-text-track')
      @$text_artist = $('input.js-text-artist')
      @$text_track.typeahead({
        source: (query, process) =>
          # アーティストを入れていないとアラート表示
          if _.string.trim(@$text_artist.val()) == ''            
            alert '最初にアーティスト名を入力してください'
            @$text_track.val('')
            return false

          $.get 'http://' + location.host + '/api/track', {term: query + '+' + @$text_artist.val()}, (data)=>
            process data
      })
  
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
  trackView   = new TrackView
  setlistView = new SetlistView
