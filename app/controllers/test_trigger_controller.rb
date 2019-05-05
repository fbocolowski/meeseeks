class TestTriggerController < ApplicationController
  before_action :security_private
  before_action :set_server
  before_action :set_trigger

  def show
    case @trigger.action
    when "Slack"
      NotificationSender.slack(@trigger.url, "Hi there! Your trigger for #{@server.hostname} (#{@server.ip}) is working.", nil)
    when "Discord"
      NotificationSender.discord(@trigger.url, "Hi there! Your trigger for #{@server.hostname} (#{@server.ip}) is working.", nil)
    end
    redirect_to server_triggers_path(@server)
  end

  private

  def set_server
    @server = @user.servers.find(params[:server_id])
  end

  def set_trigger
    @trigger = @server.triggers.find(params[:trigger_id])
  end
end