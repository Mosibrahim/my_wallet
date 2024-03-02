import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallet/home.dart';
import 'package:my_wallet/login_screen.dart';
import 'package:my_wallet/util/constants.dart';
import 'package:my_wallet/util/databaseUtils.dart';
import 'package:my_wallet/util/users_cubit/cubit.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  _setTargetPlatformForDesktop();
  DatabaseUtils.createUserTable();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<Cubit>(
        create: (context) => UsersCubit(),
     child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<UsersCubit>(create: (context)=>UsersCubit()..getUsersFromDB(),child: LoginScreen(),),
    ));
  }
}

void _setTargetPlatformForDesktop() {
  TargetPlatform? targetPlatform;

  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

Future<void> initData() async {
  await Parse().initialize(applicationId, serverUrl);
}
