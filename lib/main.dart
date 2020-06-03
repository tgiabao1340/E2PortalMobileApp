import 'package:bloc/bloc.dart';
import 'package:e2portal/api/repository/api_auth_repository.dart';
import 'package:e2portal/bloc/blocs.dart';
import 'package:e2portal/injector/injector.dart';
import 'package:e2portal/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  try {

    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    await GlobalConfiguration().loadFromAsset('config.json');
    BlocSupervisor.delegate = SimpleBlocDelegate();
    final ApiAuthRepository apiAuthRepository = ApiAuthRepository();
    runApp(
      BlocProvider<AuthenticationBloc>(
        create: (context){
          return AuthenticationBloc(apiAuthRepository: apiAuthRepository)..add(AppStarted());
        },
        child: MyApp(),
      )
    );
  } catch (error, stacktrace) {
    print('$error & $stacktrace');
  }
}

class MyApp extends StatefulWidget {
  final ApiAuthRepository apiAuthRepository;

  const MyApp({Key key, this.apiAuthRepository}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E2PORTAL',
      onGenerateRoute: Router.generateRoute,
      initialRoute: initRoute,

    );
  }
}
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }

}
