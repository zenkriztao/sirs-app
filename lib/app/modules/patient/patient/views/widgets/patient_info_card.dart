import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import '../../../../../data/patient.dart';
import '../../../../../utils/constants.dart';

class PatientInfoCard extends StatelessWidget {
  const PatientInfoCard({
    super.key,
    required this.data,
    required this.editFunction,
    required this.delateFunction,
    required this.onTap,
    required this.show,
  });

  final Patient data;
  final bool show;
  final void Function()? editFunction;
  final void Function()? delateFunction;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    DateTime birthDate = DateTime.parse(data.dateOfBirth);
    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    //Icons.arrow_forward_ios
    return InkWell(
      onTap: onTap,
      onLongPress: show
          ? () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                builder: (context) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    height: 120,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.edit, color: Colors.blue),
                          title: const Text('Edit Patient Data'),
                          onTap: editFunction,
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete, color: Colors.red),
                          title: const Text('Delete Patient Data'),
                          onTap: delateFunction,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          : null,
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: Image.asset(
            data.sex == "M"
                ? 'assets/icons/male.png'
                : 'assets/icons/female.png',
            color: data.sex == "M" ? colorPrimaryL : Colors.pink,
            width: 40,
            height: 40,
          ),
        ),
        title: Text(
          data.patientName.toUpperCase(),
          style: TextStyle(
            color: colorDarkGrey,
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          '$age years old',
          style: GoogleFonts.sora(color: colorDarkGrey),
        ),
        trailing: Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            color: data.sex == "M" ? colorPrimaryL : Colors.pink,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: const Icon(Icons.arrow_forward_ios, color: colorBackgroundLL),
        ),
      ),
    );
  }
}
