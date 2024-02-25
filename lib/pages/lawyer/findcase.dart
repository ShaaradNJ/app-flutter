import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class findcase extends StatefulWidget {
  @override
  State<findcase> createState() => _findcaseState();
}

class _findcaseState extends State<findcase> {
  List<Widget> cases = [];

  @override
  void initState(){
    super.initState();
    setcases();
  }

  Future setcases() async{
    List<Widget> caseWidgets = await getcases();
    setState(() {
      cases = caseWidgets;
    });
  }

  Future<List<Widget>> getcases() async{
    List<Widget> cases = [];
    var query = await FirebaseFirestore.instance.collection("Registerted_Cases(non-assigned)").get();
    for (var doc in query.docs){
      QuerySnapshot feed = await FirebaseFirestore.instance.collection("Registerted_Cases(non-assigned)").doc(doc.id).collection("Cases").get();
      for (var casesdoc in feed.docs){
        // print(casesdoc["caseType"]);
        ListTile tile = ListTile(
          title: Text(casesdoc["caseType"]),
        );
        cases.add(tile);
      }
    }
    return cases;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[100],
        title: const Text("Find a Case"),
      ),
      body: SafeArea(
          child: ListView.builder(
            itemCount: cases.length,
              itemBuilder: (context,index){
              return cases[index];
              }),
      ),
    );
  }
}