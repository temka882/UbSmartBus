import 'package:flutter_application_1/consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: appname,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeController.themeMode,
          translations: AppTranslations(), // 🌐 Add translations
          locale: Get.deviceLocale, // Use system locale by default
          fallbackLocale: const Locale('en', 'US'),
          home: const SplashScreen(),
        ));
  }
}
