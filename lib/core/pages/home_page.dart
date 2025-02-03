import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/pages/home_page_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/schedule/schedule_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/schedule/schedule_page.dart';
import 'package:sigapp/student/infrastructure/pages/student_cubit.dart';
import 'package:sigapp/student/infrastructure/pages/student_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageStatefulWidgetState createState() => HomePageStatefulWidgetState();
}

class HomePageStatefulWidgetState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final cubit = BlocProvider.of<HomePageCubit>(context);
    return BlocConsumer<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: (() {
              switch (state.selectedIndex) {
                case 0:
                  return Text(
                    'Sigapp',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  );
                case 1:
                  return Text('Horario');
                case 2:
                  return Text('Carrera');
                case 3:
                  return Text('Estudiante');
                default:
                  return Container();
              }
            })(),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    cubit.logout();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Text('Cerrar sesión'),
                  ),
                ],
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) => cubit.changeTab(index),
            children: <Widget>[
              CoursesPage(),
              BlocProvider<ScheduleCubit>(
                create: (_) => getIt<ScheduleCubit>(),
                child: SchedulePage(),
              ),
              CareerPage(),
              BlocProvider<StudentPageViewCubit>(
                create: (_) => getIt<StudentPageViewCubit>(),
                child: StudentPageView(),
              ),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.book),
                label: 'Cursos',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today),
                label: 'Horario',
              ),
              NavigationDestination(
                icon: Icon(Icons.school),
                label: 'Carrera',
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Estudiante',
              ),
            ],
            selectedIndex: state.selectedIndex,
            onDestinationSelected: (index) => cubit.changeTab(index),
          ),
        );
      },
      listener: (context, state) {
        if (_pageController.page != state.selectedIndex) {
          _pageController.jumpToPage(state.selectedIndex);
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () => cubit.markErrorAsRead(),
              ),
            ),
          );
        }
      },
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Créditos: 32'),
            OutlinedButton(
              onPressed: () {},
              child: Row(
                children: [
                  const Text('2021-2'),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Malla Curricular'),
        ),
        ListTile(
          title: Text('Historial Académico'),
        ),
      ],
    );
  }
}
