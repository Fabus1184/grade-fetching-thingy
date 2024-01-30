[![Haskell CI](https://github.com/Fabus1184/grade-fetching-thingy/actions/workflows/haskell.yml/badge.svg)](https://github.com/Fabus1184/grade-fetching-thingy/actions/workflows/haskell.yml)

# Grade fetching thingy

Username and password are read from the environment variables `USERNAME` and `PASSWORD` respectively.

Example output:
```
╔════════════╦════════════════════════════════════════════════════╦════════════╦════════════╦════════════╦════════════╦════════════╗
║ PrüfNr.    ║ Prüfungstext                                       ║ Semester   ║ Note       ║ Status     ║ ECTS       ║ Versuch    ║
╠════════════╬════════════════════════════════════════════════════╬════════════╬════════════╬════════════╬════════════╬════════════╣
║ 8228       ║ Multicore Systems Programming and Performance      ║ SS 23      ║ 1.0        ║ BE         ║ 5.0        ║ 1          ║
║ 82280      ║ Multicore Systems Programming and Performance      ║ SS 23      ║ 1.0        ║ BE         ║ 5.0        ║ 1          ║
║ 8067       ║ Betriebssysteme                                    ║ SS 23      ║ 2.0        ║ BE         ║ 5.0        ║ 1          ║
║ 80670      ║ Betriebssysteme                                    ║ SS 23      ║ 2.0        ║ BE         ║ 5.0        ║ 1          ║
║ 5054       ║ Web-Engineering                                    ║ SS 23      ║ 3.0        ║ BE         ║ 5.0        ║ 1          ║
║ 50540      ║ Web-Engineering                                    ║ SS 23      ║ 3.0        ║ BE         ║ 5.0        ║ 1          ║
║ 8247       ║ Realtime Systems                                   ║ SS 23      ║ 4.0        ║ BE         ║ 5.0        ║ 1          ║
║ 82470      ║ Realtime Systems                                   ║ SS 23      ║ 4.0        ║ BE         ║ 5.0        ║ 1          ║
║ 8047       ║ Stochastik                                         ║ SS 23      ║ 5.0        ║ NB         ║ 5.0        ║ 1          ║
║ 80470      ║ Stochastik                                         ║ SS 23      ║ 5.0        ║ NB         ║ 5.0        ║ 1          ║
║ 80570      ║ Software Engineering                               ║ SS 23      ║ 6.0        ║ NB         ║ 5.0        ║ 1          ║
║ 80471      ║ Stochastik                                         ║ SS 23      ║            ║ BE         ║ 0.0        ║ 1          ║
║ 80571      ║ Software Engineering                               ║ SS 23      ║            ║ BE         ║ 0.0        ║ 1          ║
║ 80671      ║ Betriebssysteme                                    ║ SS 23      ║            ║ BE         ║ 0.0        ║ 1          ║
║ 82471      ║ Realtime Systems                                   ║ SS 23      ║            ║ BE         ║ 0.0        ║ 1          ║
╠════════════╬════════════════════════════════════════════════════╬════════════╬════════════╬════════════╬════════════╬════════════╣
║ 8237       ║ Embedded Systems                                   ║ WS 22/23   ║ 1.0        ║ BE         ║ 5.0        ║ 1          ║
║ 82370      ║ Embedded Systems                                   ║ WS 22/23   ║ 1.0        ║ BE         ║ 5.0        ║ 1          ║
║ 8007       ║ Analysis 2                                         ║ WS 22/23   ║ 2.0        ║ BE         ║ 5.0        ║ 1          ║
║ 8017       ║ Programmieren 3                                    ║ WS 22/23   ║ 2.0        ║ BE         ║ 5.0        ║ 1          ║
║ 8037       ║ Fachenglisch                                       ║ WS 22/23   ║ 3.0        ║ BE         ║ 5.0        ║ 1          ║
║ 8207       ║ Digital Systems                                    ║ WS 22/23   ║ 3.0        ║ BE         ║ 5.0        ║ 1          ║
║ 80070      ║ Analysis 2                                         ║ WS 22/23   ║ 4.0        ║ BE         ║ 5.0        ║ 1          ║
║ 80170      ║ Programmieren 3                                    ║ WS 22/23   ║ 4.0        ║ BE         ║ 5.0        ║ 1          ║
║ 80370      ║ Fachenglisch                                       ║ WS 22/23   ║ 5.0        ║ NB         ║ 5.0        ║ 1          ║
║ 82070      ║ Digital Systems                                    ║ WS 22/23   ║ 5.0        ║ NB         ║ 5.0        ║ 1          ║
║ 8027       ║ Algorithmen u. Datenstrukturen                     ║ WS 22/23   ║ 6.0        ║ NB         ║ 5.0        ║ 1          ║
║ 80270      ║ Algorithmen und Datenstrukturen                    ║ WS 22/23   ║ 6.0        ║ NB         ║ 5.0        ║ 1          ║
║ 80071      ║ Analysis 2                                         ║ WS 22/23   ║            ║ BE         ║ 0.0        ║ 1          ║
║ 80171      ║ Programmieren 3                                    ║ WS 22/23   ║            ║ BE         ║ 0.0        ║ 1          ║
║ 80271      ║ Algorithmen und Datenstrukturen                    ║ WS 22/23   ║            ║ BE         ║ 0.0        ║ 1          ║
║ 82071      ║ Digital Systems                                    ║ WS 22/23   ║            ║ BE         ║ 0.0        ║ 1          ║
║ 82371      ║ Embedded Systems                                   ║ WS 22/23   ║            ║ BE         ║ 0.0        ║ 1          ║
╚════════════╩════════════════════════════════════════════════════╩════════════╩════════════╩════════════╩════════════╩════════════╝
```
