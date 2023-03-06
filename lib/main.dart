import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedListApp());
}

class AnimatedListApp extends StatelessWidget {
  const AnimatedListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedListView(),
    );
  }
}

class AnimatedListView extends StatelessWidget {
  const AnimatedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Animated List"),
          centerTitle: true,
        ),
        body: const CustomAnimatedList(),
      ),
    );
  }
}

class CustomAnimatedList extends StatefulWidget {
  const CustomAnimatedList({super.key});

  @override
  State<CustomAnimatedList> createState() => _CustomAnimatedListState();
}

class _CustomAnimatedListState extends State<CustomAnimatedList> {
  final List<String> items = [];
  final GlobalKey<AnimatedListState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: AnimatedList(
            initialItemCount: items.length,
            key: key,
            itemBuilder: (context, int index, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: AnimatedListItem(
                  onPressed: () {
                    DeleteItem(index);
                  },
                  text: items[index],
                ),
              );
            }),
      ),
      TextButton(
          onPressed: () {
            InsertItem();
          },
          child: const Text(
            "add",
            style: TextStyle(fontSize: 22),
          ))
    ]);
  }

  // ignore: non_constant_identifier_names
  void InsertItem() {
    var index = items.length;
    items.add("item${index + 1}");
    key.currentState?.insertItem(index);
  }

  // ignore: non_constant_identifier_names
  void DeleteItem(int index) {
   var removeditem = items.removeAt(index);
    key.currentState?.removeItem(index, (context, animation) {
      return SizeTransition(sizeFactor: animation,
        child: AnimatedListItem(text: removeditem, onPressed: () {}));
    });
  }
}

class AnimatedListItem extends StatelessWidget {
  const AnimatedListItem(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 11,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.amber,
        ),
        title: Text(text),
        subtitle: const Text("subtitle"),
        trailing:
            IconButton(onPressed: onPressed, icon: const Icon(Icons.delete)),
      ),
    );
  }
}
