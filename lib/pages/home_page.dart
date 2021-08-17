import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_hivedb/boxes.dart';
import 'package:movie_app_hivedb/model/description.dart';
import 'package:movie_app_hivedb/provider/google_sign_in.dart';
import 'package:movie_app_hivedb/widgets/description_dialog.dart';
import 'package:movie_app_hivedb/widgets/logged_in_widget.dart';
import 'package:movie_app_hivedb/widgets/widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  // final String username;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Description> descriptions = [];

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   Hive.close();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              // IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (builder) => LoggedInWidget()));
              //     },
              //     icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
              SizedBox(
                width: 50,
              ),
              Text('Your Favorites'),
              SizedBox(width: 70),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //               builder: (builder) => LoggedInWidget()));
              //     },
              //     child: Text('Log Out', style: TextStyle(color: Colors.white)))
            ],
          ),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Description>>(
          valueListenable: Boxes.getDescriptions().listenable(),
          builder: (context, box, _) {
            final descriptions = box.values.toList().cast<Description>();

            return buildContent(descriptions);
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => DescriptionDialog(
              onClickedDone: addDescription,
            ),
          ),
        ),
      );

  Widget buildContent(List<Description> descriptions) {
    if (descriptions.isEmpty) {
      return SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              // Text('Logged in as '+ widget.username),
              SizedBox(
                height: 80,
              ),
              Image.asset('assets/load.gif'),
              SizedBox(
                height: 20,
              ),
              Text(
                'No movies yet!',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Add your movies by clicking the icon below.',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: descriptions.length,
              itemBuilder: (BuildContext context, int index) {
                final description = descriptions[index];

                return buildDescription(context, description);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildDescription(
    BuildContext context,
    Description description,
  ) {
    final color = description.isDesc ? Colors.red : Colors.green;
    final date = DateFormat.yMMMd().format(description.createdDate);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.network(
                  description.imgUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                        ),
                        Text(
                          description.name,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Directed By: ' + description.director,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            SizedBox(width: 110),
                            Text(
                              'Created on: ' + date,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            SizedBox(
                              height: 14,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                buildButtons(context, description)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget buildButtons(BuildContext context, Description description) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit', style: TextStyle(color: Colors.white)),
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DescriptionDialog(
                    description: description,
                    onClickedDone: (name, director, imgUrl, isDesc) =>
                        editDescription(
                            description, name, director, imgUrl, isDesc),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete', style: TextStyle(color: Colors.white)),
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () => deleteDescription(description),
            ),
          )
        ],
      );

  Future addDescription(
      String name, String director, String imgUrl, bool isDesc) async {
    final description = Description()
      ..name = name
      ..createdDate = DateTime.now()
      ..director = director
      ..imgUrl = imgUrl
      ..isDesc = isDesc;

    final box = Boxes.getDescriptions();
    box.add(description);
    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void editDescription(
    Description description,
    String name,
    String director,
    String imgUrl,
    bool isDesc,
  ) {
    description.name = name;
    description.director = director;
    description.imgUrl = imgUrl;
    description.isDesc = isDesc;

    // final box = Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    description.save();
  }

  void deleteDescription(Description description) {
    description.delete();
    //setState(() => transactions.remove(transaction));
  }
}

