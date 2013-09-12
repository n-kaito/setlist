$ ->
  #----------------------------
  # view of "EventView" 
  #----------------------------
  class EventView extends Backbone.View
    el: '.js-event-form'
    events: 
      'click #js-link-search-place-from-event':'goto_search_place_from_event'
    initialize:->
    #goto search place page
    goto_search_place_from_event:(evt) =>
      $form_event = $('form.form_event')
      $form_event.attr('action', '/places/for_find')
      $form_event.submit()
      false

  event_view = new EventView

  #----------------------------
  # model of "Song" 
  #----------------------------
  class Song extends Backbone.Model

  #----------------------------
  # collection of "SongList" 
  #----------------------------
  class Songs extends Backbone.Collection
    model: Song

  #----------------------------
  # view of "New Song" 
  #----------------------------
  class NewSongView extends Backbone.View
    el: '.js-new-song'
    model: Song
    collection: Songs

    #DOM
    @$text_artist: null
    @$text_track: null

    events: 
      'click .js-add-song':'add_song'

    initialize: (options) =>
      @songs_listbox = $('.js-songs-listbox').find('ol')

      #アーティストにtypeaheadを追加
      @$text_artist = $('input.js-text-artist')
      @$text_artist.typeahead({
        source: (query, process) =>
          $.get 'http://' + location.host + '/api/artist', {term: query}, (data)=>
            process data
      })

      #Trackにtypeaheadを追加
      @$text_track = $('input.js-text-track')
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
    add_song:(evt) =>
      html = _.template($('#js-song-content').html(), {artist: @$text_artist.val(), track: @$text_track.val()})
      @songs_listbox.append(html)


      return false



  newSongView   = new NewSongView
