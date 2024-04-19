import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PurchaseRecord extends FirestoreRecord {
  PurchaseRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  bool hasPhoto() => _photo != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  void _initializeFields() {
    _status = snapshotData['status'] as String?;
    _photo = snapshotData['photo'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _name = snapshotData['name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('purchase');

  static Stream<PurchaseRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PurchaseRecord.fromSnapshot(s));

  static Future<PurchaseRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PurchaseRecord.fromSnapshot(s));

  static PurchaseRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PurchaseRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PurchaseRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PurchaseRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PurchaseRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PurchaseRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPurchaseRecordData({
  String? status,
  String? photo,
  double? price,
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'status': status,
      'photo': photo,
      'price': price,
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}

class PurchaseRecordDocumentEquality implements Equality<PurchaseRecord> {
  const PurchaseRecordDocumentEquality();

  @override
  bool equals(PurchaseRecord? e1, PurchaseRecord? e2) {
    return e1?.status == e2?.status &&
        e1?.photo == e2?.photo &&
        e1?.price == e2?.price &&
        e1?.name == e2?.name;
  }

  @override
  int hash(PurchaseRecord? e) =>
      const ListEquality().hash([e?.status, e?.photo, e?.price, e?.name]);

  @override
  bool isValidKey(Object? o) => o is PurchaseRecord;
}
