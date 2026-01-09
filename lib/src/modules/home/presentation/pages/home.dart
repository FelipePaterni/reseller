import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reseller/src/modules/home/presentation/widgets/dashboard_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              DashboardCard(
                crossAxisCellCount: 2,
                onClick: () {},
                icon: Icons.read_more,
                title: "aa",
                subtitle: "bb",
                value: "1",
              ),

              DashboardCard(
                crossAxisCellCount: 1,
                icon: Icons.read_more,
                title: "aa",
                subtitle: "bb",
                value: "1",
              ),
              DashboardCard(
                crossAxisCellCount: 1,
                icon: Icons.read_more,
                title: "aa",
                subtitle: "bb",
                value: "1",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
