import 'package:e_store1/services/SharedPreferance.dart';
import 'package:flutter/material.dart';
import 'package:e_store1/pages/login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecefe8),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("images/headphone.PNG"),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Explore\nThe Best\nProducts",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _isloading = true;
                    });

                    await SaveUserDataLocal().saveOnboardingStatus(true);
                    setState(() {
                      _isloading = false;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Login(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: _isloading
                        ? CircularProgressIndicator()
                        : Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
