# interactive_widgets

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Standard widgets
1. **Form**

An optional container for grouping together multiple form field widgets (e.g. TextField widgets).

Each individual form field should be wrapped in a FormField widget, with the Form widget as a common ancestor of all of those. Call methods on FormState to save, reset, or validate each FormField that is a descendant of this Form. To obtain the FormState, you may use Form.of with a context whose ancestor is the Form, or pass a GlobalKey to the Form constructor and call GlobalKey.currentState.

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

```

For more click [here](https://api.flutter.dev/flutter/widgets/Form-class.html)

2. **FormField**

A single form field.

This widget maintains the current state of the form field, so that updates and validation errors are visually reflected in the UI.

When used inside a Form, you can use methods on FormState to query or manipulate the form data as a whole. For example, calling FormState.save will invoke each FormField's onSaved callback in turn.

Use a GlobalKey with FormField if you want to retrieve its current state, for example if you want one form field to depend on another.

A Form ancestor is not required. The Form simply makes it easier to save, reset, or validate multiple fields at once. To use without a Form, pass a GlobalKey to the constructor and use GlobalKey.currentState to save or reset the form field.

For more click [here](https://api.flutter.dev/flutter/widgets/FormField-class.html)


# Material Components

1. **Checkbox**

A material design checkbox.

The checkbox itself does not maintain any state. Instead, when the state of the checkbox changes, the widget calls the onChanged callback. Most widgets that use a checkbox will listen for the onChanged callback and rebuild the checkbox with a new value to update the visual appearance of the checkbox.

The checkbox can optionally display three values - true, false, and null - if tristate is true. When value is null a dash is displayed. By default tristate is false and the checkbox's value must be true or false.

Requires one of its ancestors to be a Material widget.

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

```
For more click [here](https://api.flutter.dev/flutter/material/Checkbox-class.html)

2. **DropdownButton**

A material design button for selecting from a list of items.

A dropdown button lets the user select from a number of items. The button shows the currently selected item as well as an arrow that opens a menu for selecting another item.

One ancestor must be a Material widget and typically this is provided by the app's Scaffold.

The type T is the type of the value that each dropdown item represents. All the entries in a given menu must represent values with consistent types. Typically, an enum is used. Each DropdownMenuItem in items must be specialized with that same type argument.

The onChanged callback should update a state variable that defines the dropdown's value. It should also call State.setState to rebuild the dropdown with the new value.

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

```
For more click [here](https://api.flutter.dev/flutter/material/DropdownButton-class.html)

3. **TextButton**

A Material Design "Text Button".

Use text buttons on toolbars, in dialogs, or inline with other content but offset from that content with padding so that the button's presence is obvious. Text buttons do not have visible borders and must therefore rely on their position relative to other content for context. In dialogs and cards, they should be grouped together in one of the bottom corners. Avoid using text buttons where they would blend in with other content, for example in the middle of lists.

A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.foregroundColor. The button reacts to touches by filling with the style's ButtonStyle.backgroundColor.

The text button's default style is defined by defaultStyleOf. The style of this text button can be overridden with its style parameter. The style of all text buttons in a subtree can be overridden with the TextButtonTheme and the style of all of the text buttons in an app can be overridden with the Theme's ThemeData.textButtonTheme property.

The static styleFrom method is a convenient way to create a text button ButtonStyle from simple values.

If the onPressed and onLongPress callbacks are null, then this button will be disabled, it will not react to touch.

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: null,
            child: const Text('Disabled'),
          ),
          const SizedBox(height: 30),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Enabled'),
          ),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  child: const Text('Gradient'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

For more click [here](https://api.flutter.dev/flutter/material/TextButton-class.html)

4. **FloatingActionButton**

A material design floating action button.

A floating action button is a circular icon button that hovers over content to promote a primary action in the application. Floating action buttons are most commonly used in the Scaffold.floatingActionButton field.

Use at most a single floating action button per screen. Floating action buttons should be used for positive actions such as "create", "share", or "navigate". (If more than one floating action button is used within a Route, then make sure that each button has a unique heroTag, otherwise an exception will be thrown.)

If the onPressed callback is null, then the button will be disabled and will not react to touch. It is highly discouraged to disable a floating action button as there is no indication to the user that the button is disabled. Consider changing the backgroundColor if disabling the floating action button.


#### This example shows how to display a FloatingActionButton in a Scaffold, with a pink backgroundColor and a thumbs up Icon.
```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Action Button'),
      ),
      body: const Center(child: Text('Press the button below!')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}

```

#### This example shows how to make an extended FloatingActionButton in a Scaffold, with a pink backgroundColor, a thumbs up Icon and a Text label that reads "Approve".

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Action Button Label'),
      ),
      body: const Center(
        child: Text('Press the button with a label below!'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Approve'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

```

For more click [here](https://api.flutter.dev/flutter/material/FloatingActionButton-class.html)

5. **IconButton**

A material design icon button.

An icon button is a picture printed on a Material widget that reacts to touches by filling with color (ink).

Icon buttons are commonly used in the AppBar.actions field, but they can be used in many other places as well.

If the onPressed callback is null, then the button will be disabled and will not react to touch.

Requires one of its ancestors to be a Material widget.

The hit region of an icon button will, if possible, be at least kMinInteractiveDimension pixels in size, regardless of the actual iconSize, to satisfy the touch target size requirements in the Material Design specification. The alignment controls how the icon itself is positioned within the hit region.

#### This sample shows an IconButton that uses the Material icon "volume_up" to increase the volume.

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

double _volume = 0.0;

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.volume_up),
          tooltip: 'Increase volume by 10',
          onPressed: () {
            setState(() {
              _volume += 10;
            });
          },
        ),
        Text('Volume : $_volume')
      ],
    );
  }
}

```

##### Icon sizes
When creating an icon button with an Icon, do not override the icon's size with its Icon.size parameter, use the icon button's iconSize parameter instead. For example do this:
```
IconButton(iconSize: 72, icon: Icon(Icons.favorite), ...)

```
Avoid doing this:
```
IconButton(icon: Icon(Icons.favorite, size: 72), ...)

```
If you do, the button's size will be based on the default icon size, not 72, which may produce unexpected layouts and clipping issues.

##### Adding a filled backgroud
Icon buttons don't support specifying a background color or other background decoration because typically the icon is just displayed on top of the parent widget's background. Icon buttons that appear in AppBar.actions are an example of this.

It's easy enough to create an icon button with a filled background using the Ink widget. The Ink widget renders a decoration on the underlying Material along with the splash and highlight InkResponse contributed by descendant widgets.

##### In this sample the icon button's background color is defined with an Ink widget whose child is an IconButton. The icon button's filled background is a light shade of blue, it's a filled circle, and it's as big as the button is

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.android),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

```
For more click [here](https://api.flutter.dev/flutter/material/IconButton-class.html)

Riprendere da Radio Button