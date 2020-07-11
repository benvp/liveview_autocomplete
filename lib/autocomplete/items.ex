defmodule Autocomplete.Items do
  @items [
    %{id: 1, name: "Item 1", image_url: "images/items/1.png"},
    %{id: 2, name: "Item 2", image_url: "images/items/2.png"},
    %{id: 3, name: "Item 3", image_url: "images/items/3.png"},
    %{id: 4, name: "Item 4", image_url: "images/items/4.png"}
  ]

  def list_items() do
    @items
  end

  def get_item(id) do
    Enum.find(@items, &(&1.id === String.to_integer(id)))
  end
end
