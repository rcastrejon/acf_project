defmodule AcfProject.Notifier do
  @arn "arn:aws:sns:us-east-1:705946467428:sicei-email"

  def publish_message(message) do
    message
    |> ExAws.SNS.publish(topic_arn: @arn)
    |> ExAws.request()
  end
end
