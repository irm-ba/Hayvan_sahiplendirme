import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/account.dart';
import 'package:pet_adoption/models/pet_data.dart';
import 'package:pet_adoption/settings.dart';
import 'package:pet_adoption/aboutpage.dart';
import 'package:pet_adoption/widgets/CustomBottomNavigationBar.dart';
import '../widgets/pet_grid_list.dart'; // Ensure PetGridList is correctly imported

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = 'Kayıp İlanları';

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 30),
    child:Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: kBrownColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Ayarlar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.announcement_outlined),
              title: Text('Bize Ulaşın'),
              onTap: () {
                // Replace with the appropriate page
              },
            ),
            ListTile(
              leading: Icon(Icons.accessibility_new_sharp),
              title: Text('Hakkımızda'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: IconButton(
                  icon: Icon(Icons.menu_rounded, color: kBrownColor),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            );
          },
        ),
        title: const Text('Felvera'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(kDummyProfilePicUrl),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          /// Categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [

                _buildCategoryButton('Kedi İlanları'),
                _buildCategoryButton('Kayıp İlanları'),
                _buildCategoryButton('Tüm İlanlar'),
                _buildCategoryButton('Köpek İlanları'),

              ],
            ),
          ),
          const SizedBox(height: 24),

          /// Pet List
          Expanded(
            child: StreamBuilder(
              stream: _getCategoryStream(selectedCategory),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Hata oluştu: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Hiç hayvan bulunamadı.'));
                }

                // Firestore'dan gelen verileri PetData listesine dönüştürme
                List<PetData> pets =
                snapshot.data!.docs.map((DocumentSnapshot doc) {
                  return PetData.fromSnapshot(doc);
                }).toList();

                return PetGridList(pets: pets);
              },
            ),
          ),
        ],
      ),
    )
    );


  }

  Widget _buildCategoryButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: selectedCategory == category ? kBrownColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: selectedCategory == category ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> _getCategoryStream(String category) {
    if (category == 'Kayıp İlanları') {
      return FirebaseFirestore.instance.collection('lost_animals').snapshots();
    } else if (category == 'Kedi İlanları') {
      return FirebaseFirestore.instance
          .collection('pet')
          .where('animalType', isEqualTo: 'Kedi')
          .snapshots();
    } else if (category == 'Köpek İlanları') {
      return FirebaseFirestore.instance
          .collection('pet')
          .where('animalType', isEqualTo: 'Köpek')
          .snapshots();
    } else {
      return FirebaseFirestore.instance.collection('pet').snapshots();
    }

  }
}
