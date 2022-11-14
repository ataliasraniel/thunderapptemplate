import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/screens/home/components/pages/profile_page.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/core/user_manager.dart';

import '../../shared/constants/style_constants.dart';
import 'components/pages/favorite_page.dart';
import 'components/pages/home_page.dart';
import 'components/pages/curiosity_page.dart';
import 'components/pages/utility_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => HomeScreenController(),
      builder: (context, child) => Consumer<HomeScreenController>(
        builder: ((context, controller, child) => Scaffold(
              // floatingActionButton:
              //     FloatingActionButton(onPressed: () {
              //   print(GetIt.instance<UserManager>()
              //       .eggUser!
              //       .ratedRecipes);
              // }),
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Theme.of(context).cardColor,
                  selectedItemColor: kDetailColor,
                  unselectedItemColor: theme.textTheme.bodySmall!.color,
                  currentIndex: controller.currentPageIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: (page) {
                    controller.setPageIndex(page);
                  },
                  unselectedLabelStyle: kCaption2,
                  selectedLabelStyle: kCaption1,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
                    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Indicações'),
                    BottomNavigationBarItem(icon: Icon(Icons.travel_explore_rounded), label: 'Utilidades'),
                    BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Eventos'),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
                  ]),
              body: Container(
                padding: const EdgeInsets.only(top: kDefaultPadding + 28, left: kMediumSize, right: kMediumSize),
                width: size.width,
                height: size.height,
                child: IndexedStack(
                  index: controller.currentPageIndex,
                  children: [
                    HomePageOne(
                      controller: controller,
                    ),
                    FavoritePage(
                      controller: controller,
                    ),
                    UtilityPage(
                      navigatorKey: _navigatorKey,
                    ),
                    PageThree(
                      controller: controller,
                    ),
                    ProfilePage(
                      controller: controller,
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
