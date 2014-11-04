defmodule Hibiscus.RegistryTest do
	use ExUnit.Case, async: true
	
	setup do
		{:ok, registry} = Hibiscus.Registry.start_link
		{:ok, registry: registry}
	end
	
	test "initial registry has no changes", %{registry: registry} do
		assert Hibiscus.Registry.changes?(registry) == false
	end
	
	test "initial registry reset has no changes", %{registry: registry} do
		Hibiscus.Registry.reset(registry)
		assert Hibiscus.Registry.changes?(registry) == false
	end
	
	test "changes returns true if current different than last", %{registry: registry} do
		Hibiscus.Registry.put(registry, "Hello", 123)
		assert Hibiscus.Registry.changes?(registry) == true
	end
	
	test "two identical runs results in no changes", %{registry: registry} do
		Hibiscus.Registry.put(registry, "Hello", 123)
		Hibiscus.Registry.reset(registry)
		Hibiscus.Registry.put(registry, "Hello", 123)
		assert Hibiscus.Registry.changes?(registry) == false
	end
end