class EntriesController < ApplicationController
  before_filter :retrieve_record, :only => [:show, :destroy]
  
  def index
    order = case
    when params.key?(:best)
      'up_vote_count DESC'
    when params.key?(:worst)
      'down_vote_count DESC'
    when params.key?(:oldest)
      'created_at ASC'
    else
      'created_at DESC'
    end
    conditions = params[:user_id] ? ["user_id = ?", params[:user_id]] : nil
    @entries = Entry.paginate :page => params[:page], :order => order, :conditions => conditions
  end
  
  def show
  end
  
  def create
    @new_entry = Entry.new((params[:entry] || {}).merge({ :ip => request.remote_ip }))
    @new_entry.user_id = current_user.id if current_user
    if @new_entry.save
      flash[:notice] = 'More submissions need to be successful.'
      redirect_to @new_entry
    else
      flash[:notice] = 'More submissions need to be filled out correctly.'
      @entries = Entry.paginate :page => params[:page], :order => 'created_at DESC'
      render :index
    end
  end
  
  def destroy
    flash[:notice] = 'More entries need to be successfully destroyed.' if @entry.destroy
    redirect_to entries_path
  end
  
  private
  
  def retrieve_record
    @entry = Entry.find(params[:id])
  end  
end