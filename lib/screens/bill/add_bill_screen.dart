import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddBillScreen extends StatefulWidget {
  const AddBillScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;
  @override
  _AddBillScreenState createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  int _groupValue = -1;
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2018, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#E5DFFE'),
      body: Column(
        children: [
          Container(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, right: 40),
                child: SvgPicture.asset(
                  "./assets/icons/cancel-icon.svg",
                  width: 40,
                  height: 40,
                  color: HexColor.fromHex('#4D4D4D'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Enter your purchase',
            style: eBlackHeading,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: 240,
            height: 54,
            decoration: BoxDecoration(
              color: HexColor.fromHex('#F8F8F8'),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 35, top: 8),
              child: Text(
                'R     ______',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Please enter a date',
                      style: eQuestionText,
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '1 REQUIRED',
                          style: eRequiredText,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  width: 280,
                  decoration: new BoxDecoration(
                    color: HexColor.fromHex('#F8F8F8'),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: 0,
                            groupValue: _groupValue,
                            title: Text("Use today’s date"),
                            onChanged: (newValue) =>
                                setState(() => _groupValue = newValue),
                            activeColor: Colors.blue,
                            selected: false,
                            toggleable: true,
                          ),
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "./assets/icons/calendar-icon.svg",
                                  height: 22,
                                  width: 22,
                                ),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Tap to add a date')
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
