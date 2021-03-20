import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/models/bill.dart';
import 'package:easy_utilities/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Users.

  // // collection reference users
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String name, String emailOrPhoneNumber, String password,
      String profilePhotoUrl, bool profileUpdated) async {
    return await usersCollection.document(uid).setData({
      'name': name,
      'emailOrPhoneNumber': emailOrPhoneNumber,
      'password': password,
      'profilePhotoUrl': profilePhotoUrl,
      'profileUpdated': profileUpdated
    });
  }

  Future changePassword(String password) async {
    return await usersCollection.document(uid).updateData({
      'password': password,
    });
  }

  Future<bool> getUserProfileUpdateStatus() async {
    await usersCollection.document(uid).get().then((doc) {
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

  // Get user document
  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<String> getUserName(String id) async {
    DocumentSnapshot document = await usersCollection.document(id).get();

    return document.data['name'];
  }

  Future<void> deleteUser(id) async {
    return await usersCollection.document(id).delete();
  }

  // Bills.

  // collection reference bills
  final CollectionReference billsCollection =
      Firestore.instance.collection('bills');

  List<BillData> _billListFromSnapshot(QuerySnapshot snapshot) {
    // ignore: deprecated_member_use
    List<BillData> data = List<BillData>();

    snapshot.documents.forEach((element) {
      data.add(_billDataFromSnapshot(element));
    });

    return data;
  }

  Future updateBillData(double amount, DateTime date, BillType type, double kwh,
      double litres, String userId) async {
    return await billsCollection.document(uid).setData({
      'amount': amount,
      'date': date,
      'type': type.toString(),
      'kwh': kwh,
      'litres': litres,
      'userId': userId
    }, merge: true);
  }

  Future addBillData(double amount, DateTime date, BillType type, double kwh,
      double litres, UserBillData user) async {
    return await billsCollection.add({
      'amount': amount.toString(),
      'date': date,
      'type': type.toString(),
      'kwh': kwh.toString(),
      'litres': litres.toString(),
      'user': {
        'uid': user.uid,
        'name': user.name,
      }
    });
  }

  // BillData snapshot
  BillData _billDataFromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data;

    UserBillData userBillData = new UserBillData(
      uid: data['user']['uid'],
      name: data['user']['name'],
    );

    return BillData(
        uid: data['uid'],
        amount: double.parse(snapshot.data['amount']),
        date: DateTime.fromMicrosecondsSinceEpoch(
            data['date'].microsecondsSinceEpoch),
        type: BillType.values
            .firstWhere((e) => e.toString() == snapshot.data['type']),
        kwh: double.parse(snapshot.data['kwh']),
        litres: double.parse(snapshot.data['litres']),
        user: userBillData);
  }

  // Get bill document
  Stream<BillData> get billData {
    return billsCollection.document(uid).snapshots().map(_billDataFromSnapshot);
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

    if (isLatest && bills.length > 3) {
      return bills;
    } else {
      return bills;
    }
  }
}
