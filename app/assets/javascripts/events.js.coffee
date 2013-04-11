$ ->
  class EventView extends Backbone.View
    events: 
      'click #js-link-search-place-from-event':'goto_search_place_from_event'

    initialize:->
    
    goto_search_place_from_event:(evt) ->
      $('form.new_event').attr('action', '/places/for_find')
      $('form.new_event').submit()
      false
    
  todo_view = new EventView(el:'.js-event-form')
