import 'package:easy_utilities/constants.dart';
import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/models/bill.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/services/database.dart';
import 'package:flutter/material.dart';

import 'latest_transaction_card.dart';

class BillsStreamBuilder extends StatefulWidget {
  const BillsStreamBuilder({
    Key key,
    @required this.user,
    @required this.isLatest,
  }) : super(key: key);

  final UserData user;
  final bool isLatest;

  @override
  _BillsStreamBuilderState createState() => _BillsStreamBuilderState();
}

class _BillsStreamBuilderState extends State<BillsStreamBuilder> {
  Future<List<String>> usernames;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BillData>>(
      stream: DatabaseService(uid: widget.user.uid).bills,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // ignore: deprecated_member_use
          List<BillData> bills = List<BillData>();

          if (widget.isLatest && snapshot.data.length > 3) {
            bills = snapshot.data.take(3);
          } else {
            bills = snapshot.data;
          }

          if (usernames == null) {
            _getUserNames(bills);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder<List<String>>(
              future: usernames,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  List<String> names = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: bills.length,
                    itemBuilder: (context, i) {
                      if (bills[i].type == BillType.electricity) {
                        return LatestTransactionCard(
                          icon: './assets/icons/electricity-icon.svg',
                          title: names[i],
                          subtitle:
                              '${monthsInYear[bills[i].date.month]} ${bills[i].date.day} | R ${bills[i].amount}',
                          onPress: () => {print('open transaction')},
                        );
                      } else {
                        return LatestTransactionCard(
                          icon: './assets/icons/water-drop-icon.svg',
                          title: names[i],
                          subtitle: '${bills[i].date} | R ${bills[i].amount}',
                          onPress: () => {print('open transaction')},
                        );
                      }
                    },
                  );
                } else {
                  return Container(
                    child:
                        CircularProgressIndicator(), // Todo: add custom loader
                  );
                }
              },
            );
          } else {
            return Text('Getting the transactions...');
          } // Todo: Add Loader
        } else {
          return Container(
            child: CircularProgressIndicator(),
          ); // Todo: Add Loader
        }
      },
    );
  }

  Future<void> _getUserNames(List<BillData> bills) async {
    if (bills != null) {
      // ignore: deprecated_member_use
      List<String> results = List<String>();

      await Future.wait(bills.map((input) async {
        String result = await _getUserName(input.userId);
        results.add(result);
      }));

      if (results.length > 0) {
        setState(() {
          usernames = Future.value(results);
        });
      }
    }
  }

  Future<String> _getUserName(String id) async {
    String result = await DatabaseService(uid: widget.user.uid).getUserName(id);
    if (result != null) {
      return result;
    } else {
      return null;
    }
  }
}
