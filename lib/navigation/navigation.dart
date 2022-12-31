import 'package:flutter/material.dart';

import '../style.dart';

class Navigation {
  static void goTo(
      {required BuildContext context,
      required Widget page,
      PageRoute Function(Widget)? route}) {
    Navigator.of(context).push(
      route != null
          ? route(page)
          : MaterialPageRoute(
              builder: (_) => page,
            ),
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void popToRoot(BuildContext context) {
    while (Navigator.of(context).canPop()) {
      Navigation.pop(context);
    }
  }
}

class ExPageRoute<T> extends MaterialPageRoute<T> {
  ExPageRoute(
      {required WidgetBuilder builder,
      required RouteSettings settings,
      bool? maintainState})
      : super(
            builder: builder,
            settings: settings,
            maintainState: maintainState ?? true);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class SimpleRoute extends PageRouteBuilder {
  SimpleRoute(
      {required Widget page,
      bool vertical = false,
      required settings,
      required maintainState})
      : super(
          transitionDuration: Style.transitionDuration,
          settings: settings,
          maintainState: maintainState,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final begin = vertical ? const Offset(0.0, 1) : const Offset(1, 0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
