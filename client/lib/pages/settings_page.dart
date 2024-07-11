import 'package:akutibu/controller/akutibu_controller.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          "Akutibu API",
          style: context.moonTypography?.heading.text16,
        ),
        const SizedBox(height: 16),
        Form(
          child: Builder(
            builder: (context) {
              final ankutibuController =
                  Provider.of<AkutibuController>(context);
              return Column(
                children: [
                  MoonTextInputGroup(
                    children: [
                      MoonFormTextInput(
                        textInputSize: MoonTextInputSize.xl,
                        initialValue: ankutibuController.apiUrl,
                        onChanged: ankutibuController.setApiUrl,
                        validator: (String? value) =>
                            value?.length != null && value!.length < 5
                                ? "The text should be longer than 5 characters."
                                : null,
                        leading: const Align(
                          child: Text("API"),
                        ),
                      ),
                      MoonFormTextInput(
                        textInputSize: MoonTextInputSize.xl,
                        obscureText: _hidePassword,
                        initialValue: ankutibuController.secretKey,
                        onChanged: ankutibuController.setSecretKey,
                        validator: (String? value) =>
                            value != "123" ? "Wrong password." : null,
                        leading: const Align(
                          child: Text("Secret"),
                        ),
                        trailing: GestureDetector(
                          onTap: () =>
                              setState(() => _hidePassword = !_hidePassword),
                          child: Align(
                            child: Text(_hidePassword ? "Show" : "Hide"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
