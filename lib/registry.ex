defmodule Hibiscus.Registry do
	use GenServer
	
	## Client API
	
	@doc """
		Starts the registry
	"""
	def start_link(opts \\[]) do
		GenServer.start_link(__MODULE__, :ok, opts)
	end
	
	
	@doc """
		Adds a record to the current run
	"""
	def put(server, name, updated) do
		GenServer.cast(server, {:put, name, updated})
	end
	
	@doc """
		Compares the current run to the last run.
		Returns true if current run different from last run
	"""
	def changes?(server) do
		GenServer.call(server, :compare)
	end
	
	@doc """
		Sets last to current and current to HashDict.new
	"""
	def reset(server) do
		GenServer.cast(server, :reset)
	end	
	
	## Server Callbacks
	def init(:ok) do
		last = HashDict.new
		current = HashDict.new
		{:ok, {current, last}}
	end
	
	def handle_cast({:put, name, updated}, {current, last}) do
		current = HashDict.put(current, name, updated)
		{:noreply, {current, last}}
	end
	
	def handle_cast(:reset, {current, _}) do
		{:noreply, {HashDict.new, current}}
	end
	
	def handle_call(:compare, _from, {current, last} = state) do
		{:reply, !HashDict.equal?(current, last), state}
	end
end