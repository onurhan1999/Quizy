import 'package:flutter/material.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/extension/context_extension.dart';

void main() => runApp(const CategoriesPage());

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Kategoriler",style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white)),
      ),
        backgroundColor: Colors.deepPurple,
        body: Container(
          decoration: BoxDecoration(color: ColorConstants.mainPurple),
          child: Column(
            children: [
              Container(
                color: Colors.deepPurple,
                height: 74,
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 45,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.transparent)),
                        child: Column(
                          children: [
                            Image.asset("assets/images/tarih.png"),
                          ],
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.transparent)),
                        child: Image.asset("assets/images/tarih.png"),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.transparent)),
                        child: Image.asset("assets/images/tarih.png"),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.transparent)),
                        child: Image.asset("assets/images/tarih.png"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Kategori Adı",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              //Listview içerisindeki kategoriyle birlikte gelecek oyunlar
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                shadowColor: ColorConstants.mainOrange,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  height: 120,
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset("assets/images/logo.png"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: ListTile(
                                  title: Text("Quiz Adı"),
                                  subtitle: Text(
                                      "Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey"),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text("OYNA  "),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                ),
                elevation: 8,
                margin: const EdgeInsets.all(10),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: ColorConstants.mainOrange,
                      width: 2.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(35.0),
                ),
                shadowColor: ColorConstants.mainOrange,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  height: 120,
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset("assets/images/logo.png"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: ListTile(
                                  title: Text("Quiz Adı"),
                                  subtitle: Text(
                                      "Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey"),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text("OYNA  "),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                ),
                elevation: 8,
                margin: const EdgeInsets.all(10),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                shadowColor: ColorConstants.mainOrange,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  height: 120,
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset("assets/images/logo.png"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: ListTile(
                                  title: Text("Quiz Adı"),
                                  subtitle: Text(
                                      "Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey"),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text("OYNA  "),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                ),
                elevation: 8,
                margin: const EdgeInsets.all(10),
              ),
            ],
          ),
        ),
      );
  }
}
