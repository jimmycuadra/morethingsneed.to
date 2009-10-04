class EntriesController < ApplicationController
  before_filter :retrieve_record, :only => [:show, :destroy]
  
  def index
    case
    when params.key?(:best)
      order = 'up_vote_count DESC'
      @sort_type = 'Best'
    when params.key?(:worst)
      order = 'down_vote_count DESC'
        @sort_type = 'Worst'
    when params.key?(:oldest)
      order = 'created_at ASC'
        @sort_type = 'Oldest'
    else
      order = 'created_at DESC'
        @sort_type = 'Newest'
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
      flash.now[:notice] = 'More submissions need to be filled out correctly.'
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