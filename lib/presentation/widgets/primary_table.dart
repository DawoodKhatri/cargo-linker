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
                style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                entry.value,
                style: TextStyle( fontSize: 20),
              ),
            )
          ],
        ),
      ).toList()
    );
  }
}
