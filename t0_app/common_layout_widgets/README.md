# common_layout_widgets

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Common layout widgets
Flutter ha una ricca libreria di widget di layout. Ecco alcuni di quelli più comunemente usati. L'intento è quello di metterti in funzione il più rapidamente possibile, piuttosto che sopraffarti con un elenco completo.

I seguenti widget rientrano in due categorie: widget standard dalla libreria dei widget e widget specializzati dalla libreria dei materiali. Qualsiasi app può utilizzare la libreria dei widget, ma solo le app dei materiali possono utilizzare la libreria dei componenti dei materiali.

**Standard widget**
* Container: aggiunge spaziatura interna, margini, bordi, colore di sfondo e altre decorazioni.
* GridView: dispone i widget come una griglia scorrevole.
* ListView: dispone i widget come un elenco scorrevole.
* Stack: sovrappone un widget sopra un altro.

**Material widget**
* Card: organizza le informazioni correlate in una casella con angoli arrotondati e un'ombra discendente.
* ListTile: organizza fino a 3 righe di testo e iconi iniziali e finali opzionali in una riga.

### Container
Molti layout fanno un uso generoso di Container per separare i widget usando il riempimento o per aggiungere bordi o margini. È possibile modificare lo sfondo del dispositivo posizionando l'intero layout in un Container e modificandone il colore o l'immagine di sfondo.

*Riepilogo*:
* aggiunge padding, margini, bordi
* cambia colore o immagine sfondo
* contiene un singolo widget figlio, ma quel figlio può essere una riga, colonna o anche la radice di un albero di widget.

![img](https://docs.flutter.dev/assets/images/docs/ui/layout/margin-padding-border.png)

*Esempio*:
Questo layout è costituito da una colonna con due righe, ciascuna contenente 2 immagini. Un container viene utilizzato per cambiare colore di sfondo della colonna in un grigio più chiaro.
```c++
Widget _buildImageColumn() {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.black26,
    ),
    child: Column(
      children: [
        _buildImageRow(1),
        _buildImageRow(3),
      ],
    ),
  );
}

```

![img](https://docs.flutter.dev/assets/images/docs/ui/layout/container.png)

Un container è utilizzato anche per aggiungere un bordo arrotondato e margin per ogni immagine:
```c++
Widget _buildDecoratedImage(int imageIndex) => Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 10, color: Colors.black38),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4),
        child: Image.asset('images/pic$imageIndex.jpg'),
      ),
    );

Widget _buildImageRow(int imageIndex) => Row(
      children: [
        _buildDecoratedImage(imageIndex),
        _buildDecoratedImage(imageIndex + 1),
      ],
    );
```

For more tutorials on Container, click [here](https://docs.flutter.dev/development/ui/layout/tutorial) and for code click [here](https://github.com/flutter/website/tree/main/examples/layout/container)

### GridView
Usa un GridView per rappresentare una lista bidimensionale. Griview provvede a due liste prefabbricate o tu puoi costruirti le tue grid custom. Quando una GridView rileva che il suo contenuto è troppo grande per adattarsi alla casella di rendering, scorre automaticamente.

*Riepilogo*:
* Dispone i widget in una griglia.
* Rileva quando il contenuto della colonna supera la casella di rendering e fornisce automaticamente lo scorrimento.
* Crea la tua griglia personalizzata o usa una delle griglie standard:
    * GridView.count consente di specificare il numero di colonne
    * GridView.extent consente di specificare la larghezza massima in pixel in un riquadro.

#### Nota: quando si visualizza un elenco bidimensionale in cui è importate quale riga e colonna occupa una cella, utilizzare Table o DataTable.

*Esempio*:
![img](https://docs.flutter.dev/assets/images/docs/ui/layout/gridview-extent.png)

Utilizzato GridView.extent per creare una griglia con riquadri larghi al massimo 150px.
[Sorgente_codice:](https://github.com/flutter/website/tree/main/examples/layout/grid_and_list)

![img](https://docs.flutter.dev/assets/images/docs/ui/layout/gridview-count-flutter-gallery.png)

Usa GridView.count per creare una griglia larga 2 tessere in modalità verticale e larga 3 tessere in modalità orizzontale. I titoli vengono creati impostando il footer per ciascuno GridTile.

[Sorgente_codice:](https://github.com/flutter/gallery/tree/main/lib/demos/material/grid_list_demo.dart)

```c++
Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 150,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridTileList(30));

// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// The List.generate() constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
List<Container> _buildGridTileList(int count) => List.generate(
    count, (i) => Container(child: Image.asset('images/pic$i.jpg')));
```

## ListView
Un widget simile a una colonna, fornisce automaticamente lo scorrimento quando il suo contenuto è troppo lungo per la sua casella di rendering.

*Riepilogo*:
* Uno specializzato Column per l'organizzazione di un elenco
* Può essere disposto oriz. o vert.
* Rileva quando il suo contenuto non si adatta e fornisce lo scorrimento.
* Meno configurabile di Column, ma più immediato e facile.

*Esempi*:
![img](https://docs.flutter.dev/assets/images/docs/ui/layout/listview.png)

Utilizza ListView per visualizzare un elenco di aziende che utilizzano ListTile. Un Divider separa i teatri dai ristoranti.

[Sorgente_codice:](https://github.com/flutter/website/tree/main/examples/layout/grid_and_list)

![img](https://docs.flutter.dev/assets/images/docs/ui/layout/listview-flutter-gallery.png)

Utilizza ListView per visualizzare Colors dal Material Design per una particolare famiglia di colori.

[Sorgente_codice:](https://github.com/flutter/gallery/tree/main/lib/demos/reference/colors_demo.dart)

```c++
Widget _buildList() {
  return ListView(
    children: [
      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
      _tile('United Artists Stonestown Twin', '501 Buckingham Way',
          Icons.theaters),
      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
      const Divider(),
      _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
      _tile(
          'Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
      _tile('La Ciccia', '291 30th St', Icons.restaurant),
    ],
  );
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}
```

## Stack
Utilizza Stack per disporre i widget sopra un widget di base, spesso un'immagine. I widget possono sovrapporsi completamente o parzialmente al widget di base.

*Riepilogo*:
* Utilizzare per i widget che si sovrappongono ad un altro widget
* Il primo widget nell'elenco dei figli è il widget di base; i figli successivi vengono sovrapposti al widget di base.
* Lo Stack contenuto di A non può scorrere
* Puoi scegliere di ritagliare le immagini che superano la casella di rendering.

*Esempi*:
![img](https://docs.flutter.dev/assets/images/docs/ui/layout/stack.png)

Utilizza Stack per sovrapporre un Container (che visualizza Text su uno sfondo nero traslucido) sopra un CircleAvatar. Sposta il testo usando la proprietà alignment e Alignment.

[Sorgente_codice:](https://github.com/flutter/website/tree/main/examples/layout/card_and_stack)

![img](https://docs.flutter.dev/assets/images/docs/ui/layout/stack-flutter-gallery.png)

Utilizzato Stack per sovrapporre un'icona sopra un immagine.

[Sorgente_codice:](https://github.com/flutter/gallery/tree/main/lib/demos/material/bottom_navigation_demo.dart)

```c++
Widget _buildStack() {
  return Stack(
    alignment: const Alignment(0.6, 0.6),
    children: [
      const CircleAvatar(
        backgroundImage: AssetImage('images/pic.jpg'),
        radius: 100,
      ),
      Container(
        decoration: const BoxDecoration(
          color: Colors.black45,
        ),
        child: const Text(
          'Mia B',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
```

## Card
Una Card, dalla Libreria dei materiali , contiene informazioni correlate e può essere composto da quasi tutti i widget, ma viene spesso utilizzato con ListTile. Card ha un solo figlio, ma il suo figlio può essere una colonna, una riga, un elenco, una griglia o un altro widget che supporta più figli. Per impostazione predefinita, a Card riduce le sue dimensioni a 0 di 0 pixel. Puoi usarlo SizedBox per limitare le dimensioni di una carta.

In Flutter, una Card presenta angoli leggermente arrotondati e un'ombra esterna, che gli conferiscono un effetto 3D. La modifica Card di una elevation proprietà consente di controllare l'effetto ombra discendente. Impostando l'elevazione su 24, ad esempio, si solleva visivamente più Card lontano dalla superficie e fa sì che l'ombra diventi più dispersa.

*Riepilogo*:
* Implementa una carta Materiale
* Utilizzato per presentare pepite di informazioni correlate
* Accetta un singolo figlio, ma quel bambino può essere un widget Row, Columno un altro che contiene un elenco di bambini
* Visualizzato con angoli arrotondati e un'ombra discendente
* Il Card contenuto di A non può scorrere
* Dalla libreria dei materiali

*Esempi*:

![img](https://docs.flutter.dev/assets/images/docs/ui/layout/card.png)

Una Card contenente 3 ListTiles e ridimensionato avvolgendolo con un SizedBox. Un Divider separa il primo e il secondo ListTiles.

[sorgente_app](https://github.com/flutter/website/tree/main/examples/layout/card_and_stack)

![img](https://docs.flutter.dev/assets/images/docs/ui/layout/card-flutter-gallery.png)

Una Card contenente un'immagine e un testo.

[sorgente_app](https://github.com/flutter/gallery/tree/main/lib/demos/material/cards_demo.dart)

```c++
Widget _buildCard() {
  return SizedBox(
    height: 210,
    child: Card(
      child: Column(
        children: [
          ListTile(
            title: const Text(
              '1625 Main Street',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('My City, CA 99984'),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              '(408) 555-1212',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.contact_phone,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: const Text('costa@example.com'),
            leading: Icon(
              Icons.contact_mail,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    ),
  );
}
```

## ListTile
Usa ListTile, un widget di riga specializzato dalla Libreria dei materiali , per creare facilmente una riga contenente fino a 3 righe di testo e icone iniziali e finali opzionali. ListTileè più comunemente usato in Card o ListView, ma può essere usato altrove.

*Riepilogo*:
* Una riga specializzata che contiene fino a 3 righe di testo e icone opzionali
* Meno configurabile di Row, ma più facile da usare
* Dalla libreria dei materiali

*Esempi*:
![img](https://docs.flutter.dev/assets/images/docs/ui/layout/card.png)

Una card contenente 3 ListTile.

[sorgente_app](https://github.com/flutter/website/tree/main/examples/layout/card_and_stack)


![img](https://docs.flutter.dev/assets/images/docs/ui/layout/listtile-flutter-gallery.png)

Utilizza ListTile con i principali widget.

[sorgente_app](https://github.com/flutter/gallery/tree/main/lib/demos/material/list_demo.dart)

