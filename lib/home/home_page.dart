import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passport/data/model/person_adapter.dart';
import 'package:passport/data/repository/hive_repository.dart';
import 'package:passport/home/all_persons_page.dart';
import 'package:passport/tools/assistants.dart';
import 'package:passport/tools/input_formmater.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController passport = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController metrka = TextEditingController();
  TextEditingController address = TextEditingController();
  TextInputFormatter dateMaskFormatter = DateMaskInputFormatter();
  CustomMaskInputFormatter maskInputFormatter = CustomMaskInputFormatter();

  @override
  Widget build(BuildContext context) {
    List controllers = [
      name,
      surname,
      lastName,
      passport,
      dateOfBirth,
      metrka,
      address,
    ];

    bool isAllFilled() {
      int count = 0;
      for (TextEditingController ctl in controllers) {
        if (ctl.text.isEmpty) {
          count++;
        }
      }
      return count > 1 ? false : true;
    }

    clearAllControllers() {
      for (TextEditingController ctl in controllers) {
        ctl.clear();
      }
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/logo.png'), fit: BoxFit.cover)),
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Bosh sahifa'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text("Bo'lishish"),
              onTap: () {
                Share.share('Search my app on AppStore as a "Yordamchi"!');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Ma'lumotlarni tozalash"),
              onTap: () {
                Navigator.pop(context);
                showIOSConfirmCancelDialog(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Ma'lumotni kiriting"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllPersonsPage()));
              },
              icon: const Icon(Icons.list))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom),
            child: Column(
              children: [
                const SizedBox(height: 32),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                      label: Text("Ism"), border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: surname,
                  decoration: const InputDecoration(
                      label: Text("Familiya"), border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: lastName,
                  decoration: const InputDecoration(
                      label: Text("Otchestva"), border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [dateMaskFormatter],
                  controller: dateOfBirth,
                  decoration: const InputDecoration(
                      label: Text("Tug'ilgan sana"),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [maskInputFormatter],
                  controller: passport,
                  decoration: const InputDecoration(
                      label: Text("PINFL"), border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: metrka,
                  decoration: const InputDecoration(
                      label: Text("Metrka"), border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: address,
                  decoration: const InputDecoration(
                      label: Text("Manzil"), border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      try {
                        if (isAllFilled()) {
                          HiveRepository().savePerson(PersonModel(
                              name: name.text,
                              surname: surname.text,
                              lastName: lastName.text,
                              dateOfBirth: dateOfBirth.text,
                              pinfl: passport.text,
                              metrka: metrka.text,
                              address: address.text));
                          clearAllControllers();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Ma'lumot qo'shildi!")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Barcha maydonlarni to'ldiring!")));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Xatolik yuz berdi!")));
                      }
                    },
                    child: const Text("   Saqlash    "))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
