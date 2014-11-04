defmodule Hibiscus.Files do
	def get_contents(dir) do
		File.ls! dir
	end
end