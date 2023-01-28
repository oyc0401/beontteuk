import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../model/write_model.dart';

class SlideTest extends StatelessWidget {
  const SlideTest({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ReorderableListView Sample')),
      body: const ReorderableExample(),
    );
  }
}

class ReorderableExample extends StatefulWidget {
  const ReorderableExample({super.key});

  @override
  State<ReorderableExample> createState() => _ReorderableExampleState();
}

class _ReorderableExampleState extends State<ReorderableExample> {
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.15);
    final Color draggableItemColor = colorScheme.secondary;

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: draggableItemColor,
            shadowColor: draggableItemColor,
            child: child,
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      proxyDecorator: proxyDecorator,
      children: [
        for (int index = 0; index < widgets.length; index += 1) widgets[index]
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Widget item = widgets.removeAt(oldIndex);
          widgets.insert(newIndex, item);
        });
      },
    );
  }

  List<Widget> widgets = [
    ListTile(
      key: Key('1'),
      tileColor: Colors.redAccent,
      title: Text('Item 1'),
    ),
    Image.network(
        key: Key('2'),
        'https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E',
        fit: BoxFit.fitWidth),
    TextField(
      key: Key("3"),
    ),
    TextField(
      key: Key("4"),
    ),
  ];
  FocusNode _focus = FocusNode();
}
