class DownloadController < ApplicationController
  def package
    if params.has_key?(:id)
      @notification = Notification.find(params[:id])
      @downloadlink = @notification.downlink
      @notification.read
      @notification.clicked
      @notification.update_updatetime
    else
      redirect_to root_path
    end
  end
end
