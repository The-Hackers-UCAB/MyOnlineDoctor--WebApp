//Package imports
import 'package:flutter/material.dart';

//Project imports
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';



//NavigatorServiceContract: Abstract class that manages the navigation of the app.
abstract class NavigatorServiceContract {

  static inject() => getIt.registerSingleton<NavigatorServiceContract>(_NavigatorService());  //Injector

  static NavigatorServiceContract get() => getIt<NavigatorServiceContract>(); //Getter

  late final GlobalKey<NavigatorState> navigatorKey; //Navigator Key

  //This method is used to navigate to a new page and add the page to the stack of pages.
  Future<T?> navigateToPage<T>(MaterialPageRoute<T> pageRoute);

  //This method is used to navigate to a new page and add the page to the stack of pages.
  Future<dynamic>? navigateTo(String routeName, {Object? arguments});

  //This method is used to navigate to a new page and add the page to the stack of pages, deleting the older stack.
  Future<dynamic>? navigateToWithReplacement(String routeName, {Object? arguments});

  //This method is used to navigate to a new page and add the page to the stack of pages, deleting the older stack.
  Future<T?> navigateToPageWithReplacement<T>(MaterialPageRoute<T> pageRoute);

  //This method is use to return to the first page of the stack of pages.
  void pop<T>([T? result]);
}



//This class is the implementation of the NavigatorServiceContract.
class _NavigatorService extends NavigatorServiceContract {
  late final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<T?> navigateToPage<T>(MaterialPageRoute<T> pageRoute) async {
    if (navigatorKey.currentState == null) {
      return null;
    }
    return navigatorKey.currentState?.push(pageRoute);
  }


  @override
  Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }


  @override
  Future<dynamic>? navigateToWithReplacement(String routeName, {Object? arguments}) {
    return navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }


  @override
  Future<T?> navigateToPageWithReplacement<T>(
      MaterialPageRoute<T> pageRoute) async {
    return navigatorKey.currentState?.pushReplacement(pageRoute);
  }


  @override
  void pop<T>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }
}