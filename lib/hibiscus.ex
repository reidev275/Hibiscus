defmodule Hibiscus do

	@dir "."
	
	def main(argv) do
		start
	end
	
	def start() do
		IO.puts "Hibiscus monitoring " <> System.cwd
		{:ok, registry} = Hibiscus.Registry.start_link
		iterate(registry)
	end
	
	defp iterate(registry) do
		loop(@dir, registry)

		if Hibiscus.Registry.changes?(registry) do
			IO.puts "changes found. Running Tests"
			{results, _failures} = System.cmd("mix", ["test"])
			IO.puts results
		end
		Hibiscus.Registry.reset(registry)
		iterate(registry)
	end
	
	defp loop(dir, registry) do
		case File.ls(dir) do
			{:ok, files} -> Enum.each(files, fn x -> file_or_dir(x, dir, registry) end)
			{:error, _} -> 
		end
	end

	defp file_or_dir(path, dir, registry) do
		if File.dir? path do
			loop dir <> "/" <> path, registry
		else
			File.cd!(dir, fn -> save_file(path, dir, registry) end)
		end	
	end
	
	defp save_file(path, dir, registry) do
		%File.Stat{mtime: updated} = File.stat!(path)
		fullPath = Path.join(dir, path)
		Hibiscus.Registry.put(registry, fullPath, updated)
	end
end
