import 'package:cargo_linker/core/ui.dart';
import 'package:cargo_linker/data/repositories/container_repository.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';

class ContainerCard extends StatelessWidget {
  final CompanyContainer container;
  const ContainerCard({
    super.key,
    required this.container,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dueDate = DateTime.parse(container.due).toLocal();
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
                  "Id: ${container.containerId}",
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
                        container.type,
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
                        "₹${container.price}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "Dimension: ${container.dimension["length"]} x ${container.dimension["width"]} x ${container.dimension["height"]} Feet",
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
                  isSelected: [container.size == "20", container.size == "30", container.size == "40"],
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
