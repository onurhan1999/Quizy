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
      decoration: DecorationProperties.mainScreenBackgroundDecoration,
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
                        width: 55,
                        height: 40,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                spreadRadius: 3,
                                blurRadius: 5.0,
                                offset: Offset(
                                    0.0, 3.0), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xff595CFF)),
                        child: IconButton(
                          iconSize: 20,
                          color: Color(0xff14154F),
                          onPressed: () {
                            _launched = _launchInBrowser(toLaunch);
                          },
                          icon: Text(
                            "i",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      Container(
                        width: 55,
                        height: 40,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                spreadRadius: 3,
                                blurRadius: 5.0,
                                offset: Offset(
                                    0.0, 3.0), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xff595CFF)),
                        child: IconButton(
                          iconSize: 20,
                          color: Color(0xff14154F),
                          onPressed: () {
                            _showDialog(context);
                          },
                          icon: Icon(
                            Icons.account_circle_sharp,
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
                color: Colors.black.withOpacity(0.40),
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
    return Expanded(
        flex: 9, child: ReusableWidgets.getImageAsset("logo_shadow.png"));
  }

  _showDialog(BuildContext context) {

    return showDialog(

        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),

            backgroundColor: Color(0xff14154F),
            title: Column(
              children: [
                new Text("Takımımız",style: GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.headline4,color: Color(0xff595CFF),fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                Divider(height: 2,thickness: 2,color: Color(0xff595CFF),)
              ],
            ),
            content: Text(
                "Onurhan KAYA\nSelçuk Üniversitesi 3.Sınıf\n\nKaan Güler\nKocaeli Üniversitesi 3.Sınıf\n\nDurmuş Cem Koca\nKocaeli Üniversitesi 4.Sınıf\n\nÇiğdem Bircan\nPamukkale Üniversitesi 4.Sınıf\n\nAvni Burak Çıtlak\nBilgi Üniversitesi 4.Sınıf",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            actions: <Widget>[

              new FlatButton(
                child: new Text("Geri",style: TextStyle(color: Color(0xff00B2FF),fontSize: 20),),
                onPressed: () {
                  //Navigator.pushNamed(context, "/screen1");
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
