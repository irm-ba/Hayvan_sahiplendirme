import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApplicationDetailPage extends StatelessWidget {
  final String applicationId;

  ApplicationDetailPage({required this.applicationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Başvuru Detayı',
          style: TextStyle(
            fontSize: 16.0, // Başlık yazı boyutu
            fontWeight: FontWeight.bold, // Başlık yazı kalınlığı
            color: Colors.white, // Başlık yazı rengi
          ),
        ),
        backgroundColor: Colors.purple[800], // AppBar arka plan rengi
        elevation: 0, // Gölgelendirme
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white), // Geri düğmesi
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('adoption_applications')
            .doc(applicationId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Detay bulunamadı.'));
          }

          var application = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailCard(
                  title: 'İsim',
                  value: '${application['name'] ?? 'Bilinmiyor'}',
                  icon: Icons.person,
                ),
                _buildDetailCard(
                  title: 'Email',
                  value: '${application['email'] ?? 'Bilinmiyor'}',
                  icon: Icons.email,
                ),
                _buildDetailCard(
                  title: 'Telefon',
                  value: '${application['phone'] ?? 'Bilinmiyor'}',
                  icon: Icons.phone,
                ),
                _buildDetailCard(
                  title: 'Başvuru Nedeni',
                  value: '${application['adoptionReason'] ?? 'Belirtilmemiş'}',
                  icon: Icons.question_answer,
                ),
                _buildDetailCard(
                  title: 'Adres',
                  value: '${application['address'] ?? 'Belirtilmemiş'}',
                  icon: Icons.location_on,
                ),
                _buildDetailCard(
                  title: 'Yaşam Koşulları',
                  value:
                      '${application['livingConditions'] ?? 'Belirtilmemiş'}',
                  icon: Icons.home,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailCard(
      {required String title, required String value, required IconData icon}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3.0, // Gölgelendirme
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Icon(icon, color: Colors.purple[600]), // İkon rengi
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0, // Başlık yazı boyutu
            fontWeight: FontWeight.bold,
            color: Colors.purple[700], // Başlık rengi
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 16.0), // Değer yazı boyutu
        ),
      ),
    );
  }
}
