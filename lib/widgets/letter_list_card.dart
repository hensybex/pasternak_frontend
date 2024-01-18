import 'package:flutter/material.dart';
import 'package:pasternak_frontend/models/letter_composite.dart';

class LetterListCard extends StatelessWidget {
  final LetterComposite letterComposite;

  const LetterListCard({super.key, required this.letterComposite});

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
                letterComposite.sentTo,
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
                  Text(letterComposite.sentAt),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16.0),
                  const SizedBox(width: 4.0),
                  Text(letterComposite.location),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                letterComposite.brief,
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
