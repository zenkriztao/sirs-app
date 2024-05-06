import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  String? docId;
  final String patientName;
  final String sex;
  final List<Record> records;
  final String address;
  final String dateOfBirth;

  Patient({
    this.docId,
    required this.patientName,
    required this.sex,
    required this.records,
    required this.address,
    required this.dateOfBirth,
  });

  // factory Patient.fromMap(Map<String, dynamic> map, ) {
  //   var list = map['records'] as List;
  //   List<Record> recordList = list.map((i) => Record.fromMap(i)).toList();

  //   return Patient(
  //     patientName: map['patient_name'],
  //     sex: map['sex'],
  //     records: recordList,
  //     address: map['address'],
  //     dateOfBirth: map['date_of_birth'],
  //   );
  // }
  factory Patient.fromMap(Map<String, dynamic> map, {String? docId}) {
    var list = map['records'] as List;
    List<Record> recordList = list.map((i) => Record.fromMap(i)).toList();

    return Patient(
      docId: docId,
      patientName: map['patient_name'],
      sex: map['sex'],
      records: recordList,
      address: map['address'],
      dateOfBirth: map['date_of_birth'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patient_name': patientName,
      'sex': sex,
      'records': records.map((record) => record.toMap()).toList(),
      'address': address,
      'date_of_birth': dateOfBirth,
    };
  }
}

// class Record {
//   final String recordName;
//   final String diagnoses;
//   final String additionalNotes;
//   final String createdAt;

//   Record({
//     required this.recordName,
//     required this.diagnoses,
//     required this.additionalNotes,
//     required this.createdAt,
//   });

//   factory Record.fromMap(Map<String, dynamic> map) {
//     return Record(
//       recordName: map['record_name'],
//       diagnoses: map['diagnoses'],
//       additionalNotes: map['additional_notes'],
//       createdAt: map['created_at'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'record_name': recordName,
//       'diagnoses': diagnoses,
//       'additional_notes': additionalNotes,
//       'created_at': createdAt,
//     };
//   }
// }
class Record {
  final String recordName;
  final String diagnoses;
  final String additionalNotes;
  final String createdAt;

  Record({
    required this.recordName,
    required this.diagnoses,
    required this.additionalNotes,
    required this.createdAt,
  });

  factory Record.fromMap(Map<String, dynamic> map) {
    String createdAt;
    if (map['created_at'] is Timestamp) {
      Timestamp timestamp = map['created_at'] as Timestamp;
      DateTime dateTime = timestamp.toDate();
      createdAt = dateTime.toIso8601String();
    } else {
      createdAt = map['created_at'];
    }

    return Record(
      recordName: map['record_name'],
      diagnoses: map['diagnoses'],
      additionalNotes: map['additional_notes'],
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'record_name': recordName,
      'diagnoses': diagnoses,
      'additional_notes': additionalNotes,
      'created_at': createdAt,
    };
  }
}
