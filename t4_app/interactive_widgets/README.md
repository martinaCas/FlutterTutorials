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

```c++
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

```c++
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

```c++
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

```c++
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
```c++
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

```c++
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

```c++
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
```c++
IconButton(iconSize: 72, icon: Icon(Icons.favorite), ...)

```
Avoid doing this:
```c++
IconButton(icon: Icon(Icons.favorite, size: 72), ...)

```
If you do, the button's size will be based on the default icon size, not 72, which may produce unexpected layouts and clipping issues.

##### Adding a filled backgroud
Icon buttons don't support specifying a background color or other background decoration because typically the icon is just displayed on top of the parent widget's background. Icon buttons that appear in AppBar.actions are an example of this.

It's easy enough to create an icon button with a filled background using the Ink widget. The Ink widget renders a decoration on the underlying Material along with the splash and highlight InkResponse contributed by descendant widgets.

##### In this sample the icon button's background color is defined with an Ink widget whose child is an IconButton. The icon button's filled background is a light shade of blue, it's a filled circle, and it's as big as the button is

```c++
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

6. **RadioButton**

A material design radio button.

Used to select between a number of mutually exclusive values. When one radio button in a group is selected, the other radio buttons in the group cease to be selected. The values are of type T, the type parameter of the Radio class. Enums are commonly used for this purpose.

The radio button itself does not maintain any state. Instead, selecting the radio invokes the onChanged callback, passing value as a parameter. If groupValue and value match, this radio will be selected. Most widgets will respond to onChanged by calling State.setState to update the radio button's groupValue.

### Here is an example of Radio widgets wrapped in ListTiles, which is similar to what you could get with the RadioListTile widget.The currently selected character is passed into groupValue, which is maintained by the example's State. In this case, the first Radio will start off selected because _character is initialized to SingingCharacter.lafayette. If the second radio button is pressed, the example's state is updated with setState, updating _character to SingingCharacter.jefferson. This causes the buttons to rebuild with the updated groupValue, and therefore the selection of the second button. Requires one of its ancestors to be a Material widget.

```c++
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

enum SingingCharacter { lafayette, jefferson }

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Lafayette'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Thomas Jefferson'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

```

For more, click [here](https://api.flutter.dev/flutter/material/Radio-class.html)

7. **ElevatedButton**

A Material Design "elevated button".

Use elevated buttons to add dimension to otherwise mostly flat layouts, e.g. in long busy lists of content, or in wide spaces. Avoid using elevated buttons on already-elevated content such as dialogs or cards.

An elevated button is a label child displayed on a Material widget whose Material.elevation increases when the button is pressed. The label's Text and Icon widgets are displayed in style's ButtonStyle.foregroundColor and the button's filled background is the ButtonStyle.backgroundColor.

The elevated button's default style is defined by defaultStyleOf. The style of this elevated button can be overridden with its style parameter. The style of all elevated buttons in a subtree can be overridden with the ElevatedButtonTheme, and the style of all of the elevated buttons in an app can be overridden with the Theme's ThemeData.elevatedButtonTheme property.

The static styleFrom method is a convenient way to create a elevated button ButtonStyle from simple values.

If onPressed and onLongPress callbacks are null, then the button will be disabled.

```c++
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
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: style,
            onPressed: null,
            child: const Text('Disabled'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {},
            child: const Text('Enabled'),
          ),
        ],
      ),
    );
  }
}

```

For more, click [here](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)

8. **Slider**

A Material Design slider.

Used to select from a range of values.

```c++
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
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      max: 100,
      divisions: 5,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }
}

```

A slider can be used to select from either a continuous or a discrete set of values. The default is to use a continuous range of values from min to max. To use discrete values, use a non-null value for divisions, which indicates the number of discrete intervals. For example, if min is 0.0 and max is 50.0 and divisions is 5, then the slider can take on the discrete values 0.0, 10.0, 20.0, 30.0, 40.0, and 50.0.

The terms for the parts of a slider are:

The "thumb", which is a shape that slides horizontally when the user drags it.
The "track", which is the line that the slider thumb slides along.
The "value indicator", which is a shape that pops up when the user is dragging the thumb to indicate the value being selected.
The "active" side of the slider is the side between the thumb and the minimum value.
The "inactive" side of the slider is the side between the thumb and the maximum value.
The slider will be disabled if onChanged is null or if the range given by min..max is empty (i.e. if min is equal to max).

The slider widget itself does not maintain any state. Instead, when the state of the slider changes, the widget calls the onChanged callback. Most widgets that use a slider will listen for the onChanged callback and rebuild the slider with a new value to update the visual appearance of the slider. To know when the value starts to change, or when it is done changing, set the optional callbacks onChangeStart and/or onChangeEnd.

By default, a slider will be as wide as possible, centered vertically. When given unbounded constraints, it will attempt to make the track 144 pixels wide (with margins on each side) and will shrink-wrap vertically.

Requires one of its ancestors to be a Material widget.

Requires one of its ancestors to be a MediaQuery widget. Typically, these are introduced by the MaterialApp or WidgetsApp widget at the top of your application widget tree.

To determine how it should be displayed (e.g. colors, thumb shape, etc.), a slider uses the SliderThemeData available from either a SliderTheme widget or the ThemeData.sliderTheme a Theme widget above it in the widget tree. You can also override some of the colors with the activeColor and inactiveColor properties, although more fine-grained control of the look is achieved using a SliderThemeData.

For more, click [here](https://api.flutter.dev/flutter/material/Slider-class.html)

9. **Switch**

A material design switch.

Used to toggle the on/off state of a single setting.

The switch itself does not maintain any state. Instead, when the state of the switch changes, the widget calls the onChanged callback. Most widgets that use a switch will listen for the onChanged callback and rebuild the switch with a new value to update the visual appearance of the switch.

If the onChanged callback is null, then the switch will be disabled (it will not respond to input). A disabled switch's thumb and track are rendered in shades of grey by default. The default appearance of a disabled switch can be overridden with inactiveThumbColor and inactiveTrackColor.

Requires one of its ancestors to be a Material widget.

For more, click [here](https://api.flutter.dev/flutter/material/Switch-class.html)

10. **TextField**

A material design text field.

A text field lets the user enter text, either with hardware keyboard or with an onscreen keyboard.

The text field calls the onChanged callback whenever the user changes the text in the field. If the user indicates that they are done typing in the field (e.g., by pressing a button on the soft keyboard), the text field calls the onSubmitted callback.

To control the text that is displayed in the text field, use the controller. For example, to set the initial value of the text field, use a controller that already contains some text. The controller can also control the selection and composing region (and to observe changes to the text, selection, and composing region).

By default, a text field has a decoration that draws a divider below the text field. You can use the decoration property to control the decoration, for example by adding a label or an icon. If you set the decoration property to null, the decoration will be removed entirely, including the extra padding introduced by the decoration to save space for the labels.

If decoration is non-null (which is the default), the text field requires one of its ancestors to be a Material widget.

To integrate the TextField into a Form with other FormField widgets, consider using TextFormField.

When the widget has focus, it will prevent itself from disposing via its underlying EditableText's AutomaticKeepAliveClientMixin.wantKeepAlive in order to avoid losing the selection. Removing the focus will allow it to be disposed.

Remember to call TextEditingController.dispose of the TextEditingController when it is no longer needed. This will ensure we discard any resources used by the object.

### This example shows how to create a TextField that will obscure input. The InputDecoration surrounds the field in a border using OutlineInputBorder and adds a label.

```c++
const TextField(
  obscureText: true,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Password',
  ),
)
```

## Reading values

A common way to read a value from a TextField is to use the onSubmitted callback. This callback is applied to the text field's current value when the user finishes editing.

```c++
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          controller: _controller,
          onSubmitted: (String value) async {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thanks!'),
                  content: Text(
                      'You typed "$value", which has length ${value.characters.length}.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

```

### Lifecycle

Upon completion of editing, like pressing the "done" button on the keyboard, two actions take place:

1st: Editing is finalized. The default behavior of this step includes an invocation of onChanged. That default behavior can be overridden. See onEditingComplete for details.

2nd: onSubmitted is invoked with the user's input value.

onSubmitted can be used to manually move focus to another input widget when a user finishes with the currently focused input widget.

When the widget has focus, it will prevent itself from disposing via AutomaticKeepAliveClientMixin.wantKeepAlive in order to avoid losing the selection. Removing the focus will allow it to be disposed.

For most applications the onSubmitted callback will be sufficient for reacting to user input.

The onEditingComplete callback also runs when the user finishes editing. It's different from onSubmitted because it has a default value which updates the text controller and yields the keyboard focus. Applications that require different behavior can override the default onEditingComplete callback.

Keep in mind you can also always read the current string from a TextField's TextEditingController using TextEditingController.text.

### Handling emojis and other complex characters

It's important to always use characters when dealing with user input text that may contain complex characters. This will ensure that extended grapheme clusters and surrogate pairs are treated as single characters, as they appear to the user.

For example, when finding the length of some user input, use string.characters.length. Do NOT use string.length or even string.runes.length. For the complex character "👨‍👩‍👦", this appears to the user as a single character, and string.characters.length intuitively returns 1. On the other hand, string.length returns 8, and string.runes.length returns 5!

In the live Dartpad example above, try typing the emoji 👨‍👩‍👦 into the field and submitting. Because the example code measures the length with value.characters.length, the emoji is correctly counted as a single character.

For more, click [here](https://api.flutter.dev/flutter/material/TextField-class.html)


