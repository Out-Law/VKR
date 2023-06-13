import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:run_app/modules/races_events/entities/race_event_state.dart';
import 'package:run_app/ui/components/base_screen.dart';
import 'package:run_app/utils/constants.dart';
import 'package:run_app/utils/helper.dart';

class CreateRaceScreen extends StatefulWidget {
  const CreateRaceScreen({Key? key, this.raceEvent}) : super(key: key);

  final RaceEvent? raceEvent;

  @override
  State<CreateRaceScreen> createState() => _CreateRaceScreenState();
}

class _CreateRaceScreenState extends State<CreateRaceScreen> {
  final _user = FirebaseAuth.instance.currentUser;

  final titleController = TextEditingController();
  final addressController = TextEditingController();

  bool _isCheckedGender = false;
  bool _isCheckedAge = false;

  int _distance = 0;
  int? _startDate;
  String? _photoEvent = "";
  int? _minAge;
  int? _maxAge;
  int? _gender;
  int? _maxMembers;
  List<String> _imageUrls = [];
  List<String> _links = [];

  @override
  void initState() {
    super.initState();

    if (widget.raceEvent != null) {
      titleController.text = widget.raceEvent!.title;
      addressController.text = widget.raceEvent!.address;

      _distance = widget.raceEvent!.distance;
      _startDate = widget.raceEvent!.startDate;
      _photoEvent = widget.raceEvent!.photo;
      _minAge = widget.raceEvent!.minAge;
      _maxAge = widget.raceEvent!.maxAge;
      _gender = widget.raceEvent!.gender;
      _maxMembers = widget.raceEvent!.maxMembers;
      _imageUrls = widget.raceEvent!.imageUrls;
      _links = widget.raceEvent!.links;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: InkWell(
                    child: const Icon(
                      Icons.chevron_left_outlined,
                      size: 40,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 20, bottom: 20),
                child: Column(
                  children: [
                    TextField(
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: "Название забега",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {},
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: infoButton(
                        () {
                          _selectDateTime(context);
                        },
                        _startDate != null
                            ? formatDateTimeEvent.format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    _startDate!))
                            : "Дата проведения",
                        Icons.date_range,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              controller: addressController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.location_on_outlined),
                                prefixIconColor: Colors.black,
                                hintText: "Адрес проведения",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 15),
                      child: infoTitleText(
                        "Фото-материалы",
                        Icons.photo_camera_outlined,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFD9D9D9),
                            ),
                            child: const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 32,
                            ),
                          ),
                          containerInfoForPhoto(
                              'https://pro-dachnikov.com/uploads/posts/2021-10/1633903094_83-p-kamennaya-lestnitsa-taganrog-foto-101.jpg'),
                          containerInfoForPhoto(
                              'https://avatars.dzeninfra.ru/get-zen_doc/1570751/pub_6064af006bdb585a61abae35_6064af94b89182193c080bb0/scale_1200'),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 10),
                      child: infoTitleText(
                        "Организатор",
                        Icons.people_alt_outlined,
                      ),
                    ),
                    if (widget.raceEvent?.ownerID != null ||
                        _user?.displayName != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                widget.raceEvent?.ownerID ?? _user!.photoURL!,
                                /*widget.raceEvent?.ownerID != null
                                    ? getUserPhoto(widget.raceEvent?.ownerID)
                                    : _user!.photoURL!,*/
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.raceEvent?.ownerID ?? _user!.displayName!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 10),
                      child: infoTitleText(
                        "Связь с организатором",
                        Icons.feedback_outlined,
                      ),
                    ),
                    infoButton(
                      () {},
                      "Добавить ссылку",
                      Icons.add_link,
                    ),
                    generateWidgetsLinks(),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            value: _isCheckedAge,
                            onChanged: (value) {
                              setState(() => _isCheckedAge = value!);
                            },
                          ),
                          const Text(
                            "Ограничение: возраст",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            value: _isCheckedGender,
                            onChanged: (value) {
                              setState(() => _isCheckedGender = value!);
                            },
                          ),
                          const Text(
                            "Ограничение: пол",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: MaterialButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty &&
                              addressController.text.isNotEmpty &&
                              _startDate != null) {
                            _saveEvent().whenComplete(
                                () => AutoRouter.of(context).pop());
                          } else {
                            showSnackbar(context, 'Введите недостающие данные');
                          }
                        },
                        elevation: 0,
                        disabledElevation: 0,
                        focusElevation: 0,
                        highlightElevation: 0,
                        hoverElevation: 0,
                        color: Colors.green,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Создать',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView generateWidgetsLinks() {
    final children = <Widget>[];

    for (int i = 0; i < _links.length; i++) {
      children.add(
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: infoButton(
            () {},
            "Ссылка",
            Icons.link,
          ),
        ),
      );
    }

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 5),
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget infoTitleText(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon),
        Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        )
      ],
    );
  }

  Widget infoButton(Function onClick, String text, IconData icon) {
    return MaterialButton(
      onPressed: () {
        onClick();
      },
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      color: const Color(0xFFFFFFFF),
      shape: const RoundedRectangleBorder(
        //side: new BorderSide(color: Color(0xFF2A8068)),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                text,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget containerInfoForPhoto(String imageUrl) {
    return Container(
      height: 80,
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _startDate != null
          ? DateTime.fromMillisecondsSinceEpoch(_startDate!)
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );

    /*if (selected != null && selected.millisecondsSinceEpoch != _startDate) {
      setState(() => _startDate = selected.millisecondsSinceEpoch);
    }*/

    return selected;
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(_startDate != null
        ? DateTime.fromMillisecondsSinceEpoch(_startDate!)
        : DateTime.now());

    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    /*if (selected != null && selected != selectedTime) {
      setState(() => selectedTime = selected);
    }*/

    return selected;
  }

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;

    final time = await _selectTime(context);
    if (time == null) return;

    setState(() => _startDate = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        ).millisecondsSinceEpoch);
  }

  Future<void> _saveEvent() async {
    var dbFirebase = FirebaseDatabase.instance.ref();

    if (await hasInternet()) {
      String? idEvent =
          widget.raceEvent?.id ?? dbFirebase.child(tableEvents).push().key;

      String uid = _user?.uid ?? testUID;

      if (idEvent != null) {
        RaceEvent raceEvent = RaceEvent(
            id: idEvent,
            title: titleController.text,
            distance: _distance,
            startDate: _startDate!,
            address: addressController.text,
            ownerID: widget.raceEvent?.ownerID ?? uid,
            photo: _photoEvent,
            minAge: _minAge,
            maxAge: _maxAge,
            gender: _gender,
            maxMembers: _maxMembers,
            members: widget.raceEvent?.members ?? {uid: true},
            imageUrls: _imageUrls,
            links: _links);

        await dbFirebase
            .child(tableEvents)
            .child(idEvent)
            .set(raceEvent.toJson());
      }
    }
  }
}
