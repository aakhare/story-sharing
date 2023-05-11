import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 500:
      const AlertDialog(content: Text("response.body"));
      break;
    default:
      const AlertDialog(content: Text("response.body"));
  }
}
