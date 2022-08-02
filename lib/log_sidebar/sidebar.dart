// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:async';
import 'package:final_project_app/controller/language_controller.dart';
import 'package:final_project_app/log_sidebar/translater_btn.dart';
import 'package:final_project_app/sidebar/menu_item.dart';
import 'package:final_project_app/translations/local-keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../log_bloc.navigation_bloc/navigation_bloc.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamController<bool> isSidebarOpenedStreamcontroller;
  late StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamcontroller = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamcontroller.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamcontroller.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamcontroller.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    LanguageController controller = context.read<LanguageController>();
    final screenwidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsyc) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsyc.data! ? 0 : -screenwidth,
          right: isSideBarOpenedAsyc.data! ? 0 : screenwidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFF262AAA),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text(
                          LocaleKeys.side_welcome.tr(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w100),
                        ),
                        leading: const CircleAvatar(
                          child: Icon(
                            Icons.menu_open,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      ListTile(
                        title: Text(
                          LocaleKeys.language_head.tr(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      TransBtn(
                        icon: Icons.language_rounded,
                        title: "English",
                        onTap: () async {
                          onIconPressed();
                          await context.setLocale(const Locale('en'));
                          controller.onLanguageChanged();
                        },
                      ),
                      TransBtn(
                        icon: Icons.language_rounded,
                        title: "አማርኛ",
                        onTap: () async {
                          onIconPressed();
                          await context.setLocale(const Locale('pt'));
                          controller.onLanguageChanged();
                        },
                      ),
                      MenuItem1(
                        icon: Icons.language_rounded,
                        title: "Afan-Oromo",
                        onTap: () async {
                          onIconPressed();
                          await context.setLocale(const Locale('de'));
                          controller.onLanguageChanged();
                        },
                      ),
                      MenuItem1(
                        icon: Icons.language_rounded,
                        title: "Somali",
                        onTap: () async {
                          onIconPressed();
                          await context.setLocale(const Locale('fr'));
                          controller.onLanguageChanged();
                        },
                      ),
                      MenuItem1(
                        icon: Icons.language_rounded,
                        title: "ትግሪኛ",
                        onTap: () async {
                          onIconPressed();
                          await context.setLocale(const Locale('bg'));
                          controller.onLanguageChanged();
                        },
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem1(
                        icon: Icons.exit_to_app,
                        title: LocaleKeys.exit_btn.tr(),
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.RegistrationClickedEvent);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: const Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: const Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
