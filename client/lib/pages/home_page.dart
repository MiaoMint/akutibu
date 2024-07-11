import 'dart:convert';
import 'package:akutibu/controller/akutibu_controller.dart';

import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Consumer<AkutibuController>(
          builder: (context, value, child) {
            final activeWindow = value.activeWindow;
            if (!value.isRunning) {
              if (value.apiUrl.isEmpty || value.secretKey.isEmpty) {
                return const Center(
                  child: Text(
                    'Please set the API URL and Secret Key',
                  ),
                );
              }
              return Center(
                child: MoonButton.icon(
                  onTap: value.start,
                  icon: const Icon(
                    MoonIcons.media_play_16_light,
                    size: 30,
                  ),
                  buttonSize: MoonButtonSize.lg,
                  backgroundColor: context.moonTheme?.buttonTheme.colors
                      .filledVariantBackgroundColor,
                ),
              );
            }
            if (activeWindow == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.memory(
                  base64Decode(
                    (activeWindow['icon'] as String)
                        .replaceFirst("data:image/png;base64,", ''),
                  ),
                  width: 100,
                  height: 100,
                ),
                Text(
                  '${activeWindow['name']}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(8),
                  child: SelectableText(
                    'path: ${activeWindow['path']}',
                    textAlign: TextAlign.center,
                  ),
                ),
                SelectableText(
                  'window: ${activeWindow['title']}',
                ),
                SelectableText(
                  'pid: ${activeWindow['pid']}',
                ),
                const SizedBox(height: 8),
                MoonButton.icon(
                  onTap: value.stop,
                  icon: const Icon(
                    MoonIcons.media_stop_16_light,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
