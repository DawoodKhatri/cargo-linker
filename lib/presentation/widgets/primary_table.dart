import 'package:flutter/material.dart';

class PrimaryTable extends StatelessWidget {
  final Map<String, dynamic> tableData;
  const PrimaryTable({super.key, required this.tableData});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: tableData.entries.map(
        (entry) => TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                entry.key,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                entry.value,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            )
          ],
        ),
      ).toList()
    );
  }
}
