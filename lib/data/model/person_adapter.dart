import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class PersonModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String surname;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String dateOfBirth;

  @HiveField(4)
  final String pinfl;

  @HiveField(5)
  final String metrka;

  @HiveField(6)
  final String address;

  @HiveField(7)
  final String mahalla;

  PersonModel({
    required this.name,
    required this.surname,
    required this.lastName,
    required this.dateOfBirth,
    required this.pinfl,
    required this.metrka,
    required this.address,
    this.mahalla = 'Хонабод',
  });
}

class PersonModelAdapter extends TypeAdapter<PersonModel> {
  @override
  final int typeId = 0;

  @override
  PersonModel read(BinaryReader reader) {
    return PersonModel(
      name: reader.read(),
      surname: reader.read(),
      lastName: reader.read(),
      dateOfBirth: reader.read(),
      pinfl: reader.read(),
      metrka: reader.read(),
      address: reader.read(),
      mahalla: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, PersonModel obj) {
    writer.write(obj.name);
    writer.write(obj.surname);
    writer.write(obj.lastName);
    writer.write(obj.dateOfBirth);
    writer.write(obj.pinfl);
    writer.write(obj.metrka);
    writer.write(obj.address);
    writer.write(obj.mahalla);
  }
}
