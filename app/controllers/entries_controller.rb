class EntriesController < ApplicationController
  before_filter :retrieve_record, :only => [:show, :destroy]
  before_filter :get_sort_type, :only => [:index, :create]
  
  def index
    conditions = params[:user_id] ? ["user_id = ? AND spam = ?", params[:user_id], false] : ["spam = ?", false]
    @entries = Entry.paginate :page => params[:page], :order => @order, :conditions => conditions
  end
  
  def show
  end
  
  def create
    @new_entry = Entry.new((params[:entry] || {}).merge({ :ip => request.remote_ip }))
    @new_entry.user_id = current_user.id if current_user
    if @new_entry.save
      respond_to do |format|
        format.html do
          flash[:success] = 'More submissions need to be successful.'
          redirect_to @new_entry          
        end
        format.json
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'More submissions need to be filled out correctly.'
          @entries = Entry.paginate :page => params[:page], :order => 'created_at DESC'
          render :index          
        end
        format.json
      end
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
  
  def get_sort_type
    case
    when params.key?(:best)
      @order = 'up_vote_count DESC'
      @sort_type = 'Best'
    when params.key?(:worst)
      @order = 'down_vote_count DESC'
      @sort_type = 'Worst'
    when params.key?(:oldest)
      @order = 'created_at ASC'
      @sort_type = 'Oldest'
    else
      @order = 'created_at DESC'
      @sort_type = 'Newest'
    end
  end
end