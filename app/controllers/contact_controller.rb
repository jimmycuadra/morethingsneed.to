class ContactController < ApplicationController
  before_filter :new_contact, :except => [:create]

  def index
    render :action => :new
  end

  def new
  end

  def create
    @contact = Contact.new(params[:contact])
    if current_user
      @contact.name = current_user.username
      @contact.real_email = current_user.email
    end
    if @contact.valid?
      Notifier.deliver_contact_form(@contact)
      respond_to do |format|
        format.html do
          flash[:success] = 'Congratulations, your message has been sent to to the administrators, where it will sit in their inboxes until they feel like reading it.'
          redirect_to :action => 'new'
        end
        format.json
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'You done made some errors.'
          render :action => 'new'
        end
        format.json
      end
    end
  end

  private

  def new_contact
    @contact = Contact.new
  end
end
