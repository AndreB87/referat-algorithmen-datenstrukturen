% Andre Brand - 2286926
%
% ADP - Aufgabe 2 
%
% Achtung - im Modul ksort.erl wurde fuer das randomisierte Pivot-Element die Funktion random:uniform/1 verwendet
%           Die im Modul util.erl verwendete Funktion rand:uniform/1 funktionierte auf meinem System nicht

-module(ssort).
-export([insertionS/1, selectionS/1, reverse/1]).


%*****************************************
% Insertion Sort
%*****************************************
%
% Sortiert die uebergebene Liste mithilfe
% des Selection Sort Algorithmus
%
% @param: List - Zu sortierende Liste
% @out:   sortierte Liste
%*****************************************
insertionS(List) when is_list(List) ->
  do_insertionS(List, []).


% Hilfsfunktion Insertion Sort
% 
% Wenn die anfaengliche Liste leer ist, ist die Sortierung fertig
do_insertionS([], Done) ->
  Done;

% Hilfsfunktion Insertion Sort
% 
% Fuegt den Kopf der unsortierten Liste an die richtige Stelle 
% der sortierten Liste ein
do_insertionS([H | T], Sorted) -> 
  do_insertionS(T, insert(Sorted, H)).


% Hilfsfunktion Insertion Sort
% 
% Fuegt den Kopf der unsortierten Liste an die richtige Stelle 
% der sortierten Liste ein
% Hier: Wenn die unsortierte Liste leer ist,
%       kann die sortierte Liste zurueckgegeben werden
insert([], Elem) -> 
  [Elem];

% Hilfsfunktion Insertion Sort
% 
% Fuegt den Kopf der unsortierten Liste an die richtige Stelle 
% der sortierten Liste ein
% Hier: Wenn das uebergebene Element kleiner ist, als der Kopf der
%       sortierten Liste, wird das Element vorne angefuegt
insert([H | T], Elem) when Elem =< H ->
  [Elem | [H | T]];

% Hilfsfunktion Insertion Sort
% 
% Fuegt den Kopf der unsortierten Liste an die richtige Stelle 
% der sortierten Liste ein
% Hier: Wenn das uebergebene Element groesser ist, als der Kopf der
%       sortierten Liste, wird der Rest der vorhandenen Liste rekursiv
%       weiter ueberprueft
insert([H | T], Elem) ->
  [H | insert(T, Elem)].


%*****************************************
% Selection Sort
%*****************************************
%
% Sortiert die uebergebene Liste mithilfe
% des Selection Sort Algorithmus
%
% @param: List - Zu sortierende Liste
% @out:   sortierte Liste
%*****************************************
selectionS(List) when is_list(List) ->
  do_selectionS(List, []).

% Hilfsfunktion Selection Sort
% 
% Wenn die anfaengliche Liste leer ist, ist die Sortierung fertig
do_selectionS([], Done) -> 
  Done;

% Hilfsfunktion Selection Sort
% 
% Sucht mit Hilfe der Funktion select das Minimun der zu sortierenden Liste 
% und fuegt es an das Ende der sortierten Liste 
do_selectionS([H | T], Sorted) ->
  {Min, Other} = select([], H, T),
  do_selectionS(Other, reverse([Min | reverse(Sorted)])).


% Hilfsfunktion fuer Selection Sort
% 
% Sucht das Minimum aus der uebergebenen Liste und gibt dieses,
% sowie den Rest der Liste(ohne Minimum) zurueck
select(Other, Min, []) ->
  {Min, Other};

% Hilfsfunktion fuer Selection Sort
% 
% Sucht das Minimum aus der uebergebenen Liste und gibt dieses,
% sowie den Rest der Liste(ohne Minimum) zurueck
% Hier: Neuer minimaler Wert wurde gefunden und der alte wird in
%       die Liste der restlichen Werte eingefuegt
select(Other, Min, [H | T]) when Min >= H ->
  select([Min | Other], H, T);

% Hilfsfunktion fuer Selection Sort
% 
% Sucht das Minimum aus der uebergebenen Liste und gibt dieses,
% sowie den Rest der Liste(ohne Minimum) zurueck
% Hier: Kein neuer Minimalwert wird gefunden und es wird weitergesucht.
select(Other, Min, [H | T]) ->
  select([H | Other], Min, T).



%*****************************************
% Reverse
%*****************************************
%
% Dreht eine Liste um, damit ein Element
% an das Ende einer Liste angehaengt
% werden kann
%
% @param: List - Zu drehende Liste
% 
% @out:   gedrehte Liste
%*****************************************
% Hier: Wenn die zu drehende Liste leer ist,
%       muss sie nicht gedreht werden
reverse([]) ->
  [];

% Hier: Aufruf der Hilfsfunktion zu Reverse
reverse(List) ->
  do_reverse([], List).

% Hilfsfunktion fuer Reverse
% 
% Wenn der Rest der zu drehenden Liste leer ist, muss nur noch der verbliebende Kopf
% an das vordere Ende der gedrehten Liste angefuegt werden.
do_reverse(RevList, [H | []]) ->
  [H | RevList];

% Hilfsfunktion fuer Reverse
% 
% Anfuegen des Kopfes der zu drehenden Liste an die gedrehte Liste,
% um den Rest der zu drehenden Liste zu bearbeiten.
do_reverse(RevList, [H | T]) ->
  do_reverse([H | RevList], T).

