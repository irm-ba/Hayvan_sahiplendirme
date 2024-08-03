import 'package:flutter/material.dart';
import 'package:pet_adoption/models/pet_data.dart';

import '../constants.dart';

class PetDetailsInfoCard extends StatelessWidget {
  final PetData pet;

  const PetDetailsInfoCard({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            pet.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: kBrownColor,
            ),
          ),
          trailing: const Text(
            '', // Placeholder for additional info like price
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 24,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pet.isGenderMale ? 'Erkek' : 'Dişi',
                style: TextStyle(
                  color: pet.isGenderMale ? Colors.blue : Colors.pink,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${pet.age ?? 'Bilinmeyen'} yaşında',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sağlık Kartı URLsi: ${pet.healthCardImageUrl}',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sağlık Durumu: ${pet.healthStatus}',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
