import 'package:flutter/material.dart';
import 'package:obujulizi_interviews/widgets/alerts/snack_bar.dart';
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
      showMessageSnackBar(context, response.body);
      break;
    default:
      showMessageSnackBar(context, response.body);
  }
}
