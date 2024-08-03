import 'package:flutter/material.dart';
import 'package:pet_adoption/widgets/CustomBottomNavigationBar.dart';

// URL ve renk sabitlerini tanımlayalım
class Urls {
  static const String avatar1 = 'https://example.com/avatar1.jpg';
}

class Colorz {
  static const Color accountPurple = Colors.purple;
}

class Txt extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;

  const Txt({required this.text, this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
      ),
    );
  }
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      backgroundColor: Color(0xffffffff), // Demo amaçlı beyaz renk
      body: ListView(
        padding: EdgeInsets.all(12),
        physics: BouncingScrollPhysics(), // Yumuşak kaydırma efekti
        children: [
          Container(height: 35),
          userTile(),
          divider(),
          colorTiles(),
          divider(),
          bwTiles(),
        ],
      ),
    );
  }

  Widget userTile() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(Urls.avatar1),
      ),
      title: Txt(
        text: "Zühal Aslan Akyol",
        fontWeight: FontWeight.bold,
      ),
      subtitle: Txt(text: "Hayvan Sever"),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget colorTiles() {
    return Column(
      children: [
        colorTile(Icons.person_outline, Colors.deepPurple, "Kişisel Bilgiler."),
        colorTile(Icons.settings_outlined, Color.fromARGB(255, 232, 205, 236),
            "Ayarlar"),
        colorTile(Icons.favorite_border, Color.fromARGB(255, 144, 112, 143),
            "Hayvanlarım"),
      ],
    );
  }

  Widget bwTiles() {
    return Column(
      children: [
        bwTile(Icons.info_outline, "SSS"),
        bwTile(Icons.textsms_outlined, "Topluluk"),
      ],
    );
  }

  Widget bwTile(IconData icon, String text) {
    return colorTile(icon, Colors.black, text, blackAndWhite: true);
  }

  Widget colorTile(IconData icon, Color color, String text,
      {bool blackAndWhite = false}) {
    Color pickedColor = Color(0xfff3f4fe);
    return ListTile(
      leading: Container(
        child: Icon(icon, color: color),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: blackAndWhite ? pickedColor : color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Txt(
        text: text,
        fontWeight: FontWeight.w500,
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
      onTap: () {},
    );
  }

  Widget bottomNavigationBar() {
    List<IconData> icons = [
      Icons.home,
      Icons.search,
      Icons.add,
      Icons.notifications,
      Icons.person_outline,
    ];

    return BottomNavigationBar(
      currentIndex: 2,
      items: icons.map((icon) => item(icon)).toList(),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      selectedItemColor: Colorz.accountPurple,
      unselectedItemColor: Colors.grey,
    );
  }

  BottomNavigationBarItem item(IconData icon) {
    return BottomNavigationBarItem(
      icon: icon == Icons.add ? addButton() : Icon(icon),
      label: "",
    );
  }

  Widget addButton() {
    return CircleAvatar(
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Colorz.accountPurple,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AccountPage(),
  ));
}
