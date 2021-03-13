import 'package:easy_utilities/constants.dart';
import 'package:easy_utilities/core/hex_color.dart';
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
    @required this.isSeparated,
  }) : super(key: key);

  final UserData user;
  final bool isLatest;
  final bool isSeparated;

  @override
  _BillsStreamBuilderState createState() => _BillsStreamBuilderState();
}

class _BillsStreamBuilderState extends State<BillsStreamBuilder> {
  bool closeTopContainer = false;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (widget.isSeparated) {
        setState(() {
          closeTopContainer = controller.offset > 50;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BillData>>(
      stream: DatabaseService(uid: widget.user.uid).bills,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<BillData> bills = snapshot.data;
            print(widget.isSeparated);
            if (!widget.isSeparated) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, i) {
                  if (bills[i].type == BillType.electricity) {
                    return LatestTransactionCard(
                      tileColor: Colors.white,
                      icon: './assets/icons/electricity-icon.svg',
                      title: bills[i].user.name,
                      subtitle:
                          '${monthsInYear[bills[i].date.month]} ${bills[i].date.day} | R ${bills[i].amount}',
                      onPress: () => {print('open transaction')},
                    );
                  } else {
                    return LatestTransactionCard(
                      tileColor: Colors.white,
                      icon: './assets/icons/water-drop-icon.svg',
                      title: bills[i].user.name,
                      subtitle:
                          '${monthsInYear[bills[i].date.month]} ${bills[i].date.day} | R ${bills[i].amount}',
                      onPress: () => {print('open transaction')},
                    );
                  }
                },
              );
            } else {
              return ListView.separated(
                controller: controller,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: bills.length,
                itemBuilder: (context, i) {
                  if (bills[i].type == BillType.electricity) {
                    return LatestTransactionCard(
                      tileColor: HexColor.fromHex('#00FFFF'),
                      icon: './assets/icons/electricity-icon.svg',
                      title: bills[i].user.name,
                      subtitle:
                          '${monthsInYear[bills[i].date.month]} ${bills[i].date.day} | R ${bills[i].amount}',
                      onPress: () => {print('open transaction')},
                    );
                  } else {
                    return LatestTransactionCard(
                      tileColor: HexColor.fromHex('#00FFFF'),
                      icon: './assets/icons/water-drop-icon.svg',
                      title: bills[i].user.name,
                      subtitle:
                          '${monthsInYear[bills[i].date.month]} ${bills[i].date.day} | R ${bills[i].amount}',
                      onPress: () => {print('open transaction')},
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              );
            }
          } else {
            return Container(
              child: CircularProgressIndicator(), // Todo: add custom loader
            );
          }
        } else {
          return Text('Getting the transactions...');
        }
      },
    );
  }
}
