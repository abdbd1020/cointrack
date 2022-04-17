import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe/pages/homePage.dart';
import 'package:swe/pages/loginPage.dart';

typedef RouterMethod = PageRoute Function(RouteSettings, Map<String, String>);

/*
* Page builder methods
*
*/
final Map<String, RouterMethod> _definitions = {
  '/': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return HomePage();
      },
    );
  },
  '/login': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return  LoginPage();
      },
    );
  },


  '/main': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return HomePage();
      },
    );
  },

};



Map<String, String> _buildParams(String key, String name) {
  final uri = Uri.parse(key);
  final path = uri.pathSegments;
  final params = Map<String, String>.from(uri.queryParameters);

  final instance = Uri.parse(name).pathSegments;
  if (instance.length != path.length) {
    return null;
  }

  for (int i = 0; i < instance.length; ++i) {
    if (path[i] == '*') {
      break;
    } else if (path[i][0] == ':') {
      params[path[i].substring(1)] = instance[i];
    } else if (path[i] != instance[i]) {
      return null;
    }
  }
  return params;
}

Route buildRouter(RouteSettings settings) {
  for (final entry in _definitions.entries) {
    final params = _buildParams(entry.key, settings.name);
    if (params != null) {
      print('Visiting: ${settings.name} as ${entry.key}');
      return entry.value(settings, params);
    }
  }

  print('<!> Not recognized: ${settings.name}');
  return FadeInRoute(
    settings: settings,
    builder: (_) {
      return Scaffold(
        body: Center(
          child: Text(
            '"${settings.name}"\nYou should not be here!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey[600],
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
    },
  );
}


class FadeInRoute<T> extends MaterialPageRoute<T> {
  bool disableAnimation;

  FadeInRoute({
    WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    this.disableAnimation = false,
  }) : super(
    settings: settings,
    builder: builder,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (this.disableAnimation) return child;
    return FadeTransition(opacity: animation, child: child);
  }
}


