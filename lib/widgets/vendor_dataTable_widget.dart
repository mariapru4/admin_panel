import 'package:admin_panel/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VendorDataTable extends StatelessWidget {
  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            _services.vendors.orderBy('shopNmae', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went worng');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: DataTable(
                columnSpacing: 0,
                horizontalMargin: 50,

                showBottomBorder: true,
                dataRowHeight: 60,

                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: <DataColumn>[
                  DataColumn(label: Text('Active / Inactive')),
                  DataColumn(label: Text('Shop Name')),
                  DataColumn(label: Text('Rating')),
                  DataColumn(label: Text('Total Sales')),
                  DataColumn(label: Text('Mobile')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('View Details')),
                ],
                rows: vendorsDetailsRow(snapshot.data, _services),
                // rows: vendorsDetailsRow(snapshot.data!),
              ),
            ),
          );
        });
  }

  List<DataRow> vendorsDetailsRow(
      QuerySnapshot? snapshot, FirebaseServices services) {
    List<DataRow> newList = snapshot!.docs.map((DocumentSnapshot document) {
      return DataRow(cells: [
        DataCell(IconButton(
          onPressed: () {
            services.updateVendorStatus(
                id: document['uid'], status: document['accVerified']);
          },
          icon: document['accVerified']
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
        )),
        DataCell(Text(document['shopNmae'])),
        DataCell(Row(
          children: const [
            Icon(
              Icons.star,
              color: Colors.grey,
            ),
            Text("3.5")
          ],
        )),
        DataCell(Text("20,000")),
        DataCell(Text(document['mobile'])),
        DataCell(Text(document['email'])),
        DataCell(IconButton(
          icon: const Icon(Icons.remove_red_eye_outlined),
          onPressed: () {},
        ))
      ]);
    }).toList();
    return newList;
  }
}
