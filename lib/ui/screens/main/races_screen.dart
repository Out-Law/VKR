import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_app/modules/races_events/entities/race_event_state.dart';
import 'package:run_app/modules/races_events/presentation/widgets/race_event_card.dart';
import 'package:run_app/ui/components/base_screen.dart';
import 'package:run_app/ui/screens/additional_screens/create_race_screen.dart';
import 'package:run_app/utils/constants.dart';

class RacesScreen extends StatefulWidget {
  const RacesScreen({Key? key}) : super(key: key);

  @override
  State<RacesScreen> createState() => _RacesScreenState();
}

class _RacesScreenState extends State<RacesScreen> {
  final List<RaceEvent> _events = [];
  final List<RaceEvent> _foundEvents = [];

  late StreamSubscription _onAdded;
  late StreamSubscription _onRemoved;
  late StreamSubscription _onChanged;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    if (FirebaseAuth.instance.currentUser != null) {
      _onAdded.cancel();
      _onRemoved.cancel();
      _onChanged.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    'Забеги',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    //AutoRouter.of(context).pushNamed('CreateRaceScreen');
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const CreateRaceScreen(),
                      ),
                    );
                  },
                  mini: true,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 2, bottom: 12),
                child: Column(
                  children: [
                    generateWidgetsEvents(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView generateWidgetsEvents() {
    final children = <Widget>[];

    for (int i = 0; i < _events.length; i++) {
      children.add(
        RaceEventCard(
          raceEvent: _events[i],
        ),
      );
    }

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 15),
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  void initData() {
    var dbFirebase = FirebaseDatabase.instance.ref();
    var userId = FirebaseAuth.instance.currentUser?.uid ?? testUID;

    if (userId != null) {
      /*final eventsRef = dbFirebase
          .child(tableEvents)
          .orderByChild('members/$userId')
          .equalTo(true);*/

      final eventsRef = dbFirebase.child(tableEvents);

      _onAdded = eventsRef.onChildAdded.listen((event) {
        print('ADDED');
        var result = event.snapshot.value as Map?;

        if (result != null) {
          final event = RaceEvent.fromJson(result);
          _events.add(event);

          setState(() => _foundEvents.add(event));
        }
      });

      _onRemoved = eventsRef.onChildRemoved.listen((event) {
        print('REMOVED');
        var result = event.snapshot.value as Map?;

        if (result != null) {
          final event = RaceEvent.fromJson(result);
          _events.remove(event);

          setState(() => _foundEvents.remove(event));
        }
      });

      _onChanged = eventsRef.onChildChanged.listen((event) {
        print('CHANGED');
        var result = event.snapshot.value as Map?;

        if (result != null) {
          final event = RaceEvent.fromJson(result);

          final index = _events.indexWhere((element) => element.id == event.id);
          final indexFound =
              _foundEvents.indexWhere((element) => element.id == event.id);

          _events.removeAt(index);
          _events.insert(index, event);

          setState(() {
            _foundEvents.removeAt(indexFound);
            _foundEvents.insert(indexFound, event);
          });
        }
      });
    }
  }
}
