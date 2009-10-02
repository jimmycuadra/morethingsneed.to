class EntriesController < ApplicationController
  before_filter :retrieve_record, :only => [:show, :destroy]
  before_filter :prepare_new_entry, :only => [:index, :show]
  
  def index
    conditions = params[:user_id] ? ["user_id = ?", params[:user_id]] : nil
    @entries = Entry.paginate :page => params[:page], :order => 'created_at DESC', :conditions => conditions
  end
  
  def show
  end
  
  def create
    if request.post?
      @new_entry = Entry.new(params[:entry])
      @new_entry.ip = request.remote_ip
      @new_entry.user_id = current_user.id if current_user
      if @new_entry.save
        flash[:success] = 'More submissions need to be successful.'
        redirect_to @new_entry
      else
        flash[:error] = 'More submissions need to be filled out correctly.'
        @entries = Entry.paginate :page => params[:page], :order => 'created_at DESC'
        render :index
      end
    else
      redirect_to :back
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