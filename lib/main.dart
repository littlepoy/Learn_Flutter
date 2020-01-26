// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/**
 * NOTE!!
 * 
 * - Stateless widgets are immutable, 
 * "meaning that their properties can’t change—all values are final."!!!!
 * 
 * - Stateful widgets maintain state that might change during the lifetime
 *  of the widget. Implementing a stateful widget requires at least 
 * two classes: 
 * 1) a StatefulWidget class that creates an instance of 
 * 2) a State class. The StatefulWidget class is, itself, 
 * immutable, but the State class persists over the lifetime of the widget
 * 
 */

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() =>
    runApp(MyApp()); //Use arrow => notation for one-line functions or methods.

/*
The app extends StatelessWidget which makes the app itself a widget. 
In Flutter, almost everything is a widget, 
including alignment, padding, and layout.
*/
class MyApp extends StatelessWidget {
  @override
  /**
   * build() method that describes 
   * how to display the widget in terms of other, lower level widgets.
   */
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Nuan\'s home startup name generator',
      home: RandomWords(),

      //home: Scaffold(
        /**
         * The Scaffold widget, from the Material library, 
         * provides a default app bar, title, and a body property that 
         * holds the widget tree for the home screen. 
         * The widget subtree can be quite complex.
         */
       /* appBar: AppBar(
          title: Text('Nuans home startup name generator'),
        ),

        /**
         * The body for this example consists of a Center widget 
         * containing a Text child widget. 
         * The Center widget aligns its widget subtree to the 
         * center of the screen.
         */
        body: Center(
          child: RandomWords(), // <- HERE!!
        ),
      ), */
    );
  }
}

//stateful widget <- will use as a child in stateless
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

//state class for RandomWords
class RandomWordsState extends State<RandomWords> {
  //Prefixing an identifier with an underscore enforces privacy in the Dart language.
  /**
   * https://dart.dev/guides/language/language-tour#libraries-and-visibility
   * 
   * but are a unit of privacy: identifiers that start with 
   * an underscore (_) are visible only inside the library. Every 
   * Dart app is a library, even if it doesn’t use a library directive.
   */
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // TODO Add build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  /**
   * The ListView class provides a builder property, 
   * itemBuilder, that’s a factory builder and callback function 
   * specified as an anonymous function. Two parameters are passed 
   * to the function—the BuildContext, and the row iterator, i. 
   * The iterator begins at 0 and increments each time the function 
   * is called. It increments twice for every suggested 
   * word pairing: once for the ListTile, and once for the Divider. 
   * This model allows the suggested list to grow infinitely as the 
   * user scrolls.
   */
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2 ทำเส้นคั่น*/

          final index = i ~/ 2; /*3 แบ่ง i กลุ่มละ 2 ตัวผลลัพท์ออกมาเป็นกลุ่ม*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
            /*4 ถ้าวิ่งลงมาสุดตาราง จะไปเจ้นเพิ่มอีก 10*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
  /**
   * 1: The itemBuilder callback is called once per suggested 
   * word pairing, and places each suggestion into a ListTile row. 
   * For even rows, the function adds a ListTile row for the word pairing.
   *  For odd rows, the function adds a Divider widget 
   * to visually separate the entries. Note that the divider
   *  might be difficult to see on smaller devices.
   * 
   * 2: Add a one-pixel-high divider widget before each row in the ListView.
   * 
   * 3: The expression i ~/ 2 divides i by 2 and returns an integer result.
   *  For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2. This calculates 
   * the actual number of word pairings in the ListView,
   *  minus the divider widgets.
   * 
   * 4: If you’ve reached the end of the available word pairings,
   *  then generate 10 more and add them to the suggestions list.
   */

  /**
   * This function displays each new pair in a ListTile,
   * which allows you to make the rows more attractive in the next step.
   */
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
