import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'conversation.dart';

enum langs {
  blue('English'),
  pink('Hindi'),
  green('Sindhi'),
  yellow('Marathi'),
  grey('Gujarati');

  const langs(this.label);
  final String label;
}


class SpeechTranslator extends StatefulWidget {
  const SpeechTranslator({super.key});

  @override
  State<SpeechTranslator> createState() => _SpeechTranslatorState();
}

class _SpeechTranslatorState extends State<SpeechTranslator> {
  final TextEditingController speechLangController = TextEditingController();
  final TextEditingController textLangController = TextEditingController();
  langs? speechLang;
  langs? textLang;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'Speech Translator'
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownMenu<langs>(
                      controller: speechLangController,
                      requestFocusOnTap: true,
                      enableFilter: true,
                      label: const Text('Speech Language', style: TextStyle(fontSize: 15),),
                      onSelected: (langs? lang) {
                        setState(() {
                          speechLang = lang;
                        });
                      },
                      dropdownMenuEntries: langs.values
                          .map<DropdownMenuEntry<langs>>(
                              (langs lang) {
                            return DropdownMenuEntry<langs>(
                              value: lang,
                              label: lang.label,
                            );
                          }).toList(),
                      width: 250,
                    ),
                    const SizedBox(width: 24),
                    Icon(Icons.repeat),
                    const SizedBox(width: 24),
                    DropdownMenu<langs>(
                      controller: textLangController,
                      enableFilter: true,
                      requestFocusOnTap: true,
                      label: const Text('Text Language', style: TextStyle(fontSize: 15),),
                      onSelected: (langs? lang) {
                        setState(() {
                          textLang = lang;
                        });
                      },
                      dropdownMenuEntries:
                      langs.values.map<DropdownMenuEntry<langs>>(
                            (langs lang) {
                          return DropdownMenuEntry<langs>(
                            value: lang,
                            label: lang.label,
                          );
                        },
                      ).toList(),
                      width: 250,
                    ),
                  ],
                ),
              ),
              if (speechLang != null && textLang != null)
                Text(
                    'Translate from ${speechLang?.label} to ${textLang?.label}')
              else
                const Text('Please select languages.'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('Voice Input')),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: () {}, child: Text('Play Output'))
                ],
              ),
              SizedBox(height: 20,),
              Expanded(child: const Conversation()),
            ],
          ),
        ),
      ),
    );
  }
}
