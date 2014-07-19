class MessageRecipientsController < ApplicationController

  def destroy
    @message_recipient = MessageRecipient.find(params[:id])
    @message_recipient.hide

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end

end
