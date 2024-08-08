import 'package:allergies/core/locales.dart';
import 'package:allergies/core/theme/color_palette.dart';
import 'package:allergies/core/theme/scaling_system.dart';
import 'package:allergies/presentation/views/settings/components/language_list_tile.dart';
import 'package:allergies/presentation/widgets/button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class SettingsLanguageScreen extends StatefulWidget {
  static const routeName = "/settingsLanguage";
  const SettingsLanguageScreen({super.key});

  @override
  State<SettingsLanguageScreen> createState() => _SettingsLanguageScreenState();
}

class _SettingsLanguageScreenState extends State<SettingsLanguageScreen> {
  FlutterLocalization localization = FlutterLocalization.instance;
  String selectedLocale = "";
  late String currentLocale;

  List<String> languages = [
    "🇬🇧 English",
    "🇪🇸 Spanish",
    "🇫🇷 French",
    "🇩🇪 German",
  ];

  int selectedIndex = -1;

  void handleSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void setLocale(String? value) {
    if (value == null) return;
    if (value == "en") {
      localization.translate("en");
    } else if (value == "de") {
      localization.translate("de");
    } else if (value == "es") {
      localization.translate("es");
    } else if (value == "fr") {
      localization.translate("fr");
    }

    setState(() {
      currentLocale = value;
    });
  }

  int getLanguageIndex(String locale) {
    switch (locale) {
      case "en":
        return 0;
      case "es":
        return 1;
      case "fr":
        return 2;
      case "de":
        return 3;
      default:
        return -1;
    }
  }

  void getLanguages(String currentLocal) {
    if (currentLocale == "en") {
      setState(() {
        languages = [
          "🇬🇧 English",
          "🇪🇸 Spanish",
          "🇫🇷 French",
          "🇩🇪 German",
        ];
      });
    } else if (currentLocale == "de") {
      setState(() {
        languages = [
          "🇬🇧 Englisch",
          "🇪🇸 Spanisch",
          "🇫🇷 Französisch",
          "🇩🇪 Deutsch",
        ];
      });
    } else if (currentLocale == "fr") {
      setState(() {
        languages = [
          "🇬🇧 Anglais",
          "🇪🇸 Espagnol",
          "🇫🇷 Français",
          "🇩🇪 Allemand",
        ];
      });
    } else if (currentLocale == "es") {
      setState(() {
        languages = [
          "🇬🇧 Inglés",
          "🇪🇸 Español",
          "🇫🇷 Francés",
          "🇩🇪 Alemàn",
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    currentLocale = localization.currentLocale!.languageCode;
    selectedLocale = currentLocale;
    selectedIndex = getLanguageIndex(currentLocale);
    getLanguages(currentLocale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Beamer.of(context).beamBack();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(LocaleData.settingsLanguage.getString(context)),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: languages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return LanguageListTile(
                    title: languages[index],
                    isSelected: selectedIndex == index,
                    onTap: () {
                      if (language.contains("🇬🇧")) {
                        setState(() {
                          selectedLocale = "en";
                        });
                      } else if (language.contains("🇪🇸")) {
                        setState(() {
                          selectedLocale = "es";
                        });
                      } else if (language.contains("🇫🇷")) {
                        setState(() {
                          selectedLocale = "fr";
                        });
                      } else if (language.contains("🇩🇪")) {
                        setState(() {
                          selectedLocale = "de";
                        });
                      }
                    },
                    onSelect: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            largeGap,
            Center(
              child: Text(
                LocaleData.moreLanguagesSoon.getString(context),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            const Spacer(),
            Button(
              label: LocaleData.safe.getString(context),
              color: selectedLocale != currentLocale
                  ? primary
                  : Theme.of(context).colorScheme.onBackground,
              onTap: () {
                setLocale(selectedLocale);
              },
            ),
          ],
        ),
      ),
    );
  }
}
