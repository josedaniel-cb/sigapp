import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/ui/pages/home_page_cubit.dart';
import 'package:sigapp/core/ui/partials/user_avatar_button.dart';
import 'package:sigapp/courses/infrastructure/pages/career/career_page.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page_cubit.dart';
import 'package:sigapp/student/infrastructure/pages/student_cubit.dart';
import 'package:sigapp/student/infrastructure/pages/student_page_view.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  HomePageWidgetState createState() => HomePageWidgetState();
}

class HomePageWidgetState extends State<HomePageWidget>
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
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(), // Locks the swipe
            onPageChanged: (index) => cubit.changeTab(index),
            children: <Widget>[
              BlocProvider(
                create: (_) => getIt<CoursesPageCubit>(),
                child: CoursesPageWidget(
                  appBarTrailing: UserAvatarButtonWidget(),
                ),
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
                icon: Icon(Icons.assignment_rounded),
                label: 'Semestre',
              ),
              // NavigationDestination(
              //   icon: Icon(Icons.calendar_today),
              //   label: 'Horario',
              // ),
              NavigationDestination(
                icon: Icon(Icons.school),
                label: 'Carrera',
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Estudiante',
              ),
            ],
            selectedIndex: state.selectedTabIndex,
            onDestinationSelected: (index) => cubit.changeTab(index),
          ),
        );
      },
      listener: (context, state) {
        if (_pageController.hasClients &&
            _pageController.page != state.selectedTabIndex) {
          _pageController.animateToPage(
            state.selectedTabIndex,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
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
