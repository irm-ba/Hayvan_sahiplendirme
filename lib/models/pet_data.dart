import 'package:cloud_firestore/cloud_firestore.dart';

class PetData {
  final String name;
  final String breed;
  final bool isGenderMale;
  final String age;
  final String imageUrl;
  final String healthStatus;
  final String healthCardImageUrl;

  PetData({
    required this.name,
    required this.breed,
    required this.isGenderMale,
    required this.age,
    required this.imageUrl,
    required this.healthStatus,
    required this.healthCardImageUrl,
  });

  factory PetData.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PetData(
      name: data['name'],
      breed: data['breed'],
      isGenderMale: data['isGenderMale'],
      age: data['age'],
      imageUrl: data['imageUrl'],
      healthStatus: data['healthStatus'],
      healthCardImageUrl: data['healthCardImageUrl'],
    );
  }
}
