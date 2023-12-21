import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_stop_watch/timer_stop_watch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _elapsedTime = '00:00:00';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 100), _updateTime);
  }

  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {
        _elapsedTime = _formatElapsedTime(_stopwatch.elapsedMilliseconds);
      });
    }
  }

  String _formatElapsedTime(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    int minutes = (seconds / 60).floor();
    int hours = (minutes / 60).floor();

    String formattedHours = (hours % 60).toString().padLeft(2, '0');
    String formattedMinutes = (minutes % 60).toString().padLeft(2, '0');
    String formattedSeconds = (seconds % 60).toString().padLeft(2, '0');

    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    } else {
      _stopwatch.stop();
    }
  }

  void _resetStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.reset();
      setState(() {
        _elapsedTime = '00:00:00';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _elapsedTime,
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: Text(_stopwatch.isRunning ? 'Pause' : 'Start',style: TextStyle(fontSize: 25),),
                ),
                SizedBox(width: 30),
                ElevatedButton(

                  onPressed: _resetStopwatch,
                  child: Text('Reset', style:TextStyle(fontSize: 25),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
