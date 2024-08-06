import 'package:e_store1/pages/bottomnav.dart';
import 'package:e_store1/pages/login.dart';
import 'package:e_store1/services/SharedPreferance.dart';
import 'package:e_store1/services/database.dart';
import 'package:e_store1/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String image;
  String? name, password, email;
  bool _isPasswordVisible = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void register() async {
    if (name != null && email != null && password != null) {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email!, password: password!);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => BottomNav()));
        //String id = randomAlphaNumeric(10);
        String generatedUid = userCredential.user!.uid;
        //store data locally in shared preferences
        await SaveUserDataLocal().saveUserID(generatedUid);
        await SaveUserDataLocal().saveUserEmail(emailcontroller.text);
        await SaveUserDataLocal().saveUserName(namecontroller.text);
        await SaveUserDataLocal().saveUserPassword(passwordcontroller.text);
        await SaveUserDataLocal().saveUserImage(
            'https://firebasestorage.googleapis.com/v0/b/e-store1-fe64e.appspot.com/o/user.png?alt=media&token=694cc336-e7d2-417d-9f77-f73dce3a1428');
        // await SaveUserDataLocal().serprint();
        Map<String, dynamic> userinfo = {
          "Name": namecontroller.text,
          "Email": emailcontroller.text,
          "Id": generatedUid,
          "Image":
              'https://firebasestorage.googleapis.com/v0/b/e-store1-fe64e.appspot.com/o/user.png?alt=media&token=694cc336-e7d2-417d-9f77-f73dce3a1428',
        };
        //store data in firestore
        DatabaseMethod().addUserInfo(userinfo, generatedUid);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Signup successfully",
            style: TextStyle(fontSize: 20),
          ),
        ));
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Password provided is too weak",
              style: TextStyle(fontSize: 20),
            ),
          ));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Email already in use",
              style: TextStyle(fontSize: 20),
            ),
          ));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    image = "images/9.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      image,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Sign Up",
                      style: AppWidget.semiboldTextStyle(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Please enter the details below to \n                      continue",
                    style: AppWidget.lightTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Name",
                    style: AppWidget.semiboldTextStyle(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Name",
                      ),
                      controller: namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the name";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Email",
                    style: AppWidget.semiboldTextStyle(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the email";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password",
                    style: AppWidget.semiboldTextStyle(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the password";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forget Password?",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          name = namecontroller.text;
                          password = passwordcontroller.text;
                          email = emailcontroller.text;
                        });
                        register();
                      }
                    },
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: AppWidget.lightTextFieldStyle(),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Login()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
