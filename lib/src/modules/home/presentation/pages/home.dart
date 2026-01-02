import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reseller/src/modules/home/presentation/widgets/dashboard_card.dart';

class Home extends StatelessWidget {
  const Home({super.key, teste});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 1,
          children: [
            StaggeredGridTile.fit(
              crossAxisCellCount: 2,
              child: DashboardCard(
                icon: Icons.read_more,
                title: "aa",
                subtitle: "bb",
                value: "1",
              ),
            ),
            StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: DashboardCard(
                icon: Icons.read_more,
                title: "aa",
                subtitle: "bb",
                value: "1",
              ),
            ),
            StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: DashboardCard(
                icon: Icons.read_more,
                title: "aa",
                subtitle: "bb",
                value: "1",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
