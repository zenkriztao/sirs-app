import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/constants.dart';
import '../../controllers/patient_add_controller.dart';

class TabBarAbout extends StatelessWidget {
  const TabBarAbout({
    super.key,
    required this.controller,
  });

  final PatientAddController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.account_circle_outlined,
                color: colorPrimaryL,
                size: 32,
              ),
              const SizedBox(width: 20),
              Text(
                controller.patientName.text.toUpperCase(),
                style: const TextStyle(
                  color: colorTextSmall,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                controller.sex.value == "M"
                    ? Icons.face_6
                    : Icons.face_4_outlined,
                color: colorPrimaryL,
                size: 32,
              ),
              const SizedBox(width: 20),
              Text(
                controller.sex.value == "M" ? "Male" : "Female",
                style: const TextStyle(
                  color: colorTextSmall,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_rounded,
                color: colorPrimaryL,
                size: 32,
              ),
              const SizedBox(width: 20),
              Text(
                DateFormat("yyyy-MM-dd").format(controller.dateOfBirth),
                style: const TextStyle(
                  color: colorTextSmall,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.location_city_rounded,
                color: colorPrimaryL,
                size: 32,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  controller.address.text,
                  maxLines: 3,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    color: colorTextSmall,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
