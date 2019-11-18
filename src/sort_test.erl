-module(sort_test).

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").


normal_test() ->
  ListeSortiert = util:sortliste(5000),
  ListeUnsortiert = util:shuffle(ListeSortiert),
  [?_assertEqual( ListeSortiert, ssort:insertionS(ListeUnsortiert) ),
   ?_assertEqual( ListeSortiert, ssort:selectionS(ListeUnsortiert) ),
   ?_assertEqual( ListeSortiert, ksort:msort(ListeUnsortiert) ),
   ?_assertEqual( ListeSortiert, ksort:qsort(left, ListeUnsortiert, 0) ),
   ?_assertEqual( ListeSortiert, ksort:qsort(middle, ListeUnsortiert, 0) ),
   ?_assertEqual( ListeSortiert, ksort:qsort(right, ListeUnsortiert, 0) ),
   ?_assertEqual( ListeSortiert, ksort:qsort(median, ListeUnsortiert, 0) ),
   ?_assertEqual( ListeSortiert, ksort:qsort(random, ListeUnsortiert, 0) )].

random_test() ->
  ListeUnsortiert = util:randomlisteD(5000,1,5000),
  [?_assertEqual( ssort:selectionS(ListeUnsortiert), ssort:insertionS(ListeUnsortiert) ),
   ?_assertEqual( ssort:insertionS(ListeUnsortiert), ksort:msort(ListeUnsortiert) ),
   ?_assertEqual( ssort:insertionS(ListeUnsortiert), ksort:qsort(left, ListeUnsortiert, 0) ),
   ?_assertEqual( ssort:insertionS(ListeUnsortiert), ksort:qsort(middle, ListeUnsortiert, 0) ),
   ?_assertEqual( ssort:insertionS(ListeUnsortiert), ksort:qsort(right, ListeUnsortiert, 0) ),
   ?_assertEqual( ssort:insertionS(ListeUnsortiert), ksort:qsort(median, ListeUnsortiert, 0) ),
   ?_assertEqual( ssort:insertionS(ListeUnsortiert), ksort:qsort(random, ListeUnsortiert, 0) )].

