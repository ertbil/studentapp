import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/pages/register_page.dart';
import 'package:studentapp/utilities/google_sign_in.dart';
import '../repostory/account.dart';
import 'main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO login screen ile splash screen birleştirilecek
List<Account> accounts = [Account("Ert", "123456", 123, "University", "Student")];

void main() {
  runApp(ProviderScope(child: const StudentApp()));
}

class StudentApp extends StatelessWidget {
  const StudentApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  LogInPage(),
    );
  }
}
class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void initializeFirebase() async {
    await Firebase.initializeApp();
    if(FirebaseAuth.instance.currentUser != null){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return MainPage(account: accounts[0]);
          }
          )
      );
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context)  => LogInPage()

    )
    );
  }
}

class LogInPage extends StatelessWidget {
   LogInPage({Key? key}) : super(key: key);


  TextEditingController usernameController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(


        child: Column(



          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/logo_holder.png',
                height: 90,
                width: 90,
              ),
            )
            ,
            Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if(value != null){

                              if(value.isEmpty){
                                return "This Place can not be empty";
                              }else if( usernameController.text != accounts[0].username){
                                return "There is no account";
                              }
                            }
                          },

                          controller: usernameController,
                          decoration: InputDecoration(border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),

                            labelText: "Student Name",
                            floatingLabelStyle: const TextStyle(
                                height: 4,
                                ),

                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: const Icon(Icons.person),),

                  ),
                      ),

                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if(value != null){

                              if(value.isEmpty){
                                return "This Place can not be empty";
                              }else if( passwordController.text != accounts[0].password){
                                return "There is no account";
                              }
                            }
                          },
                          controller: passwordController,
                          obscureText: true,

                          decoration: InputDecoration(border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),

                            labelText: "Password",
                            floatingLabelStyle: const TextStyle(
                              height: 4,
                            ),

                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: const Icon(Icons.key),
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(onPressed: (){
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                // false = user must tap button, true = tap outside dialog
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title: Text('Your Password'),
                                    content: SingleChildScrollView(child: Text(accounts[0].password)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('CANCEL'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },child: Text("Forgotten Password?")
                            ),
                          ],
                        ),

                      ],
                    ),

                  ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(

                                onPressed: () async {
                                  await signInWithGoogle();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                        return MainPage(account: accounts[0]);
                                      }
                                      )
                                  );
                                },
                                icon: Image.asset("images/google_logo.png")
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text("Log in"),
                            onPressed: () {
                              final bool? everythingOK = formKey.currentState
                                  ?.validate();

                              if (everythingOK == true) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                      return MainPage(account: accounts[0]);
                                    }
                                    )
                                );

                              }
                            }

                              ,),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text("Register"),
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return RegisterPage();
                                }));

                              }
                              ,),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
