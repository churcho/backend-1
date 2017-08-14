defmodule CoreWeb.MessageView do
  use CoreWeb, :view
  alias CoreWeb.MessageView

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      subject: message.subject,
      payload: message.payload,
      entity_id: message.entity_id
    }
  end
end
