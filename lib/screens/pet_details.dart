import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/widgets/custom_infographic.dart'; // Ensure CustomInfographic is correctly imported
import 'package:pet_adoption/models/pet_data.dart';

class PetDetailsScreen extends StatelessWidget {
  final PetData pet;

  const PetDetailsScreen({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPinkishColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceMaterialTransparency: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                pet.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: kPrimaryColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: kBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: kGreyTextColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    pet.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    pet.breed,
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        pet.isGenderMale ? 'Erkek' : 'Dişi',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        '${pet.age} yaşında',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 20,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomInfographic(
                        color: kPrimaryColor,
                        title: 'Cinsiyet',
                        value: pet.isGenderMale ? 'Erkek' : 'Dişi',
                      ),
                      CustomInfographic(
                        color: const Color(0xffF78F8F),
                        title: 'Yaş',
                        value: pet.age,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(
                    thickness: 1,
                    height: 20,
                    indent: 0,
                    endIndent: 0,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      kDummyDescription,
                      style: TextStyle(
                        color: kGreyTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        height: 48,
        decoration: BoxDecoration(
          gradient: kLinearGradient,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            'Sahiplen',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
