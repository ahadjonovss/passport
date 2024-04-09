import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passport/data/repository/hive_repository.dart';

void showIOSConfirmCancelDialog(
  BuildContext context,
) {
  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: const Text("Ma'lumotlarni tozalash"),
      content:
          Text("Rostan ham dasturdagi barcha ma'lumotni tozalamoqchimisiz?"),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text('Bekor qilish'),
          onPressed: () => Navigator.of(context).pop(), // Close the dialog
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text(
            'Tasdiqlash',
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            HiveRepository().deleteData();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
