import 'dart:async';

import 'package:final_countdown_app/src/models/time_model.dart';
import 'package:final_countdown_app/src/pages/time_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class CountDownPage extends StatefulWidget {
  static String routeName = 'countdown';

  @override
  _CountDownPageState createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage> {
  final TextStyle style = TextStyle(fontSize: 30.0);
  TimeModel _timeModel;
  Timer _timer;
  DateTime remainingTime = new DateTime(0, 0, 0, 0, 0, 0);
  bool isTimeInitialized = false;

  @override
  void initState() {
    super.initState();
    _startTimer(_timeModel);
  }

 void _startTimer(TimeModel timeModel) {
    if (_timer == null || !_timer.isActive) {
      _timer = new Timer.periodic(new Duration(seconds: 1), _onTimerCallBack);
    }
  }

 void _onTimerCallBack(Timer timer) {
    remainingTime = remainingTime.subtract(Duration(seconds: 1));

    setState(() {});
    if (isTimeInitialized &&
        remainingTime.hour == 0 &&
        remainingTime.minute == 0 &&
        remainingTime.second == 0) {
      timer.cancel();
      showAnimatedDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ClassicGeneralDialogWidget(
            titleText: 'Mensaje',
            contentText: 'Se acabo el tiempo',
            onPositiveClick: () {
              Navigator.of(context).popUntil((route) =>
                  route.settings.name == TimeSelectionPage.routeName);
            },
            onNegativeClick: () {
              Navigator.of(context).popUntil((route) =>
                  route.settings.name == TimeSelectionPage.routeName);
            },
          );
        },
      );
    }
  }

 void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _setGivenTime(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('CountDown page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCounter(),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () {
                  if (_timer.isActive) {
                    _stopTimer();
                    Navigator.of(context).pop();
                  } else {
                    _startTimer(_timeModel);
                  }
                },
                child: _timer.isActive ? Text('Cancelar') : Text('Reanudar'),
                textColor: Colors.white,
                color: Colors.blue,
              ),
              SizedBox(width: 10.0),
              FlatButton(
                onPressed: () => setState(() {
                  _stopTimer();
                }),
                child: Text('Detener'),
                textColor: Colors.white,
                color: Colors.blue,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildNumber(remainingTime.hour, 'Horas'),
        SizedBox(width: 15.0),
        buildNumber(remainingTime.minute, 'Minutos'),
        SizedBox(width: 15.0),
        buildNumber(remainingTime.second, 'Segundos'),
      ],
    );
  }

  void _setGivenTime(BuildContext context) {
    if (_timeModel == null) {
      _timeModel = ModalRoute.of(context).settings.arguments;
      remainingTime = new DateTime(
          0, 0, 0, _timeModel.hour, _timeModel.minutes, _timeModel.seconds);

      isTimeInitialized = true;
    }
  }

  Widget buildNumber(int number, String label) {
    return Column(
      children: [
        Text(label),
        Text(number.toString(), style: style),
      ],
    );
  }
}
