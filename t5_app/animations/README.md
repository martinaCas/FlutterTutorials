# animations

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

This tutorial shows you how to build explicit animations in Flutter. After introducing some of the essential concepts, classes, and methods in the animation library, it walks you through 5 animation examples. The examples build on each other, introducing you to different aspects of the animation library.

The Flutter SDK also provides built-in explicit animations, such as FadeTransition, SizeTransition, and SlideTransition. These simple animations are triggered by setting a beginning and ending point. They are simpler to implement than custom explicit animations, which are described here.


## Essential animation concepts and classes

* Animation, a core class in Flutter’s animation library, interpolates the values used to guide an animation.
* An Animation object knows the current state of an animation (for example, whether it’s started, stopped, or moving forward or in reverse), but doesn’t know anything about what appears onscreen.
* An AnimationController manages the Animation.
* A CurvedAnimation defines progression as a non-linear curve.
* A Tween interpolates between the range of data as used by the object being animated. For example, a Tween might define an interpolation from red to blue, or from 0 to 255.
* Use Listeners and StatusListeners to monitor animation state changes.

The animation system in Flutter is based on typed Animation objects. Widgets can either incorporate these animations in their build functions directly by reading their current value and listening to their state changes or they can use the animations as the basis of more elaborate animations that they pass along to other widgets.


## Animation <double>

In Flutter, an Animation object knows nothing about what is onscreen. An Animation is an abstract class that understands its current value and its state (completed or dismissed). One of the more commonly used animation types is Animation<double>.

An Animation object sequentially generates interpolated numbers between two values over a certain duration. The output of an Animation object might be linear, a curve, a step function, or any other mapping you can devise. Depending on how the Animation object is controlled, it could run in reverse, or even switch directions in the middle.

Animations can also interpolate types other than double, such as Animation<Color> or Animation<Size>.

An Animation object has state. Its current value is always available in the .value member.

An Animation object knows nothing about rendering or build() functions.

## Curved Animation

A CurvedAnimation defines the animation’s progress as a non-linear curve.

```c++
animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
```

#### Note: The Curves class defines many commonly used curves, or you can create your own. For example:
```c++
import 'dart:math';

class ShakeCurve extends Curve {
  @override
  double transform(double t) => sin(t * pi * 2);
}
```
Browse the Curves documentation for a complete listing (with visual previews) of the Curves constants that ship with Flutter.

CurvedAnimation and AnimationController (described in the next section) are both of type Animation<double>, so you can pass them interchangeably. The CurvedAnimation wraps the object it’s modifying—you don’t subclass AnimationController to implement a curve.


## Animation Controller

AnimationController is a special Animation object that generates a new value whenever the hardware is ready for a new frame. By default, an AnimationController linearly produces the numbers from 0.0 to 1.0 during a given duration. For example, this code creates an Animation object, but does not start it running:
```c++
controller =
    AnimationController(duration: const Duration(seconds: 2), vsync: this);
```

AnimationController derives from Animation<double>, so it can be used wherever an Animation object is needed. However, the AnimationController has additional methods to control the animation. For example, you start an animation with the .forward() method. The generation of numbers is tied to the screen refresh, so typically 60 numbers are generated per second. After each number is generated, each Animation object calls the attached Listener objects. To create a custom display list for each child, see RepaintBoundary.

When creating an AnimationController, you pass it a vsync argument. The presence of vsync prevents offscreen animations from consuming unnecessary resources. You can use your stateful object as the vsync by adding SingleTickerProviderStateMixin to the class definition. You can see an example of this in animate1 on GitHub.

### Note: In some cases, a position might exceed the AnimationController’s 0.0-1.0 range. For example, the fling() function allows you to provide velocity, force, and position (via the Force object). The position can be anything and so can be outside of the 0.0 to 1.0 range. 

### A CurvedAnimation can also exceed the 0.0 to 1.0 range, even if the AnimationController doesn’t. Depending on the curve selected, the output of the CurvedAnimation can have a wider range than the input. For example, elastic curves such as Curves.elasticIn significantly overshoots or undershoots the default range.


## Tween

By default, the AnimationController object ranges from 0.0 to 1.0. If you need a different range or a different data type, you can use a Tween to configure an animation to interpolate to a different range or data type. For example, the following Tween goes from -200.0 to 0.0:
```c++
tween = Tween<double>(begin: -200, end: 0);
```

A Tween is a stateless object that takes only begin and end. The sole job of a Tween is to define a mapping from an input range to an output range. The input range is commonly 0.0 to 1.0, but that’s not a requirement.

A Tween inherits from Animatable<T>, not from Animation<T>. An Animatable, like Animation, doesn’t have to output double. For example, ColorTween specifies a progression between two colors.
```c++
colorTween = ColorTween(begin: Colors.transparent, end: Colors.black54);
```

A Tween object does not store any state. Instead, it provides the evaluate(Animation<double> animation) method that applies the mapping function to the current value of the animation. The current value of the Animation object can be found in the .value method. The evaluate function also performs some housekeeping, such as ensuring that begin and end are returned when the animation values are 0.0 and 1.0, respectively.

## Tween.animate

To use a Tween object, call animate() on the Tween, passing in the controller object. For example, the following code generates the integer values from 0 to 255 over the course of 500 ms.

```c++
AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500), vsync: this);
Animation<int> alpha = IntTween(begin: 0, end: 255).animate(controller);
```
### Note: The animate() method returns an Animation, not an Animatable.

The following example shows a controller, a curve, and a Tween:

```c++
AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500), vsync: this);
final Animation<double> curve =
    CurvedAnimation(parent: controller, curve: Curves.easeOut);
Animation<int> alpha = IntTween(begin: 0, end: 255).animate(curve);
```

# Animation notifications

An Animation object can have Listeners and StatusListeners, defined with addListener() and addStatusListener(). A Listener is called whenever the value of the animation changes. The most common behavior of a Listener is to call setState() to cause a rebuild. A StatusListener is called when an animation begins, ends, moves forward, or moves reverse, as defined by AnimationStatus. The next section has an example of the addListener() method, and Monitoring the progress of the animation shows an example of addStatusListener().


# Animation examples

* How to add basic animation to a widget using addListener() and setState().
* Every time the Animation generates a new number, the addListener() function calls setState().
* How to define an AnimationController with the required vsync parameter.
* Understanding the “..” syntax in “..addListener”, also known as Dart’s cascade notation.
* To make a class private, start its name with an underscore (_).

So far you’ve learned how to generate a sequence of numbers over time. Nothing has been rendered to the screen. To render with an Animation object, store the Animation object as a member of your widget, then use its value to decide how to draw.

Consider the following app that draws the Flutter logo without animation:

```c++
import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

class LogoApp extends StatefulWidget {
  const LogoApp({Key? key}) : super(key: key);

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 300,
        width: 300,
        child: const FlutterLogo(),
      ),
    );
  }
}
```

The following shows the same code modified to animate the logo to grow from nothing to full size. When defining an AnimationController, you must pass in a vsync object. The vsync parameter is described in the AnimationController section.

The changes from the non-animated example are highlighted: (main.dart updated)

```c++
import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

class LogoApp extends StatefulWidget {
  const LogoApp({Key? key}) : super(key: key);

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // #docregion addListener
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        // #enddocregion addListener
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
        // #docregion addListener
      });
    // #enddocregion addListener
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
 
```
The addListener() function calls setState(), so every time the Animation generates a new number, the current frame is marked dirty, which forces build() to be called again. In build(), the container changes size because its height and width now use animation.value instead of a hardcoded value. Dispose of the controller when the State object is discarded to prevent memory leaks.

With these few changes, you’ve created your first animation in Flutter!

## **Dart language tricks**:
 You might not be familiar with Dart’s cascade notation—the two dots in ..addListener(). This syntax means that the addListener() method is called with the return value from animate(). Consider the following example:
 ```c++
animation = Tween<double>(begin: 0, end: 300).animate(controller)
  ..addListener(() {
    // ···
  });
 ```

 This code is equivalent to:
 ```c++
animation = Tween<double>(begin: 0, end: 300).animate(controller);
animation.addListener(() {
    // ···
  });
 ```

## Simplifying with AnimatedWidget

* How to use the AnimatedWidget helper class (instead of addListener() and setState()) to create a widget that animates.
* Use AnimatedWidget to create a widget that performs a reusable animation. To separate the transition from the widget, use an AnimatedBuilder, as shown in the Refactoring with AnimatedBuilder section.
* Examples of AnimatedWidgets in the Flutter API: AnimatedBuilder, AnimatedModalBarrier, DecoratedBoxTransition, FadeTransition, PositionedTransition, RelativePositionedTransition, RotationTransition, ScaleTransition, SizeTransition, SlideTransition.

The AnimatedWidget base class allows you to separate out the core widget code from the animation code. AnimatedWidget doesn’t need to maintain a State object to hold the animation. Add the following AnimatedLogo class:

```c++
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}
```
AnimatedLogo uses the current value of the animation when drawing itself.

The LogoApp still manages the AnimationController and the Tween, and it passes the Animation object to AnimatedLogo: (main.dart updated)

```c++
import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({Key? key}) : super(key: key);

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // #docregion addListener
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    // #enddocregion addListener
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

```

## Monitoring the profress of the animation

* Use addStatusListener() for notifications of changes to the animation’s state, such as starting, stopping, or reversing direction.
* Run an animation in an infinite loop by reversing direction when the animation has either completed or returned to its starting state.

It’s often helpful to know when an animation changes state, such as finishing, moving forward, or reversing. You can get notifications for this with addStatusListener(). The following code modifies the previous example so that it listens for a state change and prints an update. The highlighted line shows the change:

```c++
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) => print ('$status')); //THIS IS THE HIGHLIGHTED
    controller.forward();
  }
  // ...
}
```

Running this code produces this output in console:
```
flutter: AnimationStatus.forward
flutter: AnimationStatus.completed
```

Next, use addStatusListener() to reverse the animation at the beginning or the end. This creates a “breathing” effect:

```c++
    AnimationController(duration: const Duration(seconds: 2), vsync: this);
     animation = Tween<double>(begin: 0, end: 300).animate(controller);//remove
     animation = Tween<double>(begin: 0, end: 300).animate(controller)//add to end
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
           controller.reverse();
         } else if (status == AnimationStatus.dismissed) {
	           controller.forward();
	         }
	       })
	       ..addStatusListener((status) => print('$status'));
	      controller.forward();
```

## Refactoring with AnimateBuilder
* An AnimatedBuilder understands how to render the transition.
* An AnimatedBuilder doesn’t know how to render the widget, nor does it manage the Animation object.
* Use AnimatedBuilder to describe an animation as part of a build method for another widget. If you simply want to define a widget with a reusable animation, use an AnimatedWidget, as shown in the Simplifying with AnimatedWidget section.
* Examples of AnimatedBuilders in the Flutter API: BottomSheet, ExpansionTile, PopupMenu, ProgressIndicator, RefreshIndicator, Scaffold, SnackBar, TabBar, TextField.

One problem with the code in the [animate3](https://github.com/flutter/website/tree/main/examples/animation/animate3) example, is that changing the animation required changing the widget that renders the logo. A better solution is to separate responsibilities into different classes:

* Render the logo
* Define the Animation object
* Render the transition
You can accomplish this separation with the help of the AnimatedBuilder class. An AnimatedBuilder is a separate class in the render tree. Like AnimatedWidget, AnimatedBuilder automatically listens to notifications from the Animation object, and marks the widget tree dirty as necessary, so you don’t need to call addListener().

The widget tree for the [animate4](https://github.com/flutter/website/tree/main/examples/animation/animate4) example looks like this:

![Image](https://docs.flutter.dev/assets/images/docs/ui/AnimatedBuilder-WidgetTree.png)

Starting from the bottom of the widget tree, the code for rendering the logo is straightforward:

```c++
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  // Leave out the height and width so it fills the animating parent
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}
```

The middle three blocks in the diagram are all created in the build() method in GrowTransition, shown below. The GrowTransition widget itself is stateless and holds the set of final variables necessary to define the transition animation. The build() function creates and returns the AnimatedBuilder, which takes the (Anonymous builder) method and the LogoWidget object as parameters. The work of rendering the transition actually happens in the (Anonymous builder) method, which creates a Container of the appropriate size to force the LogoWidget to shrink to fit.

One tricky point in the code below is that the child looks like it’s specified twice. What’s happening is that the outer reference of child is passed to AnimatedBuilder, which passes it to the anonymous closure, which then uses that object as its child. The net result is that the AnimatedBuilder is inserted in between the two widgets in the render tree.

```c++
class GrowTransition extends StatelessWidget {
  const GrowTransition({required this.child, required this.animation, super.key});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
```

Finally, the code to initialize the animation looks very similar to the animate2 example. The initState() method creates an AnimationController and a Tween, then binds them with animate(). The magic happens in the build() method, which returns a GrowTransition object with a LogoWidget as a child, and an animation object to drive the transition. These are the three elements listed in the bullet points above.

```c++
//FINAL MAIN.DART
import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

// #docregion LogoWidget
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  // Leave out the height and width so it fills the animating parent
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}
// #enddocregion LogoWidget

// #docregion GrowTransition
class GrowTransition extends StatelessWidget {
  const GrowTransition({required this.child, required this.animation, super.key});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
// #enddocregion GrowTransition

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  _LogoAppState createState() => _LogoAppState();
}

// #docregion print-state
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }
  // #enddocregion print-state

  @override
  Widget build(BuildContext context) {
    return GrowTransition(
      child: const LogoWidget(),
      animation: animation,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  // #docregion print-state
}
```

## Simultaneous animations

* The Curves class defines an array of commonly used curves that you can use with a CurvedAnimation.

In this section, you’ll build on the example from monitoring the progress of the animation (animate3), which used AnimatedWidget to animate in and out continuously. Consider the case where you want to animate in and out while the opacity animates from transparent to opaque.

#### This example shows how to use multiple tweens on the same animation controller, where each tween manages a different effect in the animation. It is for illustrative purposes only. If you were tweening opacity and size in production code, you’d probably use FadeTransition and SizeTransition instead.

Each tween manages an aspect of the animation. For example:

```c++
controller =
    AnimationController(duration: const Duration(seconds: 2), vsync: this);
sizeAnimation = Tween<double>(begin: 0, end: 300).animate(controller);
opacityAnimation = Tween<double>(begin: 0.1, end: 1).animate(controller);

```

You can get the size with sizeAnimation.value and the opacity with opacityAnimation.value, but the constructor for AnimatedWidget only takes a single Animation object. To solve this problem, the example creates its own Tween objects and explicitly calculates the values.

Change AnimatedLogo to encapsulate its own Tween objects, and its build() method calls Tween.evaluate() on the parent’s animation object to calculate the required size and opacity values. The following code shows the changes with highlights:

```c++
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  // Make the Tweens static because they don't change.
  /**/static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  /**/static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
     /**/ child: Opacity(
      /**/  opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
         /**/ height: _sizeTween.evaluate(animation),
         /**/ width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
   /**/ animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```
Final code:
```c++
// #docregion ShakeCurve
import 'dart:math';

// #enddocregion ShakeCurve
import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

// #docregion diff
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    // #docregion AnimationController, tweens
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // #enddocregion AnimationController, tweens
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
// #enddocregion diff

// Extra code used only in the tutorial explanations. It is not used by the app.

class UsedInTutorialTextOnly extends _LogoAppState {
  UsedInTutorialTextOnly() {
    // ignore: unused_local_variable, prefer_typing_uninitialized_variables
    var animation, sizeAnimation, opacityAnimation, tween, colorTween;

    // #docregion CurvedAnimation
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    // #enddocregion CurvedAnimation

    // #docregion tweens
    sizeAnimation = Tween<double>(begin: 0, end: 300).animate(controller);
    opacityAnimation = Tween<double>(begin: 0.1, end: 1).animate(controller);
    // #enddocregion tweens

    // #docregion tween
    tween = Tween<double>(begin: -200, end: 0);
    // #enddocregion tween

    // #docregion colorTween
    colorTween = ColorTween(begin: Colors.transparent, end: Colors.black54);
    // #enddocregion colorTween
  }

  usedInTutorialOnly1() {
    // #docregion IntTween
    AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    Animation<int> alpha = IntTween(begin: 0, end: 255).animate(controller);
    // #enddocregion IntTween
    return alpha;
  }

  usedInTutorialOnly2() {
    // #docregion IntTween-curve
    AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation<double> curve =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);
    Animation<int> alpha = IntTween(begin: 0, end: 255).animate(curve);
    // #enddocregion IntTween-curve
    return alpha;
  }
}

// #docregion ShakeCurve
class ShakeCurve extends Curve {
  @override
  double transform(double t) => sin(t * pi * 2);
}


```