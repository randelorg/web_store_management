import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NewSupplier extends StatefulWidget {
  @override
  _NewSupplier createState() => _NewSupplier();
}

class _NewSupplier extends State<NewSupplier> {
  var supplierName = new TextEditingController();
  var supplierMobile = new TextEditingController();
  var supplierWebiste = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Text(
            'New Supplier Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: HexColor("#155293"),
              fontFamily: 'Cairo_Bold',
              fontSize: 30,
              overflow: TextOverflow.fade,
            ),
            maxLines: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: TextField(
            controller: supplierName,
            decoration: InputDecoration(
              hintText: 'Supplier preffered name',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: TextField(
            controller: supplierMobile,
            decoration: InputDecoration(
              hintText: 'Mobile number',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: TextField(
            controller: supplierWebiste,
            decoration: InputDecoration(
              hintText: 'Website',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#155293"),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                      top: 18,
                      bottom: 18,
                      left: 36,
                      right: 36,
                    ),
                    primary: Colors.white,
                    textStyle: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 14,
                    ),
                  ),
                  child: const Text('ADD SUPPLIER'),
                  onPressed: () async {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
