# startup_namer

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

## STEP 1:
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Observations
- This example creates a Material app. Material is a visual design language that is standard on mobile and the web. Flutter offers a rich set of Material widgets. It’s a good idea to have a uses-material-design: true entry in the flutter section of your pubspec.yaml file. This will allow you to use more features of Material, such as their set of predefined Icons.

- The app extends StatelessWidget, which makes the app itself a widget. In Flutter, almost everything is a widget, including alignment, padding, and layout.

- The Scaffold widget, from the Material library, provides a default app bar, and a body property that holds the widget tree for the home screen. The widget subtree can be quite complex.

- A widget’s main job is to provide a build() method that describes how to display the widget in terms of other, lower level widgets.

- The body for this example consists of a Center widget containing a Text child widget. The Center widget aligns its widget subtree to the center of the screen.

## STEP 2: Use an external package
In this step, you’ll start using an open-source package named english_words, which contains a few thousand of the most used English words plus some utility functions.

You can find the english_words package, as well as many other open source packages, on pub.dev.

Add english_words package to project as follows:
**flutter pub add english_words** 

The pubspec.yaml file manages the assets and dependencies for a Flutter app. In pubspec.yaml, you will see that the english_words dependency has been added.

While viewing the pubspec.yaml file in Android Studio’s editor view, click Pub get. This pulls the package into your project. You should see the following in the console:
**flutter pub get**

Performing Pub get also auto-generates the pubspec.lock file with a list of all packages pulled into the project and their version numbers.

Then in lib/main.dart, import the new package:
```
import 'package:english_words/english_words.dart';
```
Use the English words package to generate the text instead of using the string “Hello World”:
```
 final wordPair = WordPair.random();
 body: Center(
      child: Text(wordPair.asPascalCase),
```
# Note: “Pascal case” (also known as “upper camel case”), means that each word in the string, including the first one, begins with an uppercase letter. So, “uppercamelcase” becomes “UpperCamelCase”.

## STEP 3: Add a Stateful widget
Stateless widgets are immutable, meaning that their properties can’t change—all values are final.

Stateful widgets maintain state that might change during the lifetime of the widget. Implementing a stateful widget requires at least two classes: 1) a *StatefulWidget* class that creates an instance of 2) a *State* class. The *StatefulWidget* class is, itself, immutable and can be thrown away and regenerated, but the *State* class persists over the lifetime of the widget.

In this step, you’ll add a stateful widget, *RandomWords*, which creates its *State* class, *_RandomWordsState*. You’ll then use *RandomWords* as a child inside the existing *MyApp* stateless widget.

1. Create the boilerplate code for a stateful widget.
In *lib/main.dart*, position your cursor after all of the code, enter **Return** a couple times to start on a fresh line. In your IDE, start typing *stful*. The editor asks if you want to create a *Stateful* widget. Press **Return** to accept. The boilerplate code for two classes appears, and the cursor is positioned for you to enter the name of your stateful widget.

2. Enter *RandomWords* as the name of your widget.
The *RandomWords* widget does little else beside creating its *State* class.

Once you’ve entered *RandomWords* as the name of the stateful widget, the IDE automatically updates the accompanying *State* class, naming it *_RandomWordsState*. By default, the name of the State class is prefixed with an underbar. Prefixing an identifier with an underscore **enforces privacy** in the Dart language and is a recommended best practice for State objects.

The IDE also automatically updates the state class to extend *State<RandomWords>*, indicating that you’re using a generic *State* class specialized for use with *RandomWords*. Most of the app’s logic resides here—it maintains the state for the *RandomWords* widget. This class saves the list of generated word pairs, which grows infinitely as the user scrolls and, in part 2 of this lab, favorites word pairs as the user adds or removes them from the list by toggling the heart icon.

Then update the *build()* method in *_RandomWordsState*:
```
class _RandomWordsState extends State<RandomWords> {
    @override
    Widget build(BuildContext context) {
     final wordPair = WordPair.random();
      return Text(wordPair.asPascalCase);
    }
  }
```
  Remove the word generation code from MyApp by making the changes shown in the following diff:
```
        @override
	    Widget build(BuildContext context) {
	     final wordPair = WordPair.random();//remove

	         body: Center(//remove
	           child: Text(wordPair.asPascalCase),//remove
	         body: const Center(//add
    	           child: RandomWords(),//add

```
## STEP4: Create an infinite scrolling ListView
In this step, you’ll expand *_RandomWordsState* to generate and display a list of word pairings. As the user scrolls the list (displayed in a *ListView* widget) grows infinitely. *ListView*’s builder factory constructor allows you to build a list view lazily, on demand.

1. Add a *_suggestions* list to the *_RandomWordsState* class for saving suggested word pairings. Also, add a *_biggerFont* variable for making the font size larger.
```
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  // ···
}
```
Next, you’ll add a *ListView* widget to the *_RandomWordsState* class with the *ListView.builder* constructor. This method creates the *ListView* that displays the suggested word pairing.

The *ListView* class provides a builder property, *itemBuilder*, that’s a factory builder and callback function specified as an anonymous function. Two parameters are passed to the function—the *BuildContext*, and the row iterator, i. The iterator begins at 0 and increments each time the function is called. It increments twice for every suggested word pairing: once for the ListTile, and once for the Divider. This model allows the suggested list to continue growing as the user scrolls.

2. Return a *ListView* widget from the build method of the *_RandomWordsState* class using the *ListView.builder* constructor:
```
return ListView.builder(
  padding: const EdgeInsets.all(16.0),
  itemBuilder: /*1*/ (context, i) {
    if (i.isOdd) return const Divider(); /*2*/

    final index = i ~/ 2; /*3*/
    if (index >= _suggestions.length) {
      _suggestions.addAll(generateWordPairs().take(10)); /*4*/
    }
    return Text(_suggestions[index].asPascalCase);
  },
```
 /*1*/ The itemBuilder callback is called once per suggested word pairing, and places each suggestion into a ListTile row. For even rows, the function adds a ListTile row for the word pairing. For odd rows, the function adds a Divider widget to visually separate the entries. Note that the divider might be difficult to see on smaller devices.
 /*2*/ Add a one-pixel-high divider widget before each row in the ListView.
 /*3*/ The expression i ~/ 2 divides i by 2 and returns an integer result. For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2. This calculates the actual number of word pairings in the ListView, minus the divider widgets.
 /*4*/ If you’ve reached the end of the available word pairings, then generate 10 more and add them to the suggestions list.
The ListView.builder constructor creates and displays a Text widget once per word pairing. In the next step, you’ll instead return each new pair as a ListTile, which allows you to make the rows more attractive in the next step.

3. Replace the returned Text in the itemBuilder body of the ListView.builder in _RandomWordsState with a ListTile displaying the suggestion:
```
return ListTile(
  title: Text(
    _suggestions[index].asPascalCase,
    style: _biggerFont,
  ),
);
```
A ListTile is a fixed height row that contains text as well as leading or trailing icons or other widgets.

4. Once complete, the build() method in the _RandomWordsState class should match the following highlighted code:
```
@override
Widget build(BuildContext context) {
  return ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemBuilder: /*1*/ (context, i) {
      if (i.isOdd) return const Divider(); /*2*/

      final index = i ~/ 2; /*3*/
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10)); /*4*/
      }
      return ListTile(
        title: Text(
          _suggestions[index].asPascalCase,
          style: _biggerFont,
        ),
      );
    },
  );
}
```

5. To put it all together, update the displayed title of the app by updating the build() method in the MyApp class and changing the title of the AppBar:
```
	    @override
	    Widget build(BuildContext context) {
	      return MaterialApp(
	      title: 'Welcome to Flutter',//removed
	     title: 'Startup Name Generator',//added
	        home: Scaffold(
	          appBar: AppBar(
	           title: const Text('Welcome to Flutter'),//removed
	           title: const Text('Startup Name         Generator'),//added
            //code non variato

	    class _RandomWordsState extends State<RandomWords> {
	        final _suggestions = <WordPair>[];//added
	        final _biggerFont = const TextStyle(fontSize: 18);//added
	 
	    @override
	    Widget build(BuildContext context) {
	     final wordPair = WordPair.random();//removed
	     return Text(wordPair.asPascalCase);//removed
	     return ListView.builder(//the follow lines are all added
	       padding: const EdgeInsets.all(16.0),
	       itemBuilder: /*1*/ (context, i) {
	         if (i.isOdd) return const Divider(); /*2*/
	 
	         final index = i ~/ 2; /*3*/
	         if (index >= _suggestions.length) {
	           _suggestions.addAll(generateWordPairs().take(10)); /*4*/
	         }
	         return ListTile(
	           title: Text(
	             _suggestions[index].asPascalCase,
	             style: _biggerFont,
	           ),	+         );
	       },
	     );
	    }
                //code non variato
```
