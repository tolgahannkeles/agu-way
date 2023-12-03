import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.pink,
            labelText: "Name",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.amber,
                  child: const Center(child: Text("xxx Building")),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.amber,
                  child: const Center(child: Text("xxx Building")),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.amber,
                  child: const Center(child: Text("xxx Building")),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.amber,
                  child: const Center(child: Text("xxx Building")),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
