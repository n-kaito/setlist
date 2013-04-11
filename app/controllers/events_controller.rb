# coding: utf-8
class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    
    #場所選択からの遷移の場合
    if session[:event]
      @event['open_at'] = session[:event][:open_at]
      @event['name']    = session[:event][:name]
    end
    
    if params[:place] && params[:place].to_i > 0
      
      if place = Place.find(params[:place])
        @event['place_id'] = params[:place]
        @place_name = place.name
      end
    end
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    # place_id を選択せずに場所名のみを入力してきた場合
    if params[:event][:place_id] == '' && params[:place_name] != ''
      # 場所名を部分一致検索
      places = Place::where("name LIKE ?", "%#{params[:place_name]}%")
      
      if places.count == 1
        params[:event][:place_id] = places[0].id
      elsif places.count == 0
        @place = Place.new(:name => params[:place_name])
        is_save_place = @place.save ? true : false
        params[:event][:place_id] = @place.id
      else
        raise "place count error"
      end
    end

    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
