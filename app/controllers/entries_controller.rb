class EntriesController < ApplicationController
  before_filter :retrieve_record, :only => [:show, :edit, :update, :destroy]
  before_filter :prepare_new_entry, :only => [:index, :show]
  
  def index
    @entries = Entry.all(:order => 'created_at DESC')
  end
  
  def show
    @comment = Comment.new
  end
  
  def edit
  end
  
  def create
    if request.post?
      @entry = Entry.new(params[:entry])
      @entry.ip = request.remote_ip
      if @entry.save
        flash[:success] = 'More submissions need to be successful.'
        redirect_to @entry
      else
        flash[:error] = 'More submissions need to be filled out correctly.'
        @entries = Entry.all(:order => 'created_at DESC')
        render :index
      end
    else
      redirect_to :back
    end
  end
  
  def update    
    if @entry.update_attributes(params[:entry])
      flash[:success] = 'More entries need to be edited successfully.'
      redirect_to @entry
    else
      flash[:error] = 'More entries need to be filled out correctly.'
      render :edit
    end
  end
  
  def destroy
    flash[:success] = 'More entries need to be successfully destroyed.' if @entry.destroy
    redirect_to entries_path
  end
  
  private
  
  def retrieve_record
    @entry = Entry.find(params[:id])
  end
  
  def prepare_new_entry
    @new_entry = Entry.new
  end
end