import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/services/database.dart';
import 'package:easy_utilities/widgets/option_instruction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  bool dateSelected = false;
  double amount = 0.00;
  BillType type = BillType.electricity;
  double kwhOrLitres = 0.00;
  String error;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2018, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateSelected = true;
      });
  }

  void onChanged(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#E5DFFE'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      "./assets/icons/cancel-icon.svg",
                      color: HexColor.fromHex('#4D4D4D'),
                    ),
                    iconSize: 100,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Text(
                'Enter your purchase',
                style: eBlackHeading,
              ),
              SizedBox(
                height: 20,
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
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Enter an amount' : null,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                      border: InputBorder.none,
                      hintText: 'Amount',
                      hintStyle: TextStyle(
                          fontSize: 18.5,
                          color: HexColor.fromHex('#4D4D4D'),
                          fontFamily: 'Roboto',
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w500),
                      fillColor: Colors.black,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SvgPicture.asset(
                          "./assets/icons/south-african-rand.svg",
                          width: 40,
                          height: 40,
                          color: HexColor.fromHex('#4D4D4D'),
                        ),
                      ),
                    ),
                    style: eBodyText1,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onChanged: (val) => onAmountChanged(val),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    OptionInstruction(
                      text: 'Please enter a date',
                      requiredNo: 1,
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
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.blueGrey[200],
                                        child: SvgPicture.asset(
                                          "./assets/icons/calendar-icon.svg",
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  dateSelected == false
                                      ? Text("Tap icon to add date")
                                      : Text(
                                          "${selectedDate.toLocal()}"
                                              .split(' ')[0],
                                          style: TextStyle(
                                              color:
                                                  HexColor.fromHex('#7C7C7C'),
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto'),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    OptionInstruction(
                      text: 'Choose the utility type',
                      requiredNo: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 130,
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
                            RadioListTile<BillType>(
                              title: const Text('Electricity'),
                              value: BillType.electricity,
                              groupValue: type,
                              onChanged: (BillType value) {
                                setState(() {
                                  type = value;
                                });
                              },
                            ),
                            RadioListTile<BillType>(
                              title: const Text('Water'),
                              value: BillType.water,
                              groupValue: type,
                              onChanged: (BillType value) {
                                setState(() {
                                  type = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: TextFormField(
                        onChanged: (value) => onkwhorLitresChanged(value),
                        decoration: InputDecoration(
                          hintText: type == BillType.electricity
                              ? 'Kwh (Optional)'
                              : 'Litres(Optional)',
                          hintStyle: TextStyle(
                              fontSize: 18.5,
                              color: HexColor.fromHex('#4D4D4D'),
                              fontFamily: 'Roboto',
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.w500),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    IconButton(
                      color: Colors.transparent,
                      icon: SvgPicture.asset(
                        "./assets/icons/success-icon.svg",
                        color: amount != 0.00 && type != null
                            ? Colors.green
                            : Colors.grey,
                      ),
                      iconSize: 40,
                      onPressed: () {
                        _addBillTransaction();
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Done',
                      style: TextStyle(
                          fontSize: 18.5,
                          color: amount != 0.00 && type != null
                              ? Colors.green
                              : Colors.grey,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onkwhorLitresChanged(value) {
    setState(() {
      kwhOrLitres = value.isEmpty ? 0.00 : double.parse(value);
    });
  }

  void onAmountChanged(value) {
    setState(() {
      amount = value.isEmpty ? 0.00 : double.parse(value);
    });
  }

  void _addBillTransaction() async {
    if (_formKey.currentState.validate()) {
      UserBillData userBillData = new UserBillData(
        uid: widget.user.uid,
        name: widget.user.name,
      );

      dynamic result = await DatabaseService().addBillData(
          amount, selectedDate, type, kwhOrLitres, kwhOrLitres, userBillData);
      if (result == null) {
        setState(() {
          error = 'Invalid information';
        });
      }
    }
  }
}
