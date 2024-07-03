import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Layouts in Flutter'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              color: Colors.blue,
              height: 50.0,
              width: 50.0,
              margin: const EdgeInsets.all(10.0),
            ),
            const Row(
              children: <Widget>[
                Expanded(child: Text('Item 1')),
                Expanded(child: Text('Item 2')),
                Expanded(child: Text('Item 3')),
              ],
            ),
            const Column(
              children: <Widget>[
                Text('Column Item 1'),
                Text('Column Item 2'),
              ],
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                Container(color: Colors.red, margin: const EdgeInsets.all(5.0)),
                Container(
                    color: Colors.green, margin: const EdgeInsets.all(5.0)),
                Container(
                    color: Colors.blue, margin: const EdgeInsets.all(5.0)),
                Container(
                    color: Colors.yellow, margin: const EdgeInsets.all(5.0)),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'CustomScrollView with Slivers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 600,
              child: CustomScrollView(
                slivers: <Widget>[
                  const SliverAppBar(
                    pinned: true,
                    expandedHeight: 150.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('SliverAppBar'),
                    ),
                  ),
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 4.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.teal[100 * (index % 9)],
                          child: Text('Grid Item $index'),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(
                          title: Text('List Item $index'),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
