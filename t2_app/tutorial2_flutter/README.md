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


