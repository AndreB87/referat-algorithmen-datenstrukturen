% Andre Brand - 2286926
%
% ADP - Aufgabe 2 
%
% Achtung - fuer das randomisierte Pivot-Element wurde die Funktion random:uniform/1 verwendet
%           Die im Modul util verwendete Funktion rand:uniform/1 funktionierte auf meinem System nicht

-module(ksort).
-export([msort/1, qsort/3, split/2]).

-compile(ssort).

%*****************************************
% Merge Sort
%*****************************************
%
% Sortiert die uebergebene Liste mithilfe
% des Merge Sort Algorithmus
%
% @param: List - Zu sortierende Liste
% @out:   sortierte Liste
%*****************************************
msort(List) when is_list(List) ->
  do_msort(List).

% Hilfsfunktion Merge Sort
% 
% Wenn die anfaengliche Liste lediglich ein Element
% oder weniger besitzt, ist eine Sortierung nicht mehr notwendig
do_msort(Liste) when length(Liste) =< 1 ->
  Liste;

% Hilfsfunktion Merge Sort
% 
% Halbieren der Liste in zwei Teillisten
do_msort(List) ->
  {Left, Right} = split(length(List) div 2, List),
  merge(do_msort(Left), do_msort(Right)).


% Hilfsfunktion Merge Sort - Split
% 
% Teilt die zwei Listen in eine neue Liste auf.
split(Mid, List) ->
  do_split(Mid, [], List, 1).

% Hilfsfunktion Merge Sort - Split
% 
% Teilt die zwei Listen in eine neue Liste auf.
% Hier: Rueckgabe der aufgeteilten Listen,
%       wenn die Mitte erreicht wurde
do_split(Mid, LeftList, RightList, Count) when Count > Mid -> 
  {LeftList, RightList};

% Hilfsfunktion Merge Sort - Split
% 
% Teilt die zwei Listen in eine neue Liste auf.
% Hier: Der Kopf der urpruenglichen Liste wird entfernt
%       und an die neue gehaengt
do_split(Mid, LeftList, [H | T], Count) -> 
  do_split(Mid, [H | LeftList], T ,Count+1).


% Hilfsfunktion Merge Sort - Merge
% 
% Fuegt die beiden Listen sortiert wieder zusammen.
merge(LeftL, RightL) ->
  do_merge([], LeftL, RightL).

% Hilfsfunktion Merge Sort - Merge
% 
% Fuegt die beiden Listen sortiert wieder zusammen.
% Hier: Wenn beide Listen zusammengefuegt wurden, muss
%       die zusammengesetzte Liste gedreht werden,
%       da die Reihenfolge zum leichteren Hinzufuegen
%       der Elemente gedreht wurde   
do_merge(Merged, [], []) ->
  ssort:reverse(Merged);

% Hilfsfunktion Merge Sort - Merge
% 
% Fuegt die beiden Listen sortiert wieder zusammen.
do_merge(Merged, [LeftH | LeftT], []) -> 
  do_merge([LeftH | Merged], LeftT, []);

% Hilfsfunktion Merge Sort - Merge
% 
% Fuegt die beiden Listen sortiert wieder zusammen.
do_merge(Merged, [], [RightH | RightT]) -> 
  do_merge([RightH | Merged], [], RightT);

% Hilfsfunktion Merge Sort - Merge
% 
% Fuegt die beiden Listen sortiert wieder zusammen.
do_merge(Merged, [LeftH | LeftT], [RightH | RightT]) ->
  if
    LeftH =< RightH ->
      do_merge([LeftH | Merged], LeftT, [RightH | RightT]);
    true ->
      do_merge([RightH | Merged], [LeftH | LeftT], RightT)
  end.

%*****************************************
% Quick Sort
%*****************************************
%
% Sortiert die uebergebene Liste mithilfe
% des Quick Sort Algorithmus
%
% @param: List - Zu sortierende Liste
% @out:   sortierte Liste
%*****************************************
% Hier: Wenn die Laenge der Liste kleiner ist
%       als die SwitchNr, dann wird Insertion Sort
%       zur Sortierung verwendet
qsort(_Pivot, List, SwitchNo) when length(List) =< SwitchNo ->
  ssort:insertionS(List);

% Quick Sort
% 
% Starten der QuickSort Funktion mit linkem Pivot-Element
qsort(left, List, _SwitchNo) when is_list(List) ->
  do_qsort(left, List);

% Quick Sort
% 
% Starten der QuickSort Funktion mit mittlerem Pivot-Element
qsort(middle, List, _SwitchNo) when is_list(List) ->
  do_qsort(middle, List);

% Quick Sort
% 
% Starten der QuickSort Funktion mit rechtem Pivot-Element
qsort(right, List, _SwitchNo) when is_list(List) ->
  do_qsort(right, List);

% Quick Sort
% 
% Starten der QuickSort Funktion mit dem Median als Pivot-Element
qsort(median, List, _SwitchNo) when is_list(List) ->
  do_qsort(median, List);

% Quick Sort
% 
% Starten der QuickSort Funktion mit randomisiertem Pivot-Element
qsort(random, List, _SwitchNo) when is_list(List) ->
  do_qsort(random, List);

% Quick Sort
% 
% Fehlerausgabe, wenn PivotElement falsch angegeben wurde
qsort(_Pivot, List, _SwitchNo) when is_list(List) ->
  falsches_Pivot_Element;

% Quick Sort
% 
% Fehlerausgabe, wenn uebergebenes Element keine Liste ist.
qsort(_Pivot, _List, _SwitchNo) ->
  keine_Liste.



% Hilfsfunktion Quick Sort
% 
% Falls Liste leer ist oder nur ein Element beinhaltet,
% braucht sie nicht sortiert werden
do_qsort(_PivM, List) when length(List) =< 1 ->
  List;

% Hilfsfunktion Quick Sort
% 
% Sortierung der Liste mit linkem PivotElemen
do_qsort(left, List) ->
  Pivot = getLeftPivot(List),
  ListLeft = lowerThanPivot([], List, Pivot),
  {ListMid, ListRight} = greaterThanPivot([], [], List, Pivot),
  concat(do_qsort(left, ListLeft), concat(ListMid, do_qsort(left, ListRight)));


% Hilfsfunktion Quick Sort
% 
% Sortierung der Liste mit linkem PivotElemen
do_qsort(middle, List) ->
  Pivot = getMiddlePivot(List),
  ListLeft = lowerThanPivot([], List, Pivot),
  {ListMid, ListRight} = greaterThanPivot([], [], List, Pivot),
  concat(do_qsort(middle, ListLeft), concat(ListMid, do_qsort(middle, ListRight)));


% Hilfsfunktion Quick Sort
% 
% Sortierung der Liste mit linkem PivotElemen
do_qsort(right, List) ->
  Pivot = getRightPivot(List),
  ListLeft = lowerThanPivot([], List, Pivot),
  {ListMid, ListRight} = greaterThanPivot([], [], List, Pivot),
  concat(do_qsort(right, ListLeft), concat(ListMid, do_qsort(right, ListRight)));


% Hilfsfunktion Quick Sort
% 
% Sortierung der Liste mit linkem PivotElemen
do_qsort(median, List) ->
  Pivot = getMedPivot(List),
  ListLeft = lowerThanPivot([], List, Pivot),
  {ListMid, ListRight} = greaterThanPivot([], [], List, Pivot),
  concat(do_qsort(median, ListLeft), concat(ListMid, do_qsort(median, ListRight)));


% Hilfsfunktion Quick Sort
% 
% Sortierung der Liste mit linkem PivotElemen
do_qsort(random, List) ->
  Pivot = getRandomPivot(List),
  ListLeft = lowerThanPivot([], List, Pivot),
  {ListMid, ListRight} = greaterThanPivot([], [], List, Pivot),
  concat(do_qsort(median, ListLeft), concat(ListMid, do_qsort(median, ListRight))).



% Hilfsfunktion Quick Sort
% 
% Liefert das linke PivotElement
getLeftPivot([Pivot | _Rest]) ->
  Pivot.


% Hilfsfunktion Quick Sort
% 
% Liefert das mittlere PivotElement
getMiddlePivot(List) ->
  do_getMiddlePivot(List, length(List) div 2).

do_getMiddlePivot([Pivot | _Rest], Count) when Count =< 1 ->
  Pivot;

do_getMiddlePivot([_H | Rest], Count) ->
  do_getMiddlePivot(Rest, Count-1).



% Hilfsfunktion Quick Sort
% 
% Liefert das rechte PivotElement
getRightPivot([Pivot | []]) ->
  Pivot;

getRightPivot([_Pivot | Rest]) ->
  getRightPivot(Rest).



% Hilfsfunktion Quick Sort
% 
% Liefert den Median der PivotElemente
getMedPivot(List) ->
  do_getMedPivot(getLeftPivot(List), getRightPivot(List), getMiddlePivot(List)).

do_getMedPivot(Left, Right, Middle) when Left >= Right andalso Left =< Middle ->
  Left;

do_getMedPivot(Left, Right, Middle) when Left =< Right andalso Left >= Middle ->
  Left;

do_getMedPivot(Left, Right, Middle) when Right >= Left andalso Right =< Middle ->
  Right;

do_getMedPivot(Left, Right, Middle) when Right =< Left andalso Right >= Middle ->
  Right;

do_getMedPivot(Left, Right, Middle) when Middle >= Right andalso Middle =< Left ->
  Middle;

do_getMedPivot(Left, Right, Middle) when Middle =< Right andalso Middle >= Left ->
  Middle.


% Hilfsfunktion Quick Sort
% 
% Liefert ein randomisiertes PivotElement
getRandomPivot(List) ->
  do_getMiddlePivot(List, random:uniform(length(List))).



% Hilfsfunktion Quick Sort
% 
% Liefert alle Elemente der Liste, die kleiner als das PivotElement
% sind, in einer neuen Liste zurueck
lowerThanPivot(LowerList, [], _Pivot) ->
  LowerList;

lowerThanPivot(LowerList, [H | T], Pivot) when Pivot > H ->
  lowerThanPivot([H | LowerList], T, Pivot);

lowerThanPivot(LowerList, [_H | T], Pivot) ->
  lowerThanPivot(LowerList, T, Pivot).


  
% Hilfsfunktion Quick Sort
% 
% Liefert alle Elemente der Liste, die groesser als das PivotElement
% sind, in einer neuen Liste zurueck
% Zudem werden alle Elemente, die gleich dem PivotElement sind
% ebenfalls in einer Liste zurueckgeliefert
greaterThanPivot(PivList, GreaterList, [], _Pivot) ->
  {PivList, GreaterList};

greaterThanPivot(PivList, GreaterList, [H | T], Pivot) when Pivot < H ->
  greaterThanPivot(PivList, [H | GreaterList], T, Pivot);

greaterThanPivot(PivList, GreaterList, [H | T], Pivot) when Pivot == H ->
  greaterThanPivot([H | PivList], GreaterList, T, Pivot);

greaterThanPivot(PivList, GreaterList, [_H | T], Pivot) ->
  greaterThanPivot(PivList, GreaterList, T, Pivot).


% Concat
% 
% Fuegt zwei Listen zusammen
concat([], Right) ->
  Right;

concat(Left, []) -> 
  Left;

concat(Left, Right) -> 
  do_concat(ssort:reverse(Left), Right).

do_concat([], Right) ->
  Right;

do_concat([H | T], Right) ->
  do_concat(T, [H | Right]).


