import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/shared/infrastructure/partials/user_avatar_button.dart';

class CareerPageView extends StatefulWidget {
  const CareerPageView({super.key});

  @override
  State<CareerPageView> createState() => _CareerPageViewState();
}

class _CareerPageViewState extends State<CareerPageView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Carrera'),
            UserAvatarButtonWidget(),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(MdiIcons.notebookOutline),
              text: 'Plan de estudios',
            ),
            Tab(
              icon: Icon(MdiIcons.fileChartOutline),
              text: 'Historial académico',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('Malla Curricular'),
              ),
              ListTile(
                title: Text('Historial Académico'),
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('Malla Curricular'),
              ),
              ListTile(
                title: Text('Historial Académico'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
