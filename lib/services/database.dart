import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/models/bill.dart';
import 'package:easy_utilities/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Accounts.

  // collection reference accounts
  final CollectionReference accountsCollection =
      Firestore.instance.collection('accounts');

  Future updateUserData(String name, String emailOrPhoneNumber, String password,
      String profilePhotoUrl, bool profileUpdated) async {
    return await accountsCollection.document(uid).setData({
      'name': name,
      'emailOrPhoneNumber': emailOrPhoneNumber,
      'password': password,
      'profilePhotoUrl': profilePhotoUrl,
      'profileUpdated': profileUpdated
    });
  }

  Future<bool> getUserProfileUpdateStatus() async {
    await accountsCollection.document(uid).get().then((doc) {
      return doc.data['profileUpdated'];
    });
    return true;
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        password: snapshot.data['password'],
        emailOrPhonenumber: snapshot.data['emailOrPhoneNumber'],
        profilePhotoUrl: snapshot.data['profilePhotoUrl'],
        profileUpdated: snapshot.data['profileUpdated']);
  }

  String _userNameFromSnapshot(DocumentSnapshot snapshot) {
    return snapshot.data['name'];
  }

  List<BillData> _billListFromSnapshot(QuerySnapshot snapshot) {
    // ignore: deprecated_member_use
    List<BillData> data = List<BillData>();

    snapshot.documents.forEach((element) {
      data.add(_billDataFromSnapshot(element));
    });

    print(data);

    return data;
  }

  // Get user document
  Stream<UserData> get userData {
    return accountsCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  String getUserName(String id) async {
    DocumentSnapshot document = await accountsCollection.document(id).get();

    return document.data['name'];
  }

  // Bills.

  // collection reference bills
  final CollectionReference billsCollection =
      Firestore.instance.collection('bills');

  Future updateBillData(String uid, double amount, DateTime date, BillType type,
      double kwh, double litres, String userId) async {
    return await billsCollection.document(uid).setData({
      'uid': uid,
      'amount': amount,
      'date': date,
      'type': type,
      'kwh': kwh,
      'litres': litres,
      'userId': userId
    });
  }

  // BillData snapshot
  BillData _billDataFromSnapshot(DocumentSnapshot snapshot) {
    String name = getUserName(snapshot.data['userId']);

    // accountsCollection.document(uid).get().then((doc) {
    //   return doc.data['profileUpdated'];
    // });

    print('name $name');
    return BillData(
        uid: uid,
        amount: double.parse(snapshot.data['amount']),
        date: DateTime.fromMicrosecondsSinceEpoch(
            snapshot.data['date'].microsecondsSinceEpoch),
        type: BillType.values
            .firstWhere((e) => e.toString() == snapshot.data['type']),
        kwh: double.parse(snapshot.data['kwh']),
        litres: double.parse(snapshot.data['litres']),
        userName: name);
  }

  // Get bill document
  Stream<BillData> get billData {
    return billsCollection
        .document('YBsgrl7I07W0jNziZD0e')
        .snapshots()
        .map(_billDataFromSnapshot);
  }

  // get bills stream
  Stream<List<BillData>> get bills {
    final bills = billsCollection
        .getDocuments()
        .then((value) => _billListFromSnapshot(value));

    return Stream.fromFuture(bills);
  }

  // Get bills documents
  Future<List<BillData>> get billsData async {
    final allData = billsCollection
        .getDocuments()
        .then((value) => _billListFromSnapshot(value));

    return allData;
  }

  Future<List<BillData>> getBillsData(bool isLatest) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await billsCollection.getDocuments();

    // ignore: deprecated_member_use
    List<BillData> bills = new List<BillData>();

    querySnapshot.documents.map((doc) => bills.add(_billDataFromSnapshot(doc)));

    if (isLatest) {
      return bills;
    } else {
      return bills;
    }
  }
}
