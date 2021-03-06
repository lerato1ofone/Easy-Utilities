import 'package:flutter/material.dart';

class AccountDialogOverlay extends ModalRoute<void> {
  AccountDialogOverlay({
    @required this.text,
    this.resetPassword,
  }) : super();

  final String text;
  final VoidCallback resetPassword;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () => resetPassword(),
                child: Text('Yes'),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
