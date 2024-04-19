import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class PlantsRecord extends FirestoreRecord {
  PlantsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Pname" field.
  String? _pname;
  String get pname => _pname ?? '';
  bool hasPname() => _pname != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  void _initializeFields() {
    _pname = snapshotData['Pname'] as String?;
    _imageUrl = snapshotData['image_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('plants');

  static Stream<PlantsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlantsRecord.fromSnapshot(s));

  static Future<PlantsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlantsRecord.fromSnapshot(s));

  static PlantsRecord fromSnapshot(DocumentSnapshot snapshot) => PlantsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlantsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlantsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlantsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlantsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlantsRecordData({
  String? pname,
  String? imageUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Pname': pname,
      'image_url': imageUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlantsRecordDocumentEquality implements Equality<PlantsRecord> {
  const PlantsRecordDocumentEquality();

  @override
  bool equals(PlantsRecord? e1, PlantsRecord? e2) {
    return e1?.pname == e2?.pname && e1?.imageUrl == e2?.imageUrl;
  }

  @override
  int hash(PlantsRecord? e) =>
      const ListEquality().hash([e?.pname, e?.imageUrl]);

  @override
  bool isValidKey(Object? o) => o is PlantsRecord;
}
