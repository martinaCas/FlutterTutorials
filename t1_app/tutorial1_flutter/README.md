# tutorial1_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Tutorial 1
**Step 0: Create the app base code**

Create a basic Flutter app. Change the app bar title and the app title as follow:

```c++
title: 'Flutter layout demo',
//other code
appBar: AppBar(
    title: const Text('Flutter layout demo'),
),
//other code
```

**Step 1: Diagram the layout**

The first step is to break the layout down to its basic elements:

* Identify the rows and columns.
* Does the layout include a grid?
* Are there overlapping elements?
* Does the UI need tabs?
* Notice areas that require alignment, padding, or borders.

First, identify the larger elements. In this example, four elements are arranged into a column: an image, two rows, and a block of text.

**Step 2: Implement the title row**

First, you'll build the left column in the title section. Add the following code at the top of the build() method of the MyApp class:
```c++
Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      const Text('41'),
    ],
  ),
);
```

/*1*/ Putting a Column inside an Expanded widget stretches the column to use all remaining free space in the row. Setting the crossAxisAlignment property to CrossAxisAlignment.start positions the column at the start of the row.
/*2*/ Putting the first row of text inside a Container enables you to add padding. The second child in the Column, also text, displays as grey.
/*3*/ The last two items in the title row are a star icon, painted red, and the text “41”. The entire row is in a Container and padded along each edge by 32 pixels. Add the title section to the app body like this:

```c++
//code
body: Column(
    children[
        titleSection,
    ],
),
//other code
```

**Step 3: Implement the button row**
The button section contains 3 columns that use the same layout—an icon over a row of text. The columns in this row are evenly spaced, and the text and icons are painted with the primary color.

Since the code for building each column is almost identical, create a private helper method named buildButtonColumn(), which takes a color, an Icon and Text, and returns a column with its widgets painted in the given color.

```c++
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ···
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
```

The function adds the icon directly to the column. The text is inside a Container with a top-only margin, separating the text from the icon.

Build the row containing these columns by calling the function and passing the color, Icon, and text specific to that column. Align the columns along the main axis using MainAxisAlignment.spaceEvenly to arrange the free space evenly before, between, and after each column. Add the following code just below the titleSection declaration inside the build() method:

```c++
Color color = Theme.of(context).primaryColor;

Widget buttonSection = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _buildButtonColumn(color, Icons.call, 'CALL'),
    _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
    _buildButtonColumn(color, Icons.share, 'SHARE'),
  ],
);
```

Add the button section to the body:

```c++
body: Column(
    children: [
        titleSection,
        buttonSection,
    ],
),
```

**Step 4: Implement the text section**

Define the text section as a variable. Put the text in a Container and add padding along each edge. Add the following code just below the buttonSection declaration:
```c++
Widget textSection = const Padding(
  padding: EdgeInsets.all(32),
  child: Text(
    'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
    'Alps. Situated 1,578 meters above sea level, it is one of the '
    'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
    'half-hour walk through pastures and pine forest, leads you to the '
    'lake, which warms to 20 degrees Celsius in the summer. Activities '
    'enjoyed here include rowing, and riding the summer toboggan run.',
    softWrap: true,
  ),
);
```

By setting softwrap to true, text lines will fill the column width before wrapping at a word boundary.

Add the text section of the body:
```c++
body: Column(
    children: [
        titleSection,
        buttonSection,
        textSection,
    ],
),
```

**Step 5: Implement the image section**

Three of the four column elements are now complete, leaving only the image. Add the image file to the example:

* Create an images directory at the top of the project.
* Add lake.jpg.
* Update the pubspec.yaml file to include an assets tag. This makes the image available to your code.

```c++
flutter:
    user-material-design: true
    assets:
        -image/lake.jpg
```

Now you can reference the image from your code:

```c++
body: Column(
    children: [
        Image.asset(
            'images/lake.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
        ),
        ...
    ]
)
```

BoxFit.cover tells the framework that the image should be as small as possible but cover its entire render box.

**Step 6: Final touch**
In this final step, arrange all of the elements in a ListView, rather than a Column, because a ListView supports app body scrolling when the app is run on a small device.

```c++
- body: Column(
+ body: ListView(
    ...
)
