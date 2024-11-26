import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jsondemo/api_screen.dart';
import 'package:jsondemo/fav_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(title: "Home"),
        "ApiScreen": (context) => ApiScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List decodedJson = [];

  @override
  void initState() {
    super.initState();

    rootBundle.loadString("data/dummy_dta.json").then((value) async {
      await Future.delayed(Duration(seconds: 2));
      decodedJson = jsonDecode(value);
      setState(() {});
    });
    // print("json ==> $json");
    log("json ==> $json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FavPage();
                  },
                ));
              },
              icon: Icon(Icons.star))
        ],
      ),
      body: decodedJson.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                Map<String, dynamic> item = decodedJson[index];
                return ListTile(
                  title: Text("${item['name']}"),
                  subtitle: Text("${item['language']}"),
                  onTap: () {
                    var stringJson = jsonEncode(item);
                    List<String> favList = prefs.getStringList('fav') ?? [];
                    favList.add(stringJson);
                    prefs.setStringList("fav", favList);
                  },
                  // trailing:
                  //     Icon(item["is_active"] == true ? Icons.check : Icons.close),
                );
              },
              itemCount: decodedJson.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // String json =
          //     "[{\"id\":4,\"first_name\":\"Emily\",\"last_name\":\"Davis\",\"email\":\"emily.davis@example.com\",\"username\":\"emilydavis\",\"phone\":\"+1230987654\",\"address\":{\"street\":\"321MapleRd\",\"city\":\"SanFrancisco\",\"state\":\"CA\",\"zip\":\"94105\"},\"is_active\":true,\"created_at\":\"2024-03-12T14:22:00Z\",\"last_login\":\"2024-11-18T08:40:00Z\"},{\"id\":5,\"first_name\":\"David\",\"last_name\":\"Martinez\",\"email\":\"david.martinez@example.com\",\"username\":\"davemart\",\"phone\":\"+1987456123\",\"address\":{\"street\":\"101BirchSt\",\"city\":\"Seattle\",\"state\":\"WA\",\"zip\":\"98101\"},\"is_active\":false,\"created_at\":\"2023-09-23T16:30:00Z\",\"last_login\":\"2024-10-05T11:50:00Z\"},{\"id\":6,\"first_name\":\"Olivia\",\"last_name\":\"Taylor\",\"email\":\"olivia.taylor@example.com\",\"username\":\"oliviat123\",\"phone\":\"+1122339988\",\"address\":{\"street\":\"202CedarLn\",\"city\":\"Austin\",\"state\":\"TX\",\"zip\":\"73301\"},\"is_active\":true,\"created_at\":\"2023-02-09T09:45:00Z\",\"last_login\":\"2024-11-15T18:05:00Z\"},{\"id\":7,\"first_name\":\"James\",\"last_name\":\"Wilson\",\"email\":\"james.wilson@example.com\",\"username\":\"jamesw\",\"phone\":\"+1345678901\",\"address\":{\"street\":\"303OakSt\",\"city\":\"Denver\",\"state\":\"CO\",\"zip\":\"80202\"},\"is_active\":true,\"created_at\":\"2021-07-01T10:00:00Z\",\"last_login\":\"2024-11-16T19:15:00Z\"},{\"id\":8,\"first_name\":\"Sophia\",\"last_name\":\"Lee\",\"email\":\"sophia.lee@example.com\",\"username\":\"sophialee\",\"phone\":\"+1456781234\",\"address\":{\"street\":\"404WillowAve\",\"city\":\"Portland\",\"state\":\"OR\",\"zip\":\"97201\"},\"is_active\":false,\"created_at\":\"2020-11-21T15:30:00Z\",\"last_login\":\"2023-05-12T13:00:00Z\"},{\"id\":9,\"first_name\":\"Benjamin\",\"last_name\":\"Harris\",\"email\":\"benjamin.harris@example.com\",\"username\":\"ben_harris\",\"phone\":\"+1567890123\",\"address\":{\"street\":\"505PineSt\",\"city\":\"Miami\",\"state\":\"FL\",\"zip\":\"33101\"},\"is_active\":true,\"created_at\":\"2023-12-02T11:00:00Z\",\"last_login\":\"2024-11-17T20:25:00Z\"},{\"id\":10,\"first_name\":\"Charlotte\",\"last_name\":\"Garcia\",\"email\":\"charlotte.garcia@example.com\",\"username\":\"charlotteg\",\"phone\":\"+1678901234\",\"address\":{\"street\":\"606RedwoodDr\",\"city\":\"Phoenix\",\"state\":\"AZ\",\"zip\":\"85001\"},\"is_active\":true,\"created_at\":\"2023-04-19T17:40:00Z\",\"last_login\":\"2024-11-18T07:30:00Z\"},{\"id\":11,\"first_name\":\"Lucas\",\"last_name\":\"Lopez\",\"email\":\"lucas.lopez@example.com\",\"username\":\"lucaslopez\",\"phone\":\"+1789456123\",\"address\":{\"street\":\"707SpruceAve\",\"city\":\"Boston\",\"state\":\"MA\",\"zip\":\"02108\"},\"is_active\":true,\"created_at\":\"2022-06-14T14:05:00Z\",\"last_login\":\"2024-11-10T22:00:00Z\"},{\"id\":12,\"first_name\":\"Amelia\",\"last_name\":\"Martins\",\"email\":\"amelia.martins@example.com\",\"username\":\"amelia_m\",\"phone\":\"+1896543210\",\"address\":{\"street\":\"808CedarSt\",\"city\":\"SanDiego\",\"state\":\"CA\",\"zip\":\"92101\"},\"is_active\":true,\"created_at\":\"2024-01-29T16:00:00Z\",\"last_login\":\"2024-11-11T08:15:00Z\"},{\"id\":13,\"first_name\":\"Henry\",\"last_name\":\"Jackson\",\"email\":\"henry.jackson@example.com\",\"username\":\"henryjackson\",\"phone\":\"+1234987654\",\"address\":{\"street\":\"909BirchRd\",\"city\":\"LasVegas\",\"state\":\"NV\",\"zip\":\"89101\"},\"is_active\":false,\"created_at\":\"2020-09-30T13:10:00Z\",\"last_login\":\"2024-05-08T12:25:00Z\"}]";
          //
          // decodedJson = jsonDecode(json);
          // setState(() {});
          // print("decodedJson ${decodedJson[0]["email"]}");
          // jsonEncode();

          Navigator.pushNamed(context, "ApiScreen");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
