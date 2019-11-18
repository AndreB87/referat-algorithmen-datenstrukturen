Im folgenden wird kurz dargelegt, wie die Sortieralgorithmen benutzt werden können. 
Vorbedingung ist, dass Erlang-OTP installiert ist. Die vorliegende Arbeit wurde
auf Erlang-OTP 19 (Eshell V8.3) erstellt und getestet. Die Funktionalität auf
anderen Versionen von Erlang kann nicht garantiert werden.

Alle Sortieralgorithmen befinden sich im Ordner /Code und müssen bei der
vorliegenden Konfiguration im selben Ordner vorhanden sein, da Abhängigkeiten
zwischen den Sortieralgorithmen vorliegen. Quicksort nutzt beispielsweise Insertionsort,
wenn dies durch die SwitchNr vorgesehen ist.

Die Sortieralgorithnen liegen in zwei Modulen vor. Mergesort und Quicksort sind in der Datei "ksort.erl",
InsertionSort und Selectionsort in der Datei "ssort.erl" zu finden.

Für die Zeitmessung ist die Datei "zeitmessung.erl" vorhanden.
**Startet einen Test mit einer übergebenen Liste
**Titel wird für das Dokument, in der die Zeitmessung gespeichert wird als Atom benötigt
zeitmessung:runOwnTest(Liste, Title).

**Startet eine Zeitmessung mit einer Liste mit
**der übergebenen Anzahl an Elementen
zeitmessung:runLonelyTests(ListenLaenge).

**Startet eine Zeitmessung mit unsortierten Listen ohne Dulikate
**mit 10 bis zu 50.000 Elementen
zeitmessung:runTests().

Starten Sie das Command Line Interface Ihres Betriebssystems und navigieren Sie 
in den /Code Ordner des Projekts. Starten Sie die Erlang-Shell.
Die Module müssen erst kompiliert werden, bevor sie genutzt werden können. Geben 
Sie hierzu "c('Modul')." in die Shell ein, mit 'Modul' für den Namen des Moduls,
für das KSort-Modul beispielsweise "c(ksort).". Danach können die
Module in der Form "'Modul':'Operation'." genutzt werden, mit 'Modul' 
für den Namen des Moduls und 'Operation' für die Operation des Moduls, also 
beispielsweise "ksort:msort(<Liste>).".
Hierbei ist zu beachten, dass eine Liste, die nur Zahlen als Elemente enthält, übergeben wird.
