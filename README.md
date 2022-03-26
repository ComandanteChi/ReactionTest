# Reaction Test (Reaktionstest)
Das Programm wurde mit Hilfe von Vivado Studio erstellt. Das Programm wurde auf VHDL geschrieben.
## Einleitung
„Reaction Test“ ist eine integrierte Schaltung die für Reaktionstest der Patienten mit der Reaktionstörung geeignet ist.
## Funktionsweise.
Nach Betätigung der „Start“ Tasten wird nach 5 Sekunden den
Ausgang „Output“ gesetzt. Wenn danach innerhalb von einer definierten Zeit von
50 ms der „Button“ Taster betätigt wird, dann soll als Ergebnis der
Ausgang „Green“ leuchten, wenn die Zeit zwischen 50 ms und 500 ms
liegt, dann soll Ausgang „Yellow“ leuchten, darüber wird der Ausgang „Red“ leuchten.
Der Ausgang soll bei neuerlichem betätigen von „Start“ wieder rückgesetzt werden.

![Schema](https://github.com/ComandanteChi/ReactionTest/blob/main/Images/schematic.png)

![Simulationsergebnis](https://github.com/ComandanteChi/ReactionTest/blob/main/Images/Simulation_20sec_1kHz.PNG)
