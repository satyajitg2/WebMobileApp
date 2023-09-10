import 'dart:convert';

import 'package:complete/http_api/rows.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'model/user_model.dart';

const String DB_REST_URL =
    'be420919-f9f0-4654-a712-d47513bce79f-asia-south1.apps.astra.datastax.com';
const String DB_REST_URL_API_PATH =
    '/api/rest/v2/keyspaces/stargate/satyajit_table/rows';

const String full_url =
    'https://be420919-f9f0-4654-a712-d47513bce79f-asia-south1.apps.astra.datastax.com/api/rest/v2/keyspaces/stargate/satyajit_table/rows';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Rows> _rowsData;

  @override
  void initState() {
    super.initState();
    print('HOMESCREEN - initState()');
    _rowsData = fetchRows();
  }

  Future<Rows> fetchRows() async {
    //Future<http.Response> response;
    print('HOMESCREEN - fetchRows');
    Map<String, String>? headervars = {
      "Content-type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      "X-Cassandra-Token": "Secret"
    };

    final uri = Uri.https(DB_REST_URL, DB_REST_URL_API_PATH);

    print('Parsed well');

    Response responseTest = new Response('body', 400);
    bool isMatch = false;
    try {
      //NOTE: This call fails in Chrome device but works in Linux device.
      //To Run on Chrome do these steps below along with header to access-allow-control
      //1- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
      //2- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
      //3- Find '--disable-extensions'
      //4- Add '--disable-web-security'

      responseTest = await http.get(uri, headers: headervars);
      //final body = responseTest.body;

      print('Body ' +
          responseTest.body +
          ' Status Code' +
          responseTest.statusCode.toString());
      isMatch = (responseTest.statusCode == 200);
      print('StatusCode matches ' + isMatch.toString());
    } on Exception catch (e) {
      print('Exception while http.get' + e.toString());
    }
    if (isMatch) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('HOMESCREEN - fetchRows - response statusCode 200' +
          responseTest.body);
      return Rows.fromJson(jsonDecode(responseTest.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('HOMESCREEN - fetchRows - failed to load');
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<ProfileScreen>(
                    builder: (context) => ProfileScreen(
                      appBar: AppBar(
                        title: const Text('User Profile'),
                      ),
                      actions: [
                        SignedOutAction((context) {
                          Navigator.of(context).pop();
                        })
                      ],
                      children: [
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Image.asset('flutterfire_300x.png'),
                        )
                      ],
                    ),
                  ));
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('dash.png'),
            Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(64),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(children: <Widget>[
                  Consumer<UserModel>(
                    builder: (context, value, child) => Text(
                      'Hello ${value.user.displayName} ${value.user.email}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  )
                ])
              ],
            ),
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SignOutButton()
          ],
        ),
      ),
    );
  }
}
