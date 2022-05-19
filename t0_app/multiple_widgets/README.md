# multiple_widgets

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Disporre più widget verticalmente e orizzontalmente

Uno dei modelli di layout più comuni consiste nel disporre i widget verticalmente o orizzontalmente. Puoi utilizzare **Row** per disporre i widget orizzontalmente e **Column** per disporre i widget verticalmente.

* Row e Column sono due dei modelli di layout più comunemente usati.
* Row, Column ognuno prende un elenco di widget figlio.
* Un widget figlio può essere esso stesso un widget Row, Column o un altro widget complesso.
* È possibile specificare come un Row o Column allinea i suoi figli, sia verticalmente che orizzontalmente.
* Puoi allungare o limitare specifici widget figlio.
* Puoi specificare in che modo i widget figlio utilizzano lo spazio disponibile di Row o Column.

Per creare una riga o una colonna in Flutter, aggiungi un elenco di widget figli a un Row o Column. A sua volta, ogni figlio può essere esso stesso una riga o una colonna ecc. L'esempio seguente mostra come è possibile annidare righe o colonne all'interno di righe o colonne.

Questo layout è organizzato come Row. la riga contiene due figli:
* una colonna a sx
* un'immagine a dx.

![img](https://docs.flutter.dev/assets/images/docs/ui/layout/pavlova-diagram.png)

L'albero dei widget della colonna di sx nidifca righe e colonne:
![img](https://docs.flutter.dev/assets/images/docs/ui/layout/pavlova-left-column-diagram.png)

 ### Nota: Row e Columnsono widget primitivi di base per layout orizzontali e verticali: questi widget di basso livello consentono la massima personalizzazione. Flutter offre anche widget specializzati di livello superiore che potrebbero essere sufficienti per le tue esigenze. Ad esempio, al posto di Rowte potresti preferire ListTile, un widget facile da usare con proprietà per le icone iniziali e finali e fino a 3 righe di testo. Invece di Colonna, potresti preferire ListView, un layout simile a una colonna che scorre automaticamente se il suo contenuto è troppo lungo per adattarsi allo spazio disponibile. Per ulteriori informazioni, consulta Widget di layout comuni .

Diamo un'occhiata al codice per la sezione delineata del seguente layout:

![img](https://docs.flutter.dev/assets/images/docs/ui/layout/pavlova-large-annotated.png)

La sezione delineata è implementata come due righe. La riga delle valutazioni contiene cinque stelle e il numero di recensioni. La riga delle icone contiene tre colonne di icone e testo.

L'albero dei widget per la riga delle valutazioni:
![img](https://docs.flutter.dev/assets/images/docs/ui/layout/widget-tree-pavlova-rating-row.png)

La variabile ratings crea una riga contenente una riga più piccola di icone a 5 stelle e testo:

```c++
var stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    const Icon(Icons.star, color: Colors.black),
    const Icon(Icons.star, color: Colors.black),
  ],
);

final ratings = Container(
  padding: const EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      stars,
      const Text(
        '170 Reviews',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: 20,
        ),
      ),
    ],
  ),
);
```

### Suggerimento: per ridurre al minimo la confusione visiva che può derivare da codice di layout fortemente nidificato, implementa parti dell'interfaccia utente in variabili e funzioni.

La riga delle icone, sotto la riga delle valutazioni, contiene 3 colonne; ogni colonna contiene un'icona e due righe di testo, come puoi vedere nel suo albero dei widget:

![img](https://docs.flutter.dev/assets/images/docs/ui/layout/widget-tree-pavlova-icon-row.png)

La variabile iconList definisce la riga delle icone:

```c++
const descTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

// DefaultTextStyle.merge() allows you to create a default text
// style that is inherited by its child and all subsequent children.
final iconList = DefaultTextStyle.merge(
  style: descTextStyle,
  child: Container(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.kitchen, color: Colors.green[500]),
            const Text('PREP:'),
            const Text('25 min'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.timer, color: Colors.green[500]),
            const Text('COOK:'),
            const Text('1 hr'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.restaurant, color: Colors.green[500]),
            const Text('FEEDS:'),
            const Text('4-6'),
          ],
        ),
      ],
    ),
  ),
);
```

La variabile leftColumn contiene le righe delle valutazioni e delle icone, nonché il titolo e il testo che descrive la Pavlova:

```c++
final leftColumn = Container(
  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
  child: Column(
    children: [
      titleText,
      subTitle,
      ratings,
      iconList,
    ],
  ),
);
```

La colonna di sinistra è posizionata in a SizedBoxper vincolarne la larghezza. Infine, l'interfaccia utente è costruita con l'intera riga (contenente la colonna di sinistra e l'immagine) all'interno di un file Card.

L' immagine di Pavlova è da Pixabay . Puoi incorporare un'immagine dalla rete usando Image.network()ma, per questo esempio, l'immagine viene salvata in una directory images nel progetto, aggiunta al file pubspec e accessibile usando Images.asset(). Per ulteriori informazioni, consulta Aggiunta di risorse e immagini .

```c++
body: Center(
  child: Container(
    margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
    height: 600,
    child: Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 440,
            child: leftColumn,
          ),
          mainImage,
        ],
      ),
    ),
  ),
),
```

#### Suggerimento: l'esempio Pavlova funziona meglio in orizzontale su un dispositivo ampio, come un tablet. Se stai eseguendo questo esempio nel simulatore iOS, puoi selezionare un dispositivo diverso utilizzando il menu Hardware > Dispositivo . Per questo esempio, consigliamo l'iPad Pro. Puoi cambiarne l'orientamento in modalità orizzontale usando Hardware > Ruota . Puoi anche cambiare la dimensione della finestra del simulatore (senza cambiare il numero di pixel logici) usando Finestra > Scala .
