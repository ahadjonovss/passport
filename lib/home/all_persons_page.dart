import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passport/data/repository/hive_repository.dart';

class AllPersonsPage extends StatefulWidget {
  AllPersonsPage({super.key});

  @override
  State<AllPersonsPage> createState() => _AllPersonsPageState();
}

class _AllPersonsPageState extends State<AllPersonsPage>
    with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final pageData = HiveRepository().readAllData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Barcha ma'lumotlar"),
        actions: [
          IconButton(
              onPressed: () async {
                showAdaptiveDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    actions: [
                      CupertinoDialogAction(
                        child: const Text("Excelga yozish"),
                        onPressed: () async {
                          Navigator.pop(context);
                          await HiveRepository()
                              .generateExcel(int.parse(controller.text));
                        },
                      )
                    ],
                    content: Material(
                      child: Column(
                        children: [
                          TextField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                label: Text("Raqam"),
                                border: OutlineInputBorder()),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.print))
        ],
      ),
      body: pageData.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: pageData.length,
              itemBuilder: (context, index) {
                final person = pageData[index];
                return AnimatedListItem(
                  index: index,
                  length: pageData.length,
                  aniController: _animationController,
                  animationType: AnimationType.flipX,
                  child: ListTile(
                    leading: Text("${index + 1}"),
                    title: Text(
                        "${person.name} ${person.surname} ${person.lastName}"),
                    subtitle: Text(
                        "${person.dateOfBirth} ${person.pinfl} ${person.metrka}"),
                    // Display other properties as desired
                  ),
                );
              },
            )
          : Center(
              child: Image.asset('assets/nodata.png'),
            ),
    );
  }
}
