import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:open_mail_app/open_mail_app.dart';

class AppTermsPage extends StatefulWidget {
  const AppTermsPage({super.key});

  @override
  State<AppTermsPage> createState() => AppTermsPageState();
}

class AppTermsPageState extends State<AppTermsPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 10,
        child: SingleChildScrollView(
            padding: smallPagePadding,
            child: Column(children: [
              mediumVertical,
              Image.asset("assets/icons/gradient_icon.png"),
              smallVertical,
              const Text("Rose Academies Data Privacy Policy",
                  style: headline1),
              extraSmallVertical,
              const Text("Obujulizi Share: Interview App", style: headline2),
              const Text("Effective: December 2, 2022", style: subtitle1),
              mediumVertical,
              const Text(
                  "Rose Academies, Inc. (“us”, “we”, or “our”) owns and uses many Android based application programs that have been developed specifically to educate the low literate learner about healthcare, nutrition, disease prevention and agriculture.",
                  style: bodyText1),
              smallVertical,
              const Text(
                  "This privacy policy applies to the collection, use and disclosure of personal information that we receive during the use of our application program: Obujulizi Share (the “App”).",
                  style: bodyText1),
              mediumVertical,
              const Text("Information Collection and Use", style: headline3),
              mediumVertical,
              const Text(
                  "While participating in our testimonial program, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you. Personally identifiable information may include, but is not limited to your name, profile photo, region and village in which you live and any contact information.",
                  style: bodyText1),
              mediumVertical,
              const Text("How does Rose use the collected data?",
                  style: headline3),
              mediumVertical,
              const Text(
                  "Rose takes very seriously the privacy, confidentiality and security of personal information collected or stored using Obujulizi Share.",
                  style: bodyText1),
              smallVertical,
              const Text(
                  "• Rose fully owns all the application data that is collected, is maintained offline in a secure location, and is not shared or sold to any outside entity.",
                  style: bodyText1),
              smallVertical,
              const Text(
                  "• Rose is responsible for the safe management of personal information, including compliance with the General Data Protection Regulation (GDPR).",
                  style: bodyText1),
              mediumVertical,
              const Text("Changes To This Privacy Policy", style: headline3),
              mediumVertical,
              const Text(
                  "We may need to modify this privacy statement from time to time, especially in response to changing norms and legislations. If we make material changes to this policy, we will place a notice on our website (https://roseacademies.org) so that you are aware of any changes with relation to what information we collect, how we use it, and under what circumstances, if any, we disclose it.",
                  style: bodyText1),
              mediumVertical,
              const Text("Contact Us", style: headline3),
              Row(
                children: [
                  const Flexible(
                    child: Text("If you have any questions, contact us at:",
                        style: bodyText1),
                  ),
                  Flexible(
                    child: TextButton(
                        onPressed: () async {
                          var result = await OpenMailApp.openMailApp();
                          if (!result.didOpen && !result.canOpen) {
                            showMailErrorDialog();
                          } else if (!result.didOpen && result.canOpen) {
                            showMailSuccessDialog(result);
                          }
                        },
                        child: const Text("susan@roseacademies.org")),
                  ),
                ],
              ),
              largeVertical,
              const Text(
                  "Your verbal or written consent to be photographed, videotaped, or recorded gives us authorization to record your statement and acknowledges your acceptance to the practices described in this Privacy Notice.",
                  style: headline4),
              Row(
                children: [
                  Flexible(
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                  const Flexible(
                      child:
                          Text("I have read and agree to the Privacy Policy")),
                ],
              ),
              ElevatedButton(
                  onPressed: isChecked == true
                      ? () {
                          Navigator.pushNamed(context, RoutesName.home);
                        }
                      : null,
                  child: const Text("Continue"))
            ])),
      ),
    );
  }

  void showMailSuccessDialog(var result) => showDialog(
        context: context,
        builder: (_) {
          return MailAppPickerDialog(
            mailApps: result.options,
          );
        },
      );

  void showMailErrorDialog() => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error: Mail App"),
            content: const Text("No mail apps installed"),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Dismiss", style: TextStyle(color: pink)),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
}
