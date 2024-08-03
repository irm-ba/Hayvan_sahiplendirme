import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController hayvanTuruController = TextEditingController();
  final TextEditingController hayvanAciklamasiController =
      TextEditingController();
  final TextEditingController healthStatusController = TextEditingController();

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
        print('Resim Seçilmedi');
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
        _healthCardImage == null) {
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
      age: ageController.text,
      imageUrl: _images[0]
          .path, // Sadece ilk resmi kullanıyorsunuz, diğerleri de eklemek isterseniz uygun yerde güncellemelisiniz.
      healthStatus: healthStatusController.text,
      healthCardImageUrl: _healthCardImage!.path,
    );

    try {
      // Firestore'a yeni pet verisini ekle
      await FirebaseFirestore.instance.collection('pets').add({
        'name': newPet.name,
        'breed': newPet.breed,
        'isGenderMale': newPet.isGenderMale,
        'age': newPet.age,
        'imageUrl': newPet.imageUrl,
        'healthStatus': newPet.healthStatus,
        'healthCardImageUrl': newPet.healthCardImageUrl,
      });

      // Veri eklendikten sonra geri bildirim veya navigasyon yapabilirsiniz
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hayvan başarıyla eklendi!'),
        ),
      );

      // Formu sıfırlamak için gerekli kontrolleri ekleyebilirsiniz (isteğe bağlı)
      nameController.clear();
      breedController.clear();
      ageController.clear();
      hayvanTuruController.clear();
      hayvanAciklamasiController.clear();
      healthStatusController.clear();
      setState(() {
        _images.clear();
        _healthCardImage = null;
      });
    } catch (e) {
      print('Firebase veri eklerken hata oluştu: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hayvan eklenirken bir hata oluştu.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                controller: hayvanTuruController,
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
                controller: hayvanAciklamasiController,
                decoration: InputDecoration(
                  hintText: "Açıklama",
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
                              Text('Sağlık Karnesi Resmi Seç'),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(_healthCardImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _healthCardImage = null;
                                  });
                                },
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
                        ),
                ),
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
                child: Text("Ekle"),
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
  final String age;
  final String imageUrl;
  final String healthStatus;
  final String healthCardImageUrl;

  PetData({
    required this.name,
    required this.breed,
    required this.isGenderMale,
    required this.age,
    required this.imageUrl,
    required this.healthStatus,
    required this.healthCardImageUrl,
  });
}
