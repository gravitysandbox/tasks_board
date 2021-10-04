import 'package:flutter/material.dart';

class NothingToShow extends StatelessWidget {
  const NothingToShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Nothing to show yet.',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
