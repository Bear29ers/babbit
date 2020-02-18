class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      @contact.send_contact_email
      flash[:success] = "お問い合わせメールを送信しました"
      redirect_to root_url
    else
      render 'new'
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :content)
    end
end
