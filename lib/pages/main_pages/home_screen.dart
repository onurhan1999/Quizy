import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/components/decoration.dart';
import 'package:quizlen/components/reusable_widgets.dart';
import 'package:quizlen/constants/text_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/pages/main_pages/categories_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/color_constants.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void>? _launched;

  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {});
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch =
        Uri(scheme: 'https', host: 'turkiye.un.org', path: '/tr/sdgs');

    return Container(
      decoration: DecorationProperties.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.dynamicHeight(0.1),
              horizontal: context.dynamicWidth(0.1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ColorConstants.deepPurple,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: IconButton(
                          iconSize: 30,
                          color: Colors.white,
                          onPressed: () {
                            _launched = _launchInBrowser(toLaunch);
                          },
                          icon: Icon(
                            Icons.info_outline,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorConstants.deepPurple,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: IconButton(
                          iconSize: 30,
                          color: Colors.white,
                          onPressed: () {

                            _showDialog(context);








                          },
                          icon: Icon(

                            Icons.alternate_email,
                          ),
                        ),
                      ),
                    ],
                  )),
              Spacer(
                flex: 2,
              ),
              LogoImage(),
              Spacer(
                flex: 8,
              ),
              PlayButton(context),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded PlayButton(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(25),
            color: ColorConstants.mainOrange),
        child: MaterialButton(
          onPressed: () {




            Navigator.of(context).push(PageTransition(
                child: CategoriesPage(),
                type: PageTransitionType.rightToLeftWithFade,
                duration: Duration(milliseconds: 400),
                reverseDuration: Duration(milliseconds: 400)));




          },
          child:
              Text("OYNA", style: TextConstants.playButtonTextStyles(context)),
        ),
      ),
    );
  }

  Expanded LogoImage() {
    return Expanded(flex: 8, child: ReusableWidgets.getImageAsset("logo.png"));
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Takımımız Hakkında"),
            content: Text("Onurhan KAYA-Selçuk Üniversitesi 3.Sınıf\nKaan Güler-Kocaeli Üniversitesi 3.Sınıf\nDurmuş Cem Koca-Kocaeli Üniversitesi 3.Sınıf\nÇiğdem Bircan-Pamukkale Üniversitesi 3.Sınıf\nAvni Burak Çıtlak-Bilgi Üniversitesi 3.Sınıf"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Geri"),
                onPressed: () {
                  //Navigator.pushNamed(context, "/screen1");
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });}

}
