import 'package:flutter/material.dart';
import 'quote.dart';

class QuoteCard extends StatelessWidget {
  final Function() delete;
  const QuoteCard({Key? key, required this.quote, required this.delete})
      : super(key: key);

  final Quote quote;

  @override
  Widget build(BuildContext context) => Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  quote.quote,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  quote.author,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 10),
                IconButton(icon: const Icon(Icons.delete), onPressed: delete)
              ])));
}
