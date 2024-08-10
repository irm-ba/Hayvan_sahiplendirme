import 'package:flutter/material.dart';

class AdoptionApplicationForm extends StatefulWidget {
  @override
  _AdoptionApplicationFormState createState() =>
      _AdoptionApplicationFormState();
}

class _AdoptionApplicationFormState extends State<AdoptionApplicationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _livingConditionsController =
      TextEditingController();
  final TextEditingController _adoptionReasonController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sahiplenme Başvuru Formu'),
        backgroundColor: Colors.purple[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lütfen aşağıdaki bilgileri doldurun:',
                  style: TextStyle(fontSize: 18, color: Colors.purple[800]),
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _nameController,
                  label: 'Adınız ve Soyadınız',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan gereklidir';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _contactController,
                  label: 'İletişim Bilgileriniz',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan gereklidir';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _livingConditionsController,
                  label: 'Yaşam Koşullarınız',
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan gereklidir';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _adoptionReasonController,
                  label: 'Sahiplenme Nedeni',
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan gereklidir';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form verilerini işleme kodunu buraya ekleyin
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Başvurunuz gönderildi!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[700], // Buton rengi
                      foregroundColor:
                          Colors.white, // Buton üzerindeki yazı rengi
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Başvuruyu Gönder'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
      maxLines: maxLines,
      validator: validator,
    );
  }
}
