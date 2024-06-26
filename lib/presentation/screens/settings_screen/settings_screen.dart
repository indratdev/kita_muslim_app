import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomWidgets.basicAppBar(
          context,
          "Pengaturan",
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              leading: Icon(
                Icons.circle,
                size: MediaQuery.sizeOf(context).width / 28,
              ),
              title: const Text("Unduh Semua Surat Al-Quran"),
              onTap: () {},
            ),
          ]).toList(),
        ));
  }
}
