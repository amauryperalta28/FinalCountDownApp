import 'package:final_countdown_app/src/models/time_model.dart';
import 'package:final_countdown_app/src/pages/countdown_page.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimeSelectionPage extends StatefulWidget {
  static String routeName = '/';

  @override
  _TimeSelectionPageState createState() => _TimeSelectionPageState();
}

class _TimeSelectionPageState extends State<TimeSelectionPage> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time selection'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildNumberPicker(
                  currentValue: hours,
                  maxValue: 24,
                  label: 'Horas',
                  onChanged: (value) {
                    setState(() {
                      hours = value;
                    });
                  }),
              buildNumberPicker(
                  currentValue: minutes,
                  maxValue: 59,
                  label: 'Minutos',
                  onChanged: (value) {
                    setState(() {
                      minutes = value;
                    });
                  }),
              buildNumberPicker(
                  currentValue: seconds,
                  maxValue: 59,
                  label: 'Segundos',
                  onChanged: (value) {
                    setState(() {
                      seconds = value;
                    });
                  }),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          FlatButton(
              onPressed: () async {
                if (_isValidTime()) {
                  TimeModel model = new TimeModel(
                      hour: hours, minutes: minutes, seconds: seconds);
                  await Navigator.of(context)
                      .pushNamed(CountDownPage.routeName, arguments: model);
                } else {
                  print('Tiempo invalido');
                }
              },
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Iniciar'))
        ],
      ),
    );
  }

  bool _isValidTime() {
    return !(hours == 0 && minutes == 0 && seconds == 0);
  }

  Widget buildNumberPicker(
      {@required int maxValue,
      String label = '',
      @required ValueChanged<num> onChanged,
      int currentValue}) {
    return Column(
      children: [
        Text(label),
        NumberPicker.integer(
          textStyle: TextStyle(fontSize: 20),
          initialValue: currentValue,
          minValue: 0,
          maxValue: maxValue,
          onChanged: onChanged,
          infiniteLoop: true,
          zeroPad: true,
        ),
      ],
    );
  }
}
