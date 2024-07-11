import 'package:akutibu/controller/akutibu_controller.dart';
import 'package:akutibu/pages/home_page.dart';
import 'package:akutibu/pages/rule_page.dart';
import 'package:akutibu/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final lightTokens = MoonTokens.light.copyWith(
      typography: MoonTypography.typography.copyWith(
        heading: MoonTypography.typography.heading.apply(fontFamily: "DMSans"),
      ),
    );

    final lightTheme = ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[MoonTheme(tokens: lightTokens)],
    );

    final darkTokens = MoonTokens.dark.copyWith(
      typography: MoonTypography.typography.copyWith(
        heading: MoonTypography.typography.heading.apply(fontFamily: "DMSans"),
      ),
    );
    final darkTheme = ThemeData.dark().copyWith(
      extensions: <ThemeExtension<dynamic>>[MoonTheme(tokens: darkTokens)],
    );
    return MaterialApp(
      title: 'Akutibu',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  final _pages = const [
    HomePage(),
    RulePage(),
    SettingsPage(),
  ];

  final List<Map<String, dynamic>> _navs = [
    {
      'icon': MoonIcons.generic_home_16_light,
      'lable': "Home",
    },
    {
      'icon': MoonIcons.files_add_16_light,
      'lable': 'Rule',
    },
    {
      'icon': MoonIcons.generic_settings_16_light,
      'lable': "Settings",
    }
  ];

  handleIndex(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            if (constraints.maxWidth > 700)
              SizedBox(
                width: 200,
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    for (int index = 0; index < _navs.length; index++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: MoonMenuItem(
                          onTap: () => handleIndex(index),
                          leading: Icon(_navs[index]['icon']),
                          label: Text(_navs[index]['lable']),
                          backgroundColor: _index == index
                              ? context
                                  .moonTheme?.menuItemTheme.colors.dividerColor
                              : null,
                        ),
                      ),
                  ],
                ),
              ),
            Expanded(
              // 保存状态
              child: ChangeNotifierProvider(
                create: (context) => AkutibuController(),
                child: IndexedStack(
                  index: _index,
                  children: _pages,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
