-module(test).

-compile(ssort).
-compile(ksort).
-compile(sort_test).
-compile(util).
-compile(export_all).


startTest() ->
  eunit:test(sort_test).
