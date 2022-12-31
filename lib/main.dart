import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:radio_ga/main_page.dart';
import 'navigation/navigation.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Almost Radio',
      theme:
          ThemeData(primarySwatch: Colors.blue, platform: TargetPlatform.iOS),
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        switch (settings.name) {
          case '/':
            return ExPageRoute(
              maintainState: true,
              settings: settings,
              builder: (context) => const MainPage(),
            );
        }
      },
      home: const MainPage(),
    );
  }
}
