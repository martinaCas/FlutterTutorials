# tutorial2_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Tutorial 2
**Stateful and stateless widgets**

A widget is either stateful or stateless. If a widget can change—when a user interacts with it, for example—it’s stateful.

A stateless widget never changes. Icon, IconButton, and Text are examples of stateless widgets. Stateless widgets subclass StatelessWidget.

A stateful widget is dynamic: for example, it can change its appearance in response to events triggered by user interactions or when it receives data. Checkbox, Radio, Slider, InkWell, Form, and TextField are examples of stateful widgets. Stateful widgets subclass StatefulWidget.

A widget’s state is stored in a State object, separating the widget’s state from its appearance. The state consists of values that can change, like a slider’s current value or whether a checkbox is checked. When the widget’s state changes, the state object calls setState(), telling the framework to redraw the widget.

* A stateful widget is implemented by two classes: a subclass of StatefulWidget and a subclass of State.
* The state class contains the widget’s mutable state and the widget’s build() method.
* When the widget’s state changes, the state object calls setState(), telling the framework to redraw the widget.

In this section, you’ll create a custom stateful widget. You’ll replace two stateless widgets—the solid red star and the numeric count next to it—with a single custom stateful widget that manages a row with two children widgets: an IconButton and Text.

Implementing a custom stateful widget requires creating two classes:

* A subclass of StatefulWidget that defines the widget.
* A subclass of State that contains the state for that widget and defines the widget’s build() method.
This section shows you how to build a stateful widget, called FavoriteWidget, for the lakes app. After setting up, your first step is choosing how state is managed for FavoriteWidget.

**Step 0: Get Ready**
If you’ve already built the app in the building layouts tutorial (step 6), skip to the next section.

* Make sure you’ve set up your environment.
* Create a basic “Hello World” Flutter app.
* Replace the lib/main.dart file with main.dart.
* Replace the pubspec.yaml file with pubspec.yaml.
* Create an images directory in your project, and add lake.jpg.

Once you have a connected and enabled device, or you’ve launched the iOS simulator (part of the Flutter install) or the Android emulator (part of the Android Studio install), you are good to go!


 **Step 1: Decide which object manages the widget's state**

 A widget’s state can be managed in several ways, but in our example the widget itself, FavoriteWidget, will manage its own state. In this example, toggling the star is an isolated action that doesn’t affect the parent widget or the rest of the UI, so the widget can handle its state internally.

**Step 2: Subclass StatefulWidget**

The FavoriteWidget class manages its own state, so it overrides createState() to create a State object. The framework calls createState() when it wants to build the widget. In this example, createState() returns an instance of _FavoriteWidgetState, which you’ll implement in the next step.
```
class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}
```
#### Note: Members or classes that start with an underscore (_) are private.

**Step 3: Subclass State**

The _FavoriteWidgetState class stores the mutable data that can change over the lifetime of the widget. When the app first launches, the UI displays a solid red star, indicating that the lake has “favorite” status, along with 41 likes. These values are stored in the _isFavorited and _favoriteCount fields:
```
class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  // ···
}
```

The class also defines a build() method, which creates a row containing a red IconButton, and Text. You use IconButton (instead of Icon) because it has an onPressed property that defines the callback function (_toggleFavorite) for handling a tap. You’ll define the callback function next.

```
class _FavoriteWidgetState extends State<FavoriteWidget> {
  // ···
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: SizedBox(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
```

#### Tip: Placing the Text in a SizedBox and setting its width prevents a discernible “jump” when the text changes between the values of 40 and 41 — a jump would otherwise occur because those values have different widths.

The _toggleFavorite() method, which is called when the IconButton is pressed, calls setState(). Calling setState() is critical, because this tells the framework that the widget’s state has changed and that the widget should be redrawn. The function argument to setState() toggles the UI between these two states:

* A star icon and the number 41
* A star_border icon and the number 40

```
void _toggleFavorite() {
  setState(() {
    if (_isFavorited) {
      _favoriteCount -= 1;
      _isFavorited = false;
    } else {
      _favoriteCount += 1;
      _isFavorited = true;
    }
  });
}
```

**Step 4: Plug the stateful widget into the widget tree**

Add your custom stateful widget to the widget tree in the app’s build() method. First, locate the code that creates the Icon and Text, and delete it. In the same location, create the stateful widget:

```
- Icon(
    Icons.star,
    color: Colors.red[500],
    ),
    const Text('41'),
+   const FavoriteWidget(),
```

That’s it! When you hot reload the app, the star icon should now respond to taps.

