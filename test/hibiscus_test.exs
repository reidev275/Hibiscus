defmodule HibiscusTest do
  use ExUnit.Case

  test "get_file_info returns file info if passed a file" do
    assert Hibiscus.get_file_info "d:\Hibiscus\README.md" != nil
  end
end
