class PersonModel {
  final String name;
  final String surname;
  final String lastName;
  final String dateOfBirth;
  final String pinfl;
  final String metrka;
  final String address;
  final String mahalla = "Хонабод";

  PersonModel({
    required this.name,
    required this.surname,
    required this.lastName,
    required this.dateOfBirth,
    required this.pinfl,
    required this.metrka,
    required this.address,
  });
}
