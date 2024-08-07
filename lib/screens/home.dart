import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/account.dart';
import 'package:pet_adoption/models/pet_data.dart';
import 'package:pet_adoption/settings.dart';
import 'package:pet_adoption/aboutpage.dart';
import 'package:pet_adoption/widgets/CustomBottomNavigationBar.dart';
import '../widgets/pet_grid_list.dart'; // Ensure PetGridList is correctly imported

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          /// Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              style: TextStyle(color: Colors.purple), // Text color
              decoration: InputDecoration(
                hintText: 'Aramak için petler',
                hintStyle: TextStyle(
                    color: Colors.purple.withOpacity(0.7)), // Hint text color
                prefixIcon:
                    Icon(Icons.search, color: Colors.purple), // Icon color
                filled: true,
                fillColor: Colors.pink.shade50, // Background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide.none, // No border
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          /// Pet List
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('pet').snapshots(),
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

                return PetGridList(
                    pets:
                        pets); // Ensure PetGridList is properly defined and imported
              },
            ),
          ),
        ],
      ),
    );
  }
}
