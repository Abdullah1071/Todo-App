class PhoneNumber {
  final String name;
  final String dial;
  final String code;

  PhoneNumber({
    required this.name,
    required this.dial,
    required this.code,
  });

  static PhoneNumber fromJson(json) => PhoneNumber(
        name: json['name'],
        dial: json['dial'],
        code: json['code'],
      );
}
