# layouts_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Layout a widget

I widget sono classi utilizzate per creare UI. I widget vengono utilizzati sia per il layout che per gli elementi UI. Componi widget semplici per creare widget complessi.

Il fulcro del meccanismo di layout di Flutter sono i widget. In Flutter, quasi tutto è un widget, anche i modelli di layout sono widget. Le immagini, le icone e il testo che vedi in un'app Flutter sono tutti widget. Ma le cose che non vedi sono anche i widget, come le riche, le colonne, e le griglie che dispongono, vincolano e allineano i widget visibili.

Puoi creare un layout componendo widget per creare widget più complessi. Ad esempio, qui sotto vengono mostrate 3 icone con un'etichetta sotto ciascuna:
![image](https://docs.flutter.dev/assets/images/docs/ui/layout/lakes-icons.png)

E questo invece mostra il layout visivo, mostrando una riga di 3 colonne in cui ogni colonna contiene un'icona e un'etichetta.
![image](https://docs.flutter.dev/assets/images/docs/ui/layout/lakes-icons-visual.png)

Ecco un diagramma dell'albero dei widget per questa interfaccia utente:

![image](https://docs.flutter.dev/assets/images/docs/ui/layout/sample-flutter-layout.png)


La maggior partre di questo dovrebbe apparire come ci si potrebbe aspettare, ma potresti chiederti dei *container*. **Container** è una classe widget che ti permette di personalizzare il suo widget figlio. Utilizzare Container quando si desidera aggiungere spaziatura interna, margini, bordi o colore di sfondo per richiamare alcune delle proprietà. 

In questo esempio, ogni **Text** widget viene posizionato in un Container per aggiungere margini. L'intero **Row** è posizionato anch'esso in un Container per aggiungere imbottitura attorno alla riga.

Il resto dell'UI è controllato dalle proprietà. Imposta il colore di un **Icon** utilizzando la proprietà *color*. Utilizzando *Text.style* si imposta il font, il colore, lo spessore, ecc. Colonne e righe hanno proprietà che consentono di specificare come i loro figli sono allineati verticalmente o orizzontalmente e quanto spazio devono occupare i figli.

#### Come si dispone un widget?

## **1. Select a layout widget**
Scegli tra una varietà di widget di layout in base a come desideri allineare o vincolare il widget visibile. Questo esempio usa *Center* che centra il suo contenuto orizzontalmente e verticalmente.

## **2. Crea un widget visibile**
Crea un *Text* widget:
```c++
Text('Hello World'),
```

Crea un *Image* widget:
```c++
Image.asset(
  'images/lake.jpg',
  fit: BoxFit.cover,
),
```

Crea un *Icon* widget:
```c++
Icon(
  Icons.star,
  color: Colors.red[500],
),
```

## **3. Aggiungi il widget visibile al layout**
Tutti i widget del layout hanno uno dei seguenti:
* Una proprietà **child** se prendono un figlio singolo, ad esempio Center o Container
* Una proprietà **children** se accetta un elenco di widget, ad esempio Row o ColumnListViewStack.

Aggiungi il Text widget al Center widget:
```c++
const Center(
  child: Text('Hello World'),
),
```

## **4. Aggiungi il widget layout alla pagina**
Un'app Flutter è essa stessa un widget e la maggior parte dei widget ha un metodo **build()**. L'instanziazione e la restituzione di un widget nel build() dell'app visualizza il widget.

**Material App**
Per un'app *Material*, puoi utilizzare un widget **Scaffold**: fornisce un banner predefinito, un colore di sfondo e dispone di API per l'aggiunta di drawers, snack bars e bottom sheets.
Poi puoi aggiungere il *Center* widget direttamente alla proprietà body della homepage.

```c++
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
```

#### Nota: la libreria dei materiali implementa i widget che seguono i principi di progettazione dei materiali . Quando si progetta l'interfaccia utente, è possibile utilizzare esclusivamente i widget della libreria di widget standard oppure è possibile utilizzare i widget della libreria dei materiali. Puoi combinare i widget di entrambe le librerie, personalizzare i widget esistenti o creare il tuo set di widget personalizzati.


**Non-Material App**
Per un'app non-material, puoi aggiungere il Center widget al metodo build() dell'app:
```c++
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
        child: Text(
          'Hello World',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}   
```

Per default una Non-Material App non include un AppBar, titolo o colore di sfondo. Se vuoi avere queste features in un'app Non-Material, devi costruirtele da te. Quest'app cambia il colore di sfondo in bianco e il testo in grigio imitando una Material app.

Puoi vedere il codice [qui](https://github.com/martinaCas/FlutterTutorials/blob/main/t0_app/layouts_flutter/lib/main.dart) per Material App e [qui](https://github.com/martinaCas/FlutterTutorials/blob/main/t0_app/non_material_app/lib/main.dart) per Non Material App.



