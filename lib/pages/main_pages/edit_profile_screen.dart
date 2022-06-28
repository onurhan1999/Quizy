import 'package:flutter/material.dart';
import 'package:quizlen/extension/context_extension.dart';

import '../../components/reusable_widgets.dart';

void main() => runApp(EditProfile());

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Color(0xffE1CCEC),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Profil',
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.dynamicHeight(0.05)),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ReusableWidgets.getImageAsset("avatar.png"),
                radius: 75,
              ),
            ),
            Text(
              "nickname",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Color(0xff5E5F5E)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: context.dynamicHeight(0.03)),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40)),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: context.dynamicWidth(0.1),
                        right: context.dynamicWidth(0.1),
                        top: context.dynamicHeight(0.03)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Favori",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "Kategori",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Favori",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "Kategori",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Favori",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "Kategori",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              //yazılar
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff26CE55),
                                child: ReusableWidgets.getImageAsset("tarih.png"),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff00B2FF),
                                child: Text("3.5b",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),
                              ),
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xffFF0000),
                                child: Text("%70",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),


                        ),

                            ],
                          ),
                        ),
                        Divider(height: 5, thickness: 3),
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.dynamicHeight(0.02),
                              left: 10,
                              right: 10,
                              bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Avatar Seç",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.arrow_forward_ios))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Şifre Değiştir",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.arrow_forward_ios))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 5,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Çıkış Yap",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                                iconSize: 35,
                                onPressed: () {},
                                icon: Icon(Icons.exit_to_app))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
