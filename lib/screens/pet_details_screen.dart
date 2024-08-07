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
              decoration: const BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: kGreyTextColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pet.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          pet.breed,
                          style: const TextStyle(
                            fontSize: 18,
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              pet.isGenderMale ? 'Erkek' : 'Dişi',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              pet.age.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 20,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
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
                          value: pet.age.toString(),
                        ),
                      ],
                    ),
                  ),
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
        child: const Center(
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
