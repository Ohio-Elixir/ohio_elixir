defmodule OhioElixirWeb.ProposalSubmissionLive do
  use OhioElixirWeb, :live_view

  alias OhioElixir.Events
  alias OhioElixir.Events.Proposal

  @impl true
  def mount(_params, _session, socket) do
    changeset = Events.change_proposal(%Proposal{})

    socket =
      socket
      |> assign(:changeset, changeset)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"proposal" => proposal_params}, socket) do
    changeset =
      %Proposal{}
      |> Events.change_proposal(proposal_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"proposal" => proposal_params}, socket) do
    case Events.create_proposal(proposal_params) do
      {:ok, _proposal} ->
        {:noreply,
         socket
         |> put_flash(:info, "We've recieved your proposal and will be in touch shortly!")
         |> redirect(to: Routes.page_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
