import 'package:flutter/material.dart';

import 'secondPage.dart';

void main() {
  runApp(MyApp());
}

final rootScaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldKey,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyKey(),
    );
  }
}

class MyKey extends StatelessWidget {
  final counterKey = GlobalKey<_CounterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global key'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            ElevatedButton(
                child: Text('기존방식 snackbar 이용'),
                onPressed: () {
                  const snackbar = SnackBar(
                    content: Text('Hello, 스낵바!'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }),
            SizedBox(height: 50),
            Counter(
              key: counterKey,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.mouse),
        onPressed: () {
          var snackBar = SnackBar(
            content: Text('새로운 globalkey 방식 스넥바'),
            duration: Duration(seconds: 5),
            action: SnackBarAction(
              label: '두번째 페이지로 이동',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(),
                    ));
              },
            ),
          );
          rootScaffoldKey.currentState!.showSnackBar(snackBar);
        },
        // child: Icon(
        //   Icons.add,
        //   color: Colors.white,
        // ),
        // onPressed: () {
        //   counterKey.currentState!.increment();
        //   print(counterKey.currentState!.count);
        // },
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Count number: $count',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
