import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Adoptiondetails.dart'; // Detay sayfasının import edilmesi

class AdoptionApplicationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Başvuru Listesi',
          style: TextStyle(
            fontSize: 16.0, // Başlık yazı boyutu
            fontWeight: FontWeight.bold, // Başlık yazı kalınlığı
            color: Colors.white, // Başlık yazı rengi
          ),
        ),
        backgroundColor: Colors.purple[800], // AppBar arka plan rengi
        elevation: 4.0, // Gölgelendirme
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white), // Arama düğmesi
            onPressed: () {
              // Arama işlevi eklenebilir
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('adoption_applications')
            .orderBy('name', descending: false) // 'name' alanına göre sıralama
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Başvuru bulunamadı.'));
          }

          var applications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              var application = applications[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: Icon(Icons.person, color: Colors.purple[700]),
                  title: Text(
                    application['name'] ?? 'Bilinmiyor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0, // Başlık yazı boyutu
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationDetailPage(
                          applicationId: application.id,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
