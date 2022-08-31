import 'package:flutter/material.dart';

import '../repostory/account.dart';
import 'main_screen.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key,  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController retypedPasswordController = TextEditingController();

  bool isChecked = false;

  List<String> schoolType = ["Elementary School", "High School", "University"];

  String? school;

  List<String> personalType = ["Student", "Teacher"];

  String? personal;
  String term = """**Privacy Policy**

Ertuğrul Bilgiç built the StudentApp app as a Free app. This SERVICE is provided by Ertuğrul Bilgiç at no cost and is intended for use as is.

This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.

If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.

The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at StudentApp unless otherwise defined in this Privacy Policy.

**Information Collection and Use**

For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to There is no data . The information that I request will be retained on your device and is not collected by me in any way.

The app does use third-party services that may collect information used to identify you.

Link to the privacy policy of third-party service providers used by the app

*   [Google Play Services](https://www.google.com/policies/privacy/)

**Log Data**

I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.

**Cookies**

Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

**Service Providers**

I may employ third-party companies and individuals due to the following reasons:

*   To facilitate our Service;
*   To provide the Service on our behalf;
*   To perform Service-related services; or
*   To assist us in analyzing how our Service is used.

I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

**Security**

I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.

**Links to Other Sites**

This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.

**Children’s Privacy**

These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.

**Changes to This Privacy Policy**

I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.

This policy is effective as of 2023-08-29

**Contact Us**

If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at bilgicertugrul6@gmail.com.

This privacy policy page was created at [privacypolicytemplate.net](https://privacypolicytemplate.net) and modified/generated by [App Privacy Policy Generator](https://app-privacy-policy-generator.nisrulz.com/)""";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(title: const Text("Register Page")),

      body: Center(



        child: SingleChildScrollView(
          child: Column(



            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'images/logo_holder.png',
                  height: 90,
                  width: 90,
                ),
              ),

              Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 8, 20.0, 8),
                          child: TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),

                              labelText: "Username",
                              floatingLabelStyle: const TextStyle(
                                height: 4,
                              ),

                              filled: true,
                              fillColor: Colors.grey[200],
                              prefixIcon: const Icon(Icons.person),),

                            validator: (value) {
                              if(value != null){

                              if(value.isEmpty){
                                return "This Place can not be empty";
                              }else {
                                return null;
                              }
                              }
                            },

                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 8, 20.0, 8),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: numberController,
                                keyboardType: TextInputType.number,

                                decoration: InputDecoration(border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),

                                  labelText: "School Number",
                                  floatingLabelStyle: const TextStyle(
                                    height: 4,
                                  ),

                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  prefixIcon: const Icon(Icons.numbers),

                                ),
                                validator: (value) {
                                  if(value != null){

                                    if(value.isEmpty){
                                      return "This Place can not be empty";
                                    }
                                  }
                                },
                              ),
                            ],
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 8, 20.0, 8),
                          child: TextFormField(
                            obscureText: true,

                            controller: passwordController,
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
                            validator: (value) {
                              if(value != null){

                                if(value.isEmpty){
                                  return "This Place can not be empty";
                                } else if( value.length <6){
                                  return "Password should be minimum 6 characters";
                                }
                              }
                            },

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 8, 20.0, 8),
                          child: TextFormField(
                            obscureText: true,
                            controller: retypedPasswordController,
                            decoration: InputDecoration(border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),

                              labelText: "Retype Password",
                              floatingLabelStyle: const TextStyle(
                                height: 4,
                              ),

                              filled: true,
                              fillColor: Colors.grey[200],
                              prefixIcon: const Icon(Icons.key),
                            ),
                            validator: (value) {
                              if(value != null){

                                if(value.isEmpty){
                                  return "This Place can not be empty";
                                }else if(passwordController.text != retypedPasswordController.text){
                                  return "Password and retyped password doesn't match";
                                }
                              }
                            },

                          ),
                        ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 8, 20.0, 8),
                              child: Column(
                                children: [
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none,

                                    ),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        prefixIcon: const Icon(Icons.school)),

                                    items: schoolType.map(
                                    (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                              )).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        school = value;
                                      });
                                  },
                                    validator: (value) {
                                      if(!schoolType.contains(value)){
                                        return "please select a school type";
                                      }
                                    },
                                  )
                                ]
                              )
                            ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 8, 20.0, 8),
                            child: Column(
                                children: [
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        prefixIcon: const Icon(Icons.class_)),

                                    items: personalType.map(
                                    (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                                )).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        personal = value;
                                      });

                                    },
                                    validator: (value) {
                                      if(!personalType.contains(value)){
                                        return "please select a account type";
                                      }
                                    },
                                  )
                                ]
                            )
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 8, 0, 8),
                                child: Column(
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (value) {
                                        setState(() => isChecked = value!);

                                      },)
                                    ]
                                )
                            ),

                          const Text("I agree to the"),
                          TextButton(
                              onPressed: () {
                            showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    // false = user must tap button, true = tap outside dialog
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        title: const Text('Terms'),
                                        content: SingleChildScrollView(child: Text(term)),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('CANCEL'),
                                          ),
                                          TextButton(

                                            onPressed: () {
                                              setState(() {
                                                isChecked = true;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text('ACCEPT'),
                                          ),
                                        ],
                                      );
                                    },
                                  );



                          },
                              child: const Text(
                                  "Terms of Service",
                                style: TextStyle(color: Colors.blue),
                              )
                          )],
                        ),




                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: const Text("Register"),
                                onPressed: () {
                                  final everythingOK = formKey.currentState
                                      ?.validate();
                                  if (everythingOK == true && isChecked) {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return MainPage(account: Account(usernameController.text ,
                                        passwordController.text,int.parse(numberController.text),school!,personal!),
                                      );
                                    },));


                                  }

                                  else if (!isChecked) {
                                    showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,

                                        builder: (BuildContext dialogContext) {
                                          return AlertDialog(
                                            title: const Text('Terms'),
                                            content: SingleChildScrollView(
                                                child: Text(term)),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('CANCEL'),
                                              ),
                                              TextButton(

                                                onPressed: () {
                                                  setState(() {
                                                    isChecked = true;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('ACCEPT'),
                                              ),
                                            ],
                                          );
                                        }
                                        );
                                   }
                                 }
                                ),
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
      ),
    );
  }
}

