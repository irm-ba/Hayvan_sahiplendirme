import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController healthStatusController = TextEditingController();
  final TextEditingController animalTypeController = TextEditingController();

  String? selectedLocation;
  bool isGenderMale = true;
  List<File> _images = [];
  File? _healthCardImage;

  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
      } else {
        print('Resim seçilmedi');
      }
    });
  }

  Future<void> _getHealthCardImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _healthCardImage = File(pickedFile.path);
      } else {
        print('Sağlık kartı resmi seçilmedi');
      }
    });
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _submitForm() async {
    if (nameController.text.isEmpty ||
        breedController.text.isEmpty ||
        ageController.text.isEmpty ||
        _images.isEmpty ||
        healthStatusController.text.isEmpty ||
        _healthCardImage == null ||
        selectedLocation == null ||
        animalTypeController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lütfen tüm alanları doldurun ve resim ekleyin.'),
        ),
      );
      return;
    }

    final newPet = PetData(
      name: nameController.text,
      breed: breedController.text,
      isGenderMale: isGenderMale,
      age: int.parse(ageController.text),
      imageUrl: _images.isNotEmpty ? _images[0].path : '',
      healthStatus: healthStatusController.text,
      healthCardImageUrl:
          _healthCardImage != null ? _healthCardImage!.path : '',
      description: descriptionController.text,
      personalityTraits: 'Kişilik özellikleri eksik',
      animalType: animalTypeController.text,
      location: selectedLocation!,
    );

    // Firestore koleksiyonuna veri ekleme
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('pet').add({
      'name': newPet.name,
      'breed': newPet.breed,
      'isGenderMale': newPet.isGenderMale,
      'age': newPet.age,
      'imageUrl': newPet.imageUrl,
      'healthStatus': newPet.healthStatus,
      'healthCardImageUrl': newPet.healthCardImageUrl,
      'description': newPet.description,
      'personalityTraits': newPet.personalityTraits,
      'animalType': newPet.animalType,
      'location': newPet.location,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Hayvan başarıyla eklendi!'),
      ),
    );

    // Formu sıfırlamak için
    nameController.clear();
    breedController.clear();
    ageController.clear();
    descriptionController.clear();
    healthStatusController.clear();
    animalTypeController.clear();
    setState(() {
      _images.clear();
      _healthCardImage = null;
      selectedLocation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> cities = [
      'Adana',
      'Adıyaman',
      'Afyonkarahisar',
      'Ağrı',
      'Aksaray',
      'Amasya',
      'Ankara',
      'Antalya',
      'Artvin',
      'Aydın',
      'Balıkesir',
      'Bilecik',
      'Bingöl',
      'Bitlis',
      'Bolu',
      'Burdur',
      'Bursa',
      'Çanakkale',
      'Çankırı',
      'Çorum',
      'Denizli',
      'Diyarbakır',
      'Düzce',
      'Edirne',
      'Elazığ',
      'Erzincan',
      'Erzurum',
      'Eskişehir',
      'Gaziantep',
      'Giresun',
      'Gümüşhane',
      'Hakkari',
      'Hatay',
      'Iğdır',
      'Isparta',
      'İstanbul',
      'İzmir',
      'Kahramanmaraş',
      'Karabük',
      'Karaman',
      'Kars',
      'Kastamonu',
      'Kayseri',
      'Kırıkkale',
      'Kırklareli',
      'Kırşehir',
      'Kilis',
      'Kocaeli',
      'Konya',
      'Kütahya',
      'Malatya',
      'Manisa',
      'Mardin',
      'Mersin',
      'Muğla',
      'Muş',
      'Nevşehir',
      'Niğde',
      'Ordu',
      'Osmaniye',
      'Rize',
      'Sakarya',
      'Samsun',
      'Siirt',
      'Sinop',
      'Sivas',
      'Şanlıurfa',
      'Şırnak',
      'Tekirdağ',
      'Tokat',
      'Trabzon',
      'Tunceli',
      'Uşak',
      'Van',
      'Yalova',
      'Yozgat',
      'Zonguldak'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hayvan Ekle"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Fotoğraflar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _getImage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  height: 200,
                  child: _images.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate,
                                  size: 50, color: Colors.grey),
                              Text('Resim Seç'),
                            ],
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  width: 150,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(_images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Hayvanın Adı",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Hayvanın Adı",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Hayvanın Türü",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              TextField(
                controller: animalTypeController,
                decoration: InputDecoration(
                  hintText: "Hayvanın Türü",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Cins",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              TextField(
                controller: breedController,
                decoration: InputDecoration(
                  hintText: "Cins",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Yaş",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Yaş",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Açıklama",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Hayvanın Açıklaması",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Sağlık Durumu",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              TextField(
                controller: healthStatusController,
                decoration: InputDecoration(
                  hintText: "Sağlık Durumu",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Sağlık Kartı",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _getHealthCardImage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  height: 200,
                  child: _healthCardImage == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate,
                                  size: 50, color: Colors.grey),
                              Text('Sağlık Kartı Ekle'),
                            ],
                          ),
                        )
                      : Image.file(
                          _healthCardImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Lokasyon",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedLocation,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLocation = newValue;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: cities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                hint: Text("Bir şehir seçin"),
              ),
              SizedBox(height: 20),
              Text(
                "Cinsiyet",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Erkek"),
                  Switch(
                    value: isGenderMale,
                    onChanged: (value) {
                      setState(() {
                        isGenderMale = value;
                      });
                    },
                  ),
                  Text("Dişi"),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Gönder"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PetData {
  final String name;
  final String breed;
  final bool isGenderMale;
  final int age;
  final String imageUrl;
  final String healthStatus;
  final String healthCardImageUrl;
  final String description;
  final String personalityTraits;
  final String animalType;
  final String location;

  PetData({
    required this.name,
    required this.breed,
    required this.isGenderMale,
    required this.age,
    required this.imageUrl,
    required this.healthStatus,
    required this.healthCardImageUrl,
    required this.description,
    required this.personalityTraits,
    required this.animalType,
    required this.location,
  });
}
