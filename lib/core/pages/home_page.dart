import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/auth/application/usecases.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/courses/infrastructure/pages/schedule/schedule_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/schedule/schedule_page.dart';
import 'package:sigapp/student/infrastructure/pages/student_cubit.dart';
import 'package:sigapp/student/infrastructure/pages/student_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final AuthUsecases _authUsecases = getIt();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  _logout(BuildContext context) {
    try {
      _authUsecases.signOut.execute();
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: (() {
          switch (_selectedIndex) {
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
                _logout(context);
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
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          CoursesPage(),
          BlocProvider<ScheduleCubit>(
            create: (context) => getIt<ScheduleCubit>(),
            child: SchedulePage(),
          ),
          CareerPage(),
          BlocProvider<StudentPageViewCubit>(
            create: (context) => getIt<StudentPageViewCubit>(),
            child: StudentPageView(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Cursos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Horario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Carrera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Estudiante',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        // showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Horario'),
          onTap: () {
            GoRouter.of(context).push('/schedule');
          },
        ),
        ListTile(
          title: Text('Curso 2'),
        ),
        ListTile(
          title: Text('Curso 3'),
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
