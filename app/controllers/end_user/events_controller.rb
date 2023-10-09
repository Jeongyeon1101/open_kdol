class EndUser::EventsController < ApplicationController
  
  def new 
    @event = Event.new
  end  
  
  def index
    @events = Event.all
    @event = Event.new
  end  
  
  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to events_path
  end  
  
  def show
    @event = Event.find(params[:id])
  end  
end
