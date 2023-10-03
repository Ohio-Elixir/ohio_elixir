defmodule OhioElixirWeb.ProposalLive do
  use OhioElixirWeb, :live_view

  alias OhioElixir.Events

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :proposals, list_proposals())}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    proposal = Events.get_proposal!(id)
    {:ok, _} = Events.delete_proposal(proposal)

    {:noreply, assign(socket, :proposals, list_proposals())}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def show(assigns) do
    ~H"""
    <div>
      <h1>Proposal</h1>

      <ul>
        <li>
          <strong>Name:</strong>
          <%= @proposal.speaker_name %>
        </li>

        <li>
          <strong>Email:</strong>
          <%= @proposal.speaker_email %>
        </li>

        <li>
          <strong>Summary:</strong>
          <%= @proposal.summary %>
        </li>

        <li>
          <strong>Desired month:</strong>
          <%= @proposal.desired_month %>
        </li>
      </ul>

      <span>
        <.link navigate={Routes.proposal_path(@socket, :index)}>
          Back
        </.link>
      </span>
    </div>
    """
  end

  defp apply_action(socket, :show, %{"id" => id}) do
    assign(socket, :proposal, Events.get_proposal!(id))
  end

  defp apply_action(socket, :index, _params) do
    assign(socket, :proposal, nil)
  end

  defp list_proposals do
    Events.list_proposals()
  end
end
