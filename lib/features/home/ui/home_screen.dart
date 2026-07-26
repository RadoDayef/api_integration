import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(leading: Icon(Icons.menu), title: Text("Easy News"), actions: [Icon(Icons.search)]),
        body: TabBarView(
          children: [
            Center(child: Text("business")),
            Center(child: Text("entertainment")),
            Center(child: Text("general")),
            Center(child: Text("health")),
            Center(child: Text("science")),
            Center(child: Text("sports")),
            Center(child: Text("technology")),
          ],
        ),
      ),
    );
  }
}
