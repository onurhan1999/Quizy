import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizlen/components/decoration.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/pages/authentication_pages/login_page.dart';
import 'package:quizlen/services/AuthenticationService.dart';
import '../../firebase_options.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    _username.dispose();
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
            child: ColumnWidget(context),
          ),
        ),
      ),
    );
  }

  Column ColumnWidget(BuildContext context) {
    return Column(
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
              UsernameTextField(),
              const Spacer(
                flex: 5,
              ),
              EmailTextField(),
              const Spacer(
                flex: 5,
              ),
              PasswordTextField(),
              const Spacer(
                flex: 5,
              ),
              const Spacer(
                flex: 5,
              ),
              SignUpButton(),
              const Spacer(
                flex: 5,
              ),
              GmailSignUpButton(),
              const Spacer(
                flex: 10,
              ),
              const Divider(
                height: 30,
                color: Colors.black,
              ),
              DoYouHaveAccountButton(context)
            ],
          );
  }

  Row DoYouHaveAccountButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hesabınız var mı?",
          style: Theme.of(context).textTheme.headline6,
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text("Giriş Yapın")),
      ],
    );
  }

  Flexible GmailSignUpButton() {
    return Flexible(
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
    );
  }

  Flexible SignUpButton() {
    return Flexible(
      flex: 15,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: ColorConstants.logoRed),
        child: MaterialButton(
          onPressed: () async {
            final email = _email.text.trim();
            final password = _password.text.trim();
            final username = _username.text.trim();
            final userCredential =
                _authService.SignUp(email, password, username);
            print(userCredential);
          },
          child: const Text(
            "Kayıt Ol ",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Flexible PasswordTextField() {
    return Flexible(
      flex: 15,
      child: TextFormField(
        controller: _password,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorConstants.deepPurple, width: 2.5),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          labelText: "Şifre giriniz",
          prefixIcon: Icon(Icons.lock),
          suffixIcon: Icon(Icons.remove_red_eye),
        ),
      ),
    );
  }

  Flexible EmailTextField() {
    return Flexible(
      flex: 15,
      child: TextFormField(
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstants.deepPurple, width: 2.5),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            labelText: "E-mail giriniz",
            prefixIcon: const Icon(Icons.email)),
      ),
    );
  }

  Flexible UsernameTextField() {
    return Flexible(
      flex: 15,
      child: TextFormField(
        controller: _username,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstants.deepPurple, width: 2.5),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            labelText: "Kullanıcı adınızı giriniz",
            prefixIcon: const Icon(Icons.person)),
      ),
    );
  }
}
