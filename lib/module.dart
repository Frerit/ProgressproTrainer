import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trainer/app/activity/module.dart';
import 'package:trainer/app/home/presenter/module.dart';
import 'package:trainer/app/init/_children/onboarding/page/onboarding_page.dart';
import 'package:trainer/app/init/_children/sign_in/presenter/bloc/sign_in_bloc.dart';
import 'package:trainer/app/init/_children/sign_in/presenter/page/sign_in_page.dart';
import 'package:trainer/app/init/_children/sign_pass/presenter/bloc/sign_password_bloc.dart';
import 'package:trainer/app/init/_children/sign_pass/presenter/page/sign_pasword_page.dart';
import 'package:trainer/app/init/_children/sign_user/presenter/bloc/sign_user_bloc.dart';
import 'package:trainer/app/init/_children/started/presenter/page/get_starter_page.dart';
import 'package:trainer/app/init/data/repository.dart';
import 'package:trainer/app/init/module.dart';
import 'package:trainer/app/init/presenter/bloc/auth_bloc.dart';
import 'package:trainer/app/init/presenter/page/page.dart';
import 'package:trainer/global/init/app_config.dart';

class AppModule extends Module {
  static const String getStarted = "/get_started";
  static const String onboardingRoute = "/onboarding";
  static const String signInRoute = "/sign_in";
  static const String signPassRoute = "/sign_passw";
  static const String signUpRoute = RegisterModule.signUpRoute;
  static const String homeRoute = HomeModule.getHome;

  @override
  void binds(Injector i) {
    i.addInstance(AppConfig(name: "ProgressPro"));
    i.addInstance(Supabase.instance.client);

    i.add(AuthRepository.new);
    i.addSingleton(AuthBloc.new);
    i.addSingleton(SignInBloc.new);
    i.addSingleton(SignPasswordBloc.new);
    i.addSingleton(SignUserBloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const InitPage());
    r.child(
      getStarted,
      transition: TransitionType.fadeIn,
      child: (context) => const GetStarterPage(),
    );
    r.child(
      onboardingRoute,
      transition: TransitionType.fadeIn,
      child: (context) => const OnboardingPage(),
    );
    r.child(
      signInRoute,
      transition: TransitionType.rightToLeft,
      child: (context) => const SignInPage(),
    );
    r.child(
      signPassRoute,
      transition: TransitionType.rightToLeft,
      child: (context) => SignPasswordPage(exist: r.args.data),
    );
    // MODULES
    r.module(
      RegisterModule.signUpRoute,
      module: RegisterModule(),
    );
    r.module(
      HomeModule.getHome,
      module: HomeModule(),
    );

    r.module(
      ActivityModule.newGroupRoute,
      module: ActivityModule(),
    );
  }
}
