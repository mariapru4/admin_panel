import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VendorFillterWidget extends StatelessWidget {
  const VendorFillterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionChip(
                elevation: 3,
                backgroundColor: Colors.black54,
                label: Text(
                  'All Vendors',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            ActionChip(
                elevation: 3,
                backgroundColor: Colors.black54,
                label: Text(
                  'Active',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            ActionChip(
                elevation: 3,
                backgroundColor: Colors.black54,
                label: Text(
                  'Inactive',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            ActionChip(
                elevation: 3,
                backgroundColor: Colors.black54,
                label: Text(
                  'Top Rated',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
