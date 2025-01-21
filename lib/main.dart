import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_firestore/firebase_options.dart';
import 'package:firebase_firestore/student.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zohaib App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Feature Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  void _incrementCounter() async {
    Student student = Student(name: 'Khurram', rollNo: 23, fee: 12000);
    var collection = FirebaseFirestore.instance.collection('Students');
    // Auto Generated Id
    // Upload
    // collection.add(student.toMap());

    // Fetch
    // var querySnapshot = await collection.where('rollNo' , isEqualTo: 23).get();
    // if(querySnapshot.docs.isNotEmpty){
    //   var students = querySnapshot.docs.map((e) => Student.fromMap(e.data()),).toList();
    //   student = students.first;
    // }

    // Update
    var querySnapshot = await collection.where('rollNo', isEqualTo: 23).get();
    if (querySnapshot.docs.isNotEmpty) {
      if (querySnapshot.docs.length == 1) {
        var docRef = querySnapshot.docs.first;
        collection.doc(docRef.id).delete();
      } else {
        var id = querySnapshot.docs
            .where(
              (element) => element.data()['fee'] == 12000,
            )
            .first
            .id;
        collection.doc(id).delete();
      }
    }

    collection
        .where('rollNo', isEqualTo: 23)
        .where('fee', isEqualTo: 12000)
        .where('name', isEqualTo: 'Khurram')
        .get();

    // Manual Id
    // Upload
    // collection.doc('12').set(student.toMap());

    // Fetch
    //  var docSnapshot = await collection.doc('12').get();
    //  if(docSnapshot.data() != null){
    //   student = Student.fromMap(docSnapshot.data() ?? {});
    //  }

    // Update
    // collection.doc('12').set({'fee' : 13000} , SetOptions(merge: true));

    // Delete
    // await collection.doc('12').delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
