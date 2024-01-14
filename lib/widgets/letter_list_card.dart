import 'package:flutter/material.dart';
import '../models/letter.dart';

class LetterListCard extends StatelessWidget {
  final Letter letter;

  LetterListCard({required this.letter});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                letter.sentTo,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.date_range, size: 16.0),
                  const SizedBox(width: 4.0),
                  Text(letter.sentAt),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16.0),
                  const SizedBox(width: 4.0),
                  Text(letter.location),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                letter.brief,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
