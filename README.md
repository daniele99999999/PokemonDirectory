
# # PokemonDirectory

## Descrizione
Questa è una soluzione proposta per una CodeChallenge riguardante un app che mostri una lista di Pokemon con immagine e nome. Alla selezione della cella, l'app deve mostrare un dettaglio contenente nome, immagini, stats e typology del Pokemon in questione.
Le api sono pubbliche a questo indirizzo: https://pokeapi.co

questi i requirements:
1. Target SDK iOS 11
2. Meno librerie possibili
3. Ui dinamica con supporto per iPhone/iPad
e questi bonus:
4. funzionamento offilne
5. unit tests
6. aggiungere funzionalità utili


La struttura scelta prevede una architettura MVVM + Coordinator. Non avendo esperienza diretta con reactive, ma volendo comunque seguire MVVM, ho ripiegato sull'utilizzo delle closures per implementare aggiornamenti asincroni.
Sono presenti UnitTest per i vari componenti contenente logica.
E' stato previsto il funzionamento offline, e implementata la paginazione.

## Architettura
L'app è molto semplice. le schermate sono due
- lista di Pokemon 
- dettaglio dei un Pokemon

Il Coordinator e responsabile per la navigazione.
Ogni schermata prevede la suddivisione tipica dell'architettura MVVM con ViewModel e ViewController.
L’accesso ai dati e gestito dal repository, il quale contiene la logica che gestisce cache e network. 
I vari componenti sono indipendenti e progettati tramite protocols e dependency injection, in modo da assicurare la testabilità della logica tramite mock ad ogni livello.

## Note
La cache, puramente per una questione di tempistiche, e stata implementata con l'utilizzo di UserDefaults. Che non è ideale. In ogni caso, essendo progettata e implementata attraverso un protocollo, risulta facile sostituire l’implementazione concreta con qualsiasi altro data layer.
In assenza di requirements specifici, il repository prende sempre i dati dalla cache e se non trova nulla, va sul network.

## Requisiti
Target SDK 11.0. 
Sviluppato su Xcode 11.3.

## Installazione
Non essendoci nessuna dipendenza e gestore di dipendenze, è sufficiente aprire il progetto ed eseguire l'app

## Author

Daniele99999999

## Licenza

PokemonDirectory è disponibile con la licenza MIT. Vedere il file LICENSE per maggiori informazioni
