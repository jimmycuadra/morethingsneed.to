class EntriesController < ApplicationController
  # class-based per_page is broken in will_paginate 3.0.pre2

  before_filter :retrieve_record, :only => [:show, :destroy, :toggle_spam]
  before_filter :retrieve_editable_record, :only => [:edit, :update]
  before_filter :get_sort_type, :only => [:index, :create, :show_spam]
  
  def index
    @entries = Entry.without_spam

    if params[:user_id]
      @entries = @entries.by_user(params[:user_id])
      @username = User.find(params[:user_id]).username if params[:user_id]
    end

    respond_to do |format|
      format.any(:html, :mobile) do
        @entries = @entries.order(@order)
        @entries = @entries.paginate :page => params[:page], :per_page => Entry.per_page
      end
      format.rss do
        @entries = @entries.order('created_at DESC').limit(250)
      end
    end
  end
  
  def show
    show_spam = (is_admin and params[:show_spam]) ? { :show_spam => 1 } : nil
    @comments = @entry.comments.all(:conditions => build_conditions(show_spam))
  end
  
  def edit
  end
  
  def create
    @new_entry = Entry.new(params[:entry] || {})
    @new_entry.ip = request.remote_ip
    @new_entry.user_id = current_user.id if current_user
    if @new_entry.save
      @is_ajax = request.xhr? ? true : false 
      respond_to do |format|
        format.html do
          flash[:success] = 'More submissions need to be successful.'
          redirect_to @new_entry          
        end
        format.mobile do
          flash[:success] = 'More submissions need to be successful.'
          redirect_to @new_entry          
        end
        format.json
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'More submissions need to be filled out correctly.'
          @entries = Entry.paginate :page => params[:page], :order => 'created_at DESC', :conditions => build_conditions(nil)
          render :index          
        end
        format.mobile do
          flash.now[:error] = 'More submissions need to be filled out correctly.'
          @entries = Entry.paginate :page => params[:page], :order => 'created_at DESC', :conditions => build_conditions(nil)
          render :index          
        end
        format.json
      end
    end
  end
  
  def update
    if @entry.update_attributes(params[:entry])
      flash.now[:success] = 'More entries need to be updated successfully.'
      render :action => 'show'
    else
      flash.now[:error] = 'More entries need to be edited correctly.'
      render :action => 'edit'
    end
  end
  
  def destroy
    flash[:success] = 'More entries need to be successfully destroyed.' if @entry.destroy
    redirect_to entries_path
  end
  
  def show_spam
    redirect_to entries_path and return unless is_admin
    @entries = Entry.paginate :page => params[:page], :order => @order, :conditions => build_conditions({ :show_spam => 1 })
    render :action => 'index'
  end
  
  def toggle_spam
    redirect_to root_path and return unless is_admin
    
    BannedIp.toggle_ban(@entry.ip)
    flash[:success] = 'More spam flags need to be toggled.'
    redirect_to @entry
  end
  
  private
  
  def retrieve_record
    @entry = Entry.scoped
    @entry = @entry.without_spam unless is_admin
    @entry = @entry.find(params[:id])
  end
  
  def retrieve_editable_record
    begin
      @entry = Entry.where(is_admin ? nil : ["ip = ? AND created_at >= ?", request.remote_ip, 5.minutes.ago]).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "You can't edit that entry. Either you didn't write it, or it's been more than 5 minutes since you originally created it."
      redirect_to root_path and return
    end
  end
  
  def build_conditions(options)
    conditions = Hash.new
    conditions[:user_id] = params[:user_id] if params[:user_id]
    conditions[:spam] = false unless !options.nil? and options.key?(:show_spam)
    conditions
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
    when params.key?(:discussed)
      @order = 'comment_count DESC'
      @sort_type = 'Most Discussed'
    when params.key?(:voted)
      @order = 'up_vote_count + down_vote_count DESC'
      @sort_type = 'Most Voted'
    when params[:action] == 'show_spam'
      @order = 'created_at DESC'
      @sort_type = 'Newest (w/ spam)'
    else
      @order = 'created_at DESC'
      @sort_type = 'Newest'
    end
  end
end
