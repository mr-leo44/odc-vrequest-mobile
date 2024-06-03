import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Testpage extends ConsumerStatefulWidget {
  const Testpage({super.key});

  @override
  ConsumerState createState() => _TestpageState();
}

class _TestpageState extends ConsumerState<Testpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("TEst Page"),
      ),
    );
  }
}
