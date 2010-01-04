class EntriesController < ApplicationController
  before_filter :retrieve_record, :only => [:show, :update, :destroy]
  before_filter :get_sort_type, :only => [:index, :create]
  
  def index
    conditions = Hash.new
    conditions[:user_id] = params[:user_id] if params[:user_id]
    conditions[:spam] = false unless is_admin and params[:show_spam]
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
  
  def update
    redirect_to root_path and return unless is_admin
    
    if @entry.update_attributes(params[:entry])
      flash.now[:success] = 'More submissions need to be updated successfully.'
    else
      flash.now[:error] = 'More submissions need to be edited correctly.'
    end
    
    render :action => 'show'
  end
  
  def destroy
    flash[:success] = 'More entries need to be successfully destroyed.' if @entry.destroy
    redirect_to entries_path
  end
  
  private
  
  def retrieve_record
    @entry = Entry.find(params[:id], :conditions => is_admin ? nil : ["spam = ?", false])
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