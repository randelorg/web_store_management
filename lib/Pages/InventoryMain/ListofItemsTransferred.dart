import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Models/ProductTranferHistoryModel.dart';

class LisofItemsTransferred extends StatelessWidget {
  final List<ProductTransferHistoryModel> itemCodes;
  final String productname, branchDestination;

  const LisofItemsTransferred({
    required this.itemCodes,
    required this.productname,
    required this.branchDestination,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 60, right: 10, left: 10),
        child: Column(
          children: [
            Text(
              'Item code(s) that been transferred under product name',
              softWrap: true,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            Text(
              '$productname → $branchDestination',
              softWrap: true,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 20,
              ),
            ),
            Wrap(children: itemListTile()),
          ],
        ),
      ),
    );
  }

  List<ListTile> itemListTile() {
    return List.generate(itemCodes.length, (index) {
      return ListTile(
        leading: Icon(
          Icons.inventory_2,
          color: HexColor("#155293"),
        ),
        title: Text(
          itemCodes[index].getItemCode,
          style: TextStyle(
            color: HexColor("#155293"),
            fontFamily: 'Cairo_Bold',
            fontSize: 15,
          ),
        ),
        subtitle: Text('Item Code'),
      );
    });
  }
}
