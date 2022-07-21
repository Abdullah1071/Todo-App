import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/models/phone_numbers.dart';

class PhoneNumbersApi {
  static Future<List<PhoneNumber>> getPhoneNumbersLocally(
      BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data =
        await assetBundle.loadString("assets/CountryCodesData/countries.json");
    final body = json.decode(data);
    return body.map<PhoneNumber>(PhoneNumber.fromJson).toList();
  }
}
