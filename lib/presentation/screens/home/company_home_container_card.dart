import 'package:cargo_linker/core/ui.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';

class CompanyHomeScreenContainerCard extends StatelessWidget {
  final String containerId;
  final String type;
  final String size;
  final Map<String, dynamic> pickup;
  final Map<String, dynamic> drop;
  final String due;
  final Map<String, dynamic> dimension;
  final String price;
  const CompanyHomeScreenContainerCard(
      {super.key,
      required this.containerId,
      required this.type,
      required this.size,
      required this.pickup,
      required this.drop,
      required this.due,
      required this.dimension,
      required this.price});

  @override
  Widget build(BuildContext context) {
    DateTime dueDate = DateTime.parse(due).toLocal();
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Id: $containerId",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppThemes.light.primaryColor),
                      child: Text(
                        type,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Spacing(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppThemes.light.primaryColor),
                      child: Text(
                        "₹$price",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "Dimension: ${dimension["length"]} x ${dimension["width"]} x ${dimension["height"]} Feet",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            // Text("Pickup Location: $pickup"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ToggleButtons(
                  constraints:
                      const BoxConstraints(minWidth: 48, minHeight: 28),
                  textStyle: const TextStyle(fontSize: 14),
                  onPressed: (value) {},
                  isSelected: [size == "20", size == "30", size == "40"],
                  children: const [
                    Text("20 Ft"),
                    Text("30 Ft"),
                    Text("40 Ft"),
                  ],
                ),
                Text(
                  "${dueDate.day}/${dueDate.month}/${dueDate.year}",
                  style: TextStyle(
                      color: AppThemes.light.primaryColor, fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
