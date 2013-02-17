# coding: utf-8
class TimelineController < UserappController
  def index 
  end
  
  def new_event
    @event = Event.new
    @event['open_datetime'] = Time.now.year
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @event}    
    end
  end
  
  
end
