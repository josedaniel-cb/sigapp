import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/auth/application/usecases.dart';
import 'package:sigapp/core/injection/get_it.dart';
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
      // GoRouter.of(context).go('/login');
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      // emit(SemesterPageViewState.error(e.toString()));
    }
  }

  @override
  bool get wantKeepAlive => true; // Mantiene la página en memoria

  @override
  Widget build(BuildContext context) {
    super.build(context); // Llamar al build del mixin
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
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
          CareerPage(),
          // StudentPage(),
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
            label: 'Semestre',
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
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Claro'),
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
      ),
    );
  }
}

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrera'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Malla Curricular'),
          ),
          ListTile(
            title: Text('Historial Académico'),
          ),
        ],
      ),
    );
  }
}
