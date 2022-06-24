import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizlen/components/decoration.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import '../../firebase_options.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: DecorationProperties.backgroundDecoration,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(context.dynamicHeight(0.05)),
            child: Column(
              children: [
                const Spacer(
                  flex: 5,
                ),
                Expanded(
                  flex: 50,
                  child: Image.asset("assets/images/logo.png"),
                ),
                const Spacer(
                  flex: 5,
                ),
                Flexible(
                  flex: 15,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.deepPurple, width: 2.5),
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                        ),
                        labelText: "Kullanıcı adınızı giriniz",
                        prefixIcon: const Icon(Icons.person)),
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
                Flexible(
                  flex: 15,
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.deepPurple, width: 2.5),
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                        ),
                        labelText: "E-mail giriniz",
                        prefixIcon: const Icon(Icons.email)),
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
                Flexible(
                  flex: 15,
                  child: TextFormField(
                    controller: _password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.deepPurple, width: 2.5),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      labelText: "Şifre giriniz",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
                
                const Spacer(
                  flex: 5,
                ),
                Flexible(
                  flex: 15,
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorConstants.logoRed),
                    child: MaterialButton(
                      onPressed: ()async {
                        await Firebase.initializeApp(
                        options: DefaultFirebaseOptions.currentPlatform,);
                        final email=_email.text;
                        final password=_password.text;
                        final userCredntial=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                        print(userCredntial);
                      },
                      child: const Text(
                        "Kayıt Ol ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
                Flexible(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Spacer(
                        flex: 22,
                      ),
                      Icon(
                        Icons.mail,
                        size: 50,
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      Icon(
                        Icons.mail,
                        size: 50,
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      Icon(
                        Icons.mail,
                        size: 50,
                      ),
                      Spacer(
                        flex: 22,
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 10,
                ),
                const Divider(
                  height: 30,
                  color: Colors.black,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  Text("Hesabınız var mı?",style: Theme.of(context).textTheme.headline6,),
                  TextButton(onPressed: (){}, child: Text("Giriş Yapın")),

                ],)

              ],
            ),
          ),
        ),
      ),
    );
  }
}