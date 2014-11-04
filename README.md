Hibiscus
========

Continuous test runner for Elixir.  Continuously scans your project directory for changes.  When changes are found it runs your tests.

Example
-------
    
    $ /d/hibiscus/hibiscus
    Hibiscus monitoring d:/Elixir/gettingstarted
    changes found. Running Tests
    ....
    
        1) test true (KV.RegistryTest)
           test/registry_test.exs:26
           Assertion with == failed
           code: 1 + 1 == 3
           lhs:  2
           rhs:  3
           stacktrace:
             test/registry_test.exs:27
             
    .
    
    Finished in 0.06 seconds (0.06s on load, 0.00s on tests)
    6 tests, 1 failures
    
    Randomized with seed 821000

Usage
-----

1. `$ git clone https://github.com/reidev275/Hibiscus.git`
2. `cd hibiscus`
3. `$ mix escript.build`
4. Navigate to your working project's directory
5. `$ path/to/hibiscus`
6. Begin coding.  As you make changes to your files Hibiscus will automatically run your tests for you.
 
