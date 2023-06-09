import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddVehicle extends StatefulWidget {
  final int vehicle;
  const AddVehicle(this.vehicle, {super.key});
  @override
  AddVehicleState createState() => AddVehicleState();
}

class AddVehicleState extends State<AddVehicle> {
  List<String> iconVehicle = [
    'bike',
    'car',
  ];

  final _vehicleName = TextEditingController();
  final _vehicleNo = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void addDataToFirestore() {
    final String name = _vehicleName.text;
    final String no = _vehicleNo.text;
    if (name.isNotEmpty && no.isNotEmpty) {
      _db.collection('vehicles').add({
        'type': (widget.vehicle == 0 ? 'bike' : 'car'),
        'uid': FirebaseAuth.instance.currentUser?.uid,
        'name': name,
        'vehicle_no': no,
      });
      _vehicleName.clear();
      _vehicleNo.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Vehicle'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: Image.asset(
                      'assets/images/${iconVehicle[widget.vehicle]}.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
              child: TextField(
                controller: _vehicleName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Vehicle Name',
                    hintText: 'Enter name of your vehicle'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
              child: TextField(
                controller: _vehicleNo,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Vehicle Number',
                    hintText: 'Enter your vehicle number'),
              ),
            ),
            Container(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      addDataToFirestore();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
