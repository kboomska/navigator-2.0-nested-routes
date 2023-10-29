import 'package:flutter/material.dart';

import 'package:navigation_2_0_nested_routers/model/book.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back'),
            ),
            Text(book.title, style: Theme.of(context).textTheme.titleLarge),
            Text(book.author, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
