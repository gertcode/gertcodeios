import 'package:go_router/go_router.dart';
import 'package:iospush/presentation/screens/notifications_page.dart';



final appRouter = GoRouter(routes: [
  /*GoRoute(
    path: '/',
    builder: (context, state) => const MenuPage(),
  ),*/
  GoRoute(
    path: '/',
    builder: (context, state) => const NotificationsPage(),
  ),
]);
