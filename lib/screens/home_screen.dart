import 'package:flutter/material.dart';
import 'package:pet_adoption/account.dart';
import 'package:pet_adoption/product_add_page.dart' as product;

void main() {
  runApp(PetHealthApp());
}

class PetHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evcil Hayvan Sağlık Yönetimi',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/saglik-kayitlari': (context) => HealthRecordsPage(),
        '/asi-takvimleri': (context) => VaccinationSchedulesPage(),
        '/veteriner-ziyaretleri': (context) => VetVisitsPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evcil Hayvan Sağlık Yönetimi"),
        backgroundColor: const Color.fromARGB(255, 210, 141, 212),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Evcil Hayvan Sağlık Yönetimi'ne \n                   Hoşgeldiniz",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/saglik-kayitlari');
              },
              child: const Text("Sağlık Kayıtlarını Yönet"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 210, 141, 212),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/asi-takvimleri');
              },
              child: const Text("Aşı Takvimlerini Yönet"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 210, 141, 212),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/veteriner-ziyaretleri');
              },
              child: const Text("Veteriner Ziyaretlerini Yönet"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 210, 141, 212),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    List<IconData> icons = [
      Icons.home,
      Icons.search,
      Icons.add,
      Icons.local_hospital,
      Icons.person_outline,
    ];

    return BottomNavigationBar(
      currentIndex: 0, // Set the initial selected index to 0 (home)
      items: icons.map((icon) => item(icon)).toList(),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF9C27B0), // Purple color for selected item
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (icons[index]) {
          case Icons.add:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => product.ProductAdd(),
              ),
            );
            break;
          case Icons.local_hospital:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PetHealthApp(),
              ),
            );
            break;
          case Icons.person_outline:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountPage(),
              ),
            );
            break;
          default:
            break;
        }
      },
    );
  }

  BottomNavigationBarItem item(IconData icon) {
    return BottomNavigationBarItem(
      icon: icon == Icons.add ? addButton() : Icon(icon),
      label: "",
    );
  }

  Widget addButton() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFF9C27B0), // Purple color
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}

class HealthRecordsPage extends StatefulWidget {
  const HealthRecordsPage({super.key});

  @override
  _HealthRecordsPageState createState() => _HealthRecordsPageState();
}

class _HealthRecordsPageState extends State<HealthRecordsPage> {
  final List<HealthRecord> _records = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sağlık Kayıtları"),
        backgroundColor: const Color.fromARGB(255, 210, 141, 212),
      ),
      body: ListView.builder(
        itemCount: _records.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_records[index].description),
            subtitle:
                Text(_records[index].date.toIso8601String().split('T')[0]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<HealthRecord>(
            context: context,
            builder: (context) => HealthRecordDialog(),
          );
          if (result != null) {
            setState(() {
              _records.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 210, 141, 212),
      ),
    );
  }
}

class VaccinationSchedulesPage extends StatefulWidget {
  const VaccinationSchedulesPage({super.key});

  @override
  _VaccinationSchedulesPageState createState() =>
      _VaccinationSchedulesPageState();
}

class _VaccinationSchedulesPageState extends State<VaccinationSchedulesPage> {
  DateTime? start;
  DateTime? end;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aşı Takvimleri"),
        backgroundColor: const Color.fromARGB(255, 210, 141, 212),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Tarih Aralığı Seç",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              start != null && end != null
                  ? "${start!.toIso8601String().split('T')[0]} - ${end!.toIso8601String().split('T')[0]}"
                  : "Henüz tarih aralığı seçilmedi",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now().add(const Duration(days: 356)),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Color.fromARGB(255, 210, 141, 212),
                          onPrimary: Color.fromARGB(255, 255, 255, 255),
                          onSurface: Color.fromARGB(255, 179, 119, 184),
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 198, 104, 197),
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (result != null) {
                  setState(() {
                    start = result.start;
                    end = result.end;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 210, 141, 212),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text("Tarih Aralığı Seç"),
            ),
          ],
        ),
      ),
    );
  }
}

class VetVisitsPage extends StatefulWidget {
  const VetVisitsPage({super.key});

  @override
  _VetVisitsPageState createState() => _VetVisitsPageState();
}

class _VetVisitsPageState extends State<VetVisitsPage> {
  final List<VetVisit> _visits = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Veteriner Ziyaretleri"),
        backgroundColor: const Color.fromARGB(255, 210, 141, 212),
      ),
      body: ListView.builder(
        itemCount: _visits.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_visits[index].description),
            subtitle: Text(_visits[index].date.toIso8601String().split('T')[0]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<VetVisit>(
            context: context,
            builder: (context) => VetVisitDialog(),
          );
          if (result != null) {
            setState(() {
              _visits.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 210, 141, 212),
      ),
    );
  }
}

class HealthRecordDialog extends StatefulWidget {
  @override
  _HealthRecordDialogState createState() => _HealthRecordDialogState();
}

class _HealthRecordDialogState extends State<HealthRecordDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _description;
  late DateTime _date;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Yeni Sağlık Kaydı Ekle"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Açıklama"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen bir açıklama girin";
                }
                return null;
              },
              onSaved: (value) {
                _description = value!;
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: "Tarih (yyyy-mm-dd)"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen bir tarih girin";
                }
                try {
                  _date = DateTime.parse(value);
                } catch (e) {
                  return "Geçersiz tarih formatı";
                }
                return null;
              },
              onSaved: (value) {
                _date = DateTime.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("İptal"),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop(
                HealthRecord(description: _description, date: _date),
              );
            }
          },
          child: const Text("Kaydet"),
        ),
      ],
    );
  }
}

class VetVisitDialog extends StatefulWidget {
  @override
  _VetVisitDialogState createState() => _VetVisitDialogState();
}

class _VetVisitDialogState extends State<VetVisitDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _description;
  late DateTime _date;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Yeni Veteriner Ziyareti Ekle"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Açıklama"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen bir açıklama girin";
                }
                return null;
              },
              onSaved: (value) {
                _description = value!;
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: "Tarih (yyyy-mm-dd)"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen bir tarih girin";
                }
                try {
                  _date = DateTime.parse(value);
                } catch (e) {
                  return "Geçersiz tarih formatı";
                }
                return null;
              },
              onSaved: (value) {
                _date = DateTime.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("İptal"),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop(
                VetVisit(description: _description, date: _date),
              );
            }
          },
          child: const Text("Kaydet"),
        ),
      ],
    );
  }
}

class HealthRecord {
  final String description;
  final DateTime date;

  HealthRecord({required this.description, required this.date});
}

class VetVisit {
  final String description;
  final DateTime date;

  VetVisit({required this.description, required this.date});
}
