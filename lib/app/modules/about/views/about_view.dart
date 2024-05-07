import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AboutView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AboutView is working',
          style: GoogleFonts.sora(fontSize: 20),
        ),
      ),
    );
  }
}
