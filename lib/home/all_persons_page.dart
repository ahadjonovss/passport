import 'package:flutter/material.dart';
import 'package:passport/data/repository/hive_repository.dart';

class AllPersonsPage extends StatelessWidget {
  AllPersonsPage({super.key});


  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pageData = HiveRepository().readAllData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Barcha ma'lumotlar"),
        actions: [
          IconButton(onPressed: () async {
            showDialog(context: context, builder: (context) => AlertDialog(
              actions: [
                ElevatedButton(onPressed: () async {
                  Navigator.pop(context);
                  await  HiveRepository().generateExcel(int.parse(controller.text));

                }, child: Text("Excelga yozish"))
              ],
              content: Container(
                height: 120,
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text("Raqam"), border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            ),);

          }, icon: Icon(Icons.print))
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: pageData.length,
        itemBuilder: (context, index) {
          final person = pageData[index];
          return ListTile(
            leading: Text("${index+1}"),
            title: Text("${person.name} ${person.surname} ${person.lastName}"),
            subtitle: Text("${person.dateOfBirth} ${person.pinfl} ${person.metrka}"),
            // Display other properties as desired
          );
        },
      ),
    );
  }
}
