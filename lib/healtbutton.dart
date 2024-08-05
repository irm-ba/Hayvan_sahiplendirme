import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_adoption/vaccination_schedule_add.dart';
import 'package:pet_adoption/vaccination_schedule_list.dart';
import 'package:pet_adoption/vet_visit_add.dart';
import 'package:pet_adoption/vet_visit_list.dart';
import 'package:pet_adoption/widgets/HealthRecordAdd.dart';
import 'package:pet_adoption/widgets/healtRecordList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HealthRecordHomePage()),
                );
              },
              child: const Text('Sağlık Kaydı'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VaccinationScheduleHomePage()),
                );
              },
              child: const Text('Aşı Takvimi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VetVisitHomePage()),
                );
              },
              child: const Text('Veteriner Ziyareti'),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthRecordHomePage extends StatelessWidget {
  const HealthRecordHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sağlık Kaydı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HealthRecordAdd(
                          petId: 'PET_ID')), // Geçerli bir pet ID'si ekleyin
                );
              },
              child: const Text('Sağlık Kaydı Ekle'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HealthRecordList()),
                );
              },
              child: const Text('Sağlık Kayıtlarını Görüntüle'),
            ),
          ],
        ),
      ),
    );
  }
}

class VaccinationScheduleHomePage extends StatelessWidget {
  const VaccinationScheduleHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aşı Takvimi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VaccinationScheduleAdd()),
                );
              },
              child: const Text('Aşı Takvimi Ekle'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VaccinationScheduleList()),
                );
              },
              child: const Text('Aşı Takvimlerini Görüntüle'),
            ),
          ],
        ),
      ),
    );
  }
}

class VetVisitHomePage extends StatelessWidget {
  const VetVisitHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veteriner Ziyareti'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VetVisitAdd()),
                );
              },
              child: const Text('Veteriner Ziyareti Ekle'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VetVisitList()),
                );
              },
              child: const Text('Veteriner Ziyaretlerini Görüntüle'),
            ),
          ],
        ),
      ),
    );
  }
}
