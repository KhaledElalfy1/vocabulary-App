import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vocabulary_app/constants.dart';
import 'package:vocabulary_app/cubits/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/cubits/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/model/word_type_adapter.dart';
import 'package:vocabulary_app/view/screens/home.dart';
import 'package:vocabulary_app/view/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  await Hive.openBox(Constants.wordBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => WriteDataCubit(),),
      BlocProvider(create: (context) => ReadDataCubit()..getWords(),),
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getAppTheme(),
      home:const HomeScreen(),
    ),);
  }

}
