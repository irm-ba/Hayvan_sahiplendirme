import 'package:cloud_firestore/cloud_firestore.dart';

class PetData {
  final String name;
  final String breed;
  final bool isGenderMale;
  final int age;
  final String imageUrl;
  final String healthStatus;
  final String healthCardImageUrl;
  final String description;
  final String personalityTraits;
  final String animalType;
  final String location;

  PetData({
    required this.name,
    required this.breed,
    required this.isGenderMale,
    required this.age,
    required this.imageUrl,
    required this.healthStatus,
    required this.healthCardImageUrl,
    required this.description,
    required this.personalityTraits,
    required this.animalType,
    required this.location,
  });

  factory PetData.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return PetData(
      name: data['name'] ?? '',
      breed: data['breed'] ?? '',
      isGenderMale: data['isGenderMale'] ?? false,
      age: data['age'] ?? 0,
      imageUrl: data['imageUrl'] ?? '',
      healthStatus: data['healthStatus'] ?? '',
      healthCardImageUrl: data['healthCardImageUrl'] ?? '',
      description: data['description'] ?? '',
      personalityTraits: data['personalityTraits'] ?? '',
      animalType: data['animalType'] ?? '',
      location: data['location'] ?? '',
    );
  }
}
