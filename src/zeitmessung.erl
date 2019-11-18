% Andre Brand - 2286926
%
% ADP - Aufgabe 2 
%
% Achtung - im Modul ksort.erl wurde fuer das randomisierte Pivot-Element die Funktion random:uniform/1 verwendet
%           Die im Modul util.erl verwendete Funktion rand:uniform/1 funktionierte auf meinem System nicht

-module(zeitmessung).
-export([runTests/0, runLonelyTests/1, runOwnTest/2]).

-compile(ssort).
-compile(ksort).
-compile(util).

% Startet eine Zeitmessung mit unsortierten Listen ohne Dulikate
% mit 10 bis zu 50.000 Elementen
runTests() ->
  runTests(10).


runTests(ListenLaenge) when ListenLaenge < 100 ->
  runLonelyTests(ListenLaenge),
  runTests(ListenLaenge + 10);
  
runTests(ListenLaenge) when ListenLaenge < 1000 ->
  runLonelyTests(ListenLaenge),
  runTests(ListenLaenge + 100);

runTests(ListenLaenge) when ListenLaenge < 10000 ->
  runLonelyTests(ListenLaenge),
  runTests(ListenLaenge + 1000);

runTests(ListenLaenge) when ListenLaenge =< 50000 ->
  runLonelyTests(ListenLaenge),
  runTests(ListenLaenge + 5000);

runTests(_ListenLaenge) ->
  ende.


% Startet eine Zeitmessung mit einer Liste mit
% der übergebenen Anzahl an Elementen
runLonelyTests(ListenLaenge) ->
  runInsertionSTest(ListenLaenge),
  runSelectionSTest(ListenLaenge),
  runMSortTest(ListenLaenge),
  runQSortTest(ListenLaenge, left, 0),
  runQSortTest(ListenLaenge, middle, 0),
  runQSortTest(ListenLaenge, right, 0),
  runQSortTest(ListenLaenge, median, 0),
  runQSortTest(ListenLaenge, random, 0).


runInsertionSTest(ListenLaenge) ->
  Start = getMilliSecs(),
  ssort:insertionS(util:randomliste(ListenLaenge)),
  End  = getMilliSecs(),
  Zeit = End - Start,
  Zeile = lists:concat([insertionS, ";", ListenLaenge,";",Zeit,";","\n"]),
  util:logging(lists:concat(["Zeitmessung/",insertionS,".txt"]), Zeile).

runSelectionSTest(ListenLaenge) ->
  Start = getMilliSecs(),
  ssort:selectionS(util:randomliste(ListenLaenge)),
  End  = getMilliSecs(),
  Zeit = End - Start,
  Zeile = lists:concat([selectionS, ";", ListenLaenge,";",Zeit,";","\n"]),
  util:logging(lists:concat(["Zeitmessung/",selectionS,".txt"]), Zeile).

runMSortTest(ListenLaenge) ->
  Start = getMilliSecs(),
  ksort:msort(util:randomliste(ListenLaenge)),
  End  = getMilliSecs(),
  Zeit = End - Start,
  Zeile = lists:concat([msort, ";", ListenLaenge,";",Zeit,";","\n"]),
  util:logging(lists:concat(["Zeitmessung/",msort,".txt"]), Zeile).

runQSortTest(ListenLaenge, Pivot, Switch) ->
  Start = getMilliSecs(),
  ksort:qsort(Pivot, util:randomliste(ListenLaenge), Switch),
  End  = getMilliSecs(),
  Zeit = End - Start,
  Zeile = lists:concat([qsort, ";", Pivot, ";", ListenLaenge,";",Zeit,";","\n"]),
  util:logging(lists:concat(["Zeitmessung/",qsort, Pivot, ".txt"]), Zeile).


% Startet einen Test mit einer übergebenen Liste
% Titel wird für das Dokument, in der die Zeitmessung gespeichert wird als Atom benötigt
runOwnTest(Liste, Title) ->
  runOwnInsertionSTest(Liste, Title),
  runOwnSelectionSTest(Liste, Title),
  runOwnMSortTest(Liste, Title),
  runOwnQSortTest(Liste, left, 0, Title),
  runOwnQSortTest(Liste, middle, 0, Title),
  runOwnQSortTest(Liste, right, 0, Title),
  runOwnQSortTest(Liste, median, 0, Title),
  runOwnQSortTest(Liste, random, 0, Title).


runOwnInsertionSTest(Liste, Title) ->
  Start = getMilliSecs(),
  ssort:insertionS(Liste),
  End  = getMilliSecs(),
  Zeit = End - Start,
  Zeile = lists:concat([insertionS, ";",length(Liste),";",Zeit,";","\n"]),
  util:logging(lists:concat(["Zeitmessung/",insertionS,Title,".txt"]), Zeile).

runOwnSelectionSTest(Liste, Title) ->
  Start = getMilliSecs(),
  ssort:selectionS(Liste),
  End  = getMilliSecs(),
  Zeit = End - Start,
  Zeile = lists:concat([selectionS, ";",length(Liste),";",Zeit,";","\n"]),
  util:logging(lists:concat(["Zeitmessung/",selectionS,Title,".txt"]), Zeile).

runOwnMSortTest(Liste, Title) ->
  Start = getMilliSecs(),
  ksort:msort(Liste),
  End  = getMilliSecs(),
  Zeit = End - Start,
  Zeile = lists:concat([msort, ";",length(Liste),";",Zeit,";","\n"]),
  util:logging(lists:concat(["Zeitmessung/",msort,Title,".txt"]), Zeile).

runOwnQSortTest(Liste, Pivot, Switch, Title) ->
  Start = getMilliSecs(),
  ksort:qsort(Pivot, Liste, Switch),
  End  = getMilliSecs(),
  Zeit = End - Start,
  Zeile = lists:concat([qsort, ";", Pivot, ";",length(Liste),";",Zeit,";","\n"]),
  util:logging(lists:concat(["Zeitmessung/",qsort, Pivot,Title,".txt"]), Zeile).


getTimeStamp() -> 
  os:timestamp().

timeStampToMilliSec({MegaSecs, Secs, MicroSecs}) ->
  (MegaSecs * 1000000) + (Secs * 1000) + (MicroSecs div 1000).

getMilliSecs() ->
  timeStampToMilliSec(getTimeStamp()).
 

