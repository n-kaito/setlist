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
  
  def create_event
    @event = Event.new(params[:event])
    
    respond_to do |format|
      if @event.save
        format.html {redirect_to '/timeline', notice: 'イベントを作成しました'}
        format.json {render json: @event, status: 'created', location: @event}
      else  
        format.html {render action: 'new'}
        format.json {render json: @event.errors, status: :unprocessable_entity}
      end
    end
    
    
  end


  
end
