defmodule AutocompleteWeb.ItemSearchLive do
  use AutocompleteWeb, :live_view

  alias Autocomplete.Items

  def mount(_params, _session, socket) do
    items = Items.list_items()

    {:ok, assign(socket, suggestions: items, selected: [])}
  end

  def handle_event("suggest", %{"search" => search}, socket) do
    suggestions = Items.list_items() |> suggest(search)

    {:noreply, assign(socket, suggestions: suggestions)}
  end

  def handle_event("submit", params, socket), do: {:noreply, socket}

  def handle_event("select", %{"id" => id}, socket) do
    item = Items.get_item(id)
    selected = Enum.uniq_by([item] ++ socket.assigns.selected, & &1.id)
    suggestions = filter_selected(socket.assigns.suggestions, selected)

    socket =
      assign(socket,
        selected: selected,
        suggestions: suggestions
      )

    {:noreply, socket}
  end

  defp suggest(items, search) do
    Enum.filter(items, fn i ->
      i.name
      |> String.downcase()
      |> String.contains?(String.downcase(search))
    end)
  end

  defp filter_selected(items, selected) do
    Enum.filter(items, fn i -> !Enum.any?(selected, fn s -> i.id == s.id end) end)
  end
end
