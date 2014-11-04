defmodule Hibiscus do
	def start() do
		IO.puts "Hibiscus monitoring"
		{:ok, agent} = Agent.start_link fn -> HashDict.new end
		loop ".", agent
	end
	
	def loop(dir, agent, dict) do
		File.ls!(dir)
			|> Enum.each(fn x -> file_or_dir x, dir, agent end)
			
		results = Agent.get agent, fn list -> list end
		if !HashDict.equal?(results, dict) do
			System.cmd("mix test"
		end
		Agent.stop agent
		{:ok, agent} = Agent.start_link fn -> HashDict.new end
		loop(".", agent, results)
	end

	def file_or_dir(path, dir, agent) do
		if File.dir? path do
			loop dir <> "/" <> path, agent
		else
			File.cd! dir, fn -> save_file(path, dir, agent) end
		end	
	end
	
	def save_file(path, dir, agent) do
		%File.Stat{size: size} = File.stat! path
		fullPath = Path.join dir, path
		Agent.update agent, &HashDict.put(&1, fullPath, size)
	end
end
