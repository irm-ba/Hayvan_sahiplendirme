import 'package:flutter/material.dart';
import 'package:pet_adoption/models/pet_data.dart';

class PetDetailsScreen extends StatelessWidget {
  final PetData pet;

  const PetDetailsScreen({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pet.name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.purple[800],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.purple[800]),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(pet.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        pet.isGenderMale ? Icons.male : Icons.female,
                        color: Colors.purple[700],
                      ),
                      SizedBox(width: 8),
                      Text(
                        pet.breed,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  buildInfoCard(
                    title: 'Yaş',
                    content: '${pet.age} yaşında',
                    icon: Icons.cake,
                    iconColor: Colors.purple[300],
                  ),
                  buildInfoCard(
                    title: 'Sağlık Durumu',
                    content: pet.healthStatus,
                    icon: Icons.local_hospital,
                    iconColor: Colors.red[300],
                  ),
                  buildInfoCard(
                    title: 'Hayvan Türü',
                    content: pet.animalType,
                    icon: Icons.pets,
                    iconColor: Colors.orange[300],
                  ),
                  buildInfoCard(
                    title: 'Lokasyon',
                    content: pet.location,
                    icon: Icons.location_on,
                    iconColor: Colors.blue[300],
                  ),
                  buildInfoCard(
                    title: 'Açıklama',
                    content: pet.description,
                    icon: Icons.description,
                    iconColor: Colors.green[300],
                  ),
                  if (pet.healthCardImageUrl.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sağlık Kartı:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenImage(
                                  imageUrl: pet.healthCardImageUrl,
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              pet.healthCardImageUrl,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Sağlık kartı bulunmuyor.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 120, 33, 109),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
    required Color? iconColor,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor!.withOpacity(0.1),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple[800],
          ),
        ),
        subtitle: Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text('Sağlık Kartı'),
        centerTitle: true,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
