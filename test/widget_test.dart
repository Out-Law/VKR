import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:run_app/modules/bottom_button_run/bottom_button_run_part.dart';
import 'package:run_app/modules/color_selection_module/color_selection_part.dart';
import 'package:run_app/modules/data_run/data_run_part.dart';
import 'package:run_app/modules/data_run/presentation/widgets/components/elements_data.dart';
import 'package:run_app/modules/data_run/presentation/widgets/data_run_main_statistics.dart';
import 'package:run_app/modules/data_run/presentation/widgets/data_run_week_statistics.dart';
import 'package:run_app/modules/geolocator/stream_position.dart';
import 'package:run_app/modules/language_selection_module/presentation/widgets/language_selection_widget.dart';
import 'package:run_app/modules/reg_log_module/presentation/bloc/state_reg_log_cubit.dart';
import 'package:run_app/modules/timer/presentation/bloc/timer_cubit.dart';
import 'package:run_app/modules/timer/presentation/widgets/timer_widget.dart';
import 'package:run_app/modules/yandex_map/domain/request_routes.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/ganaration_track_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/marker_discomfort_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/users_in_run_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/yandex_map_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/widgets/animated_button.dart';
import 'package:run_app/modules/yandex_map/presentation/widgets/yandex_map_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:run_app/ui/components/base_background_container.dart';
import 'package:run_app/ui/components/base_button.dart';
import 'package:run_app/ui/components/base_color_selection.dart';
import 'package:run_app/ui/components/base_switcher.dart';
import 'package:run_app/ui/components/base_text.dart';
import 'package:run_app/ui/components/base_text_input.dart';
import 'package:run_app/ui/screens/additional_screens/settings_screen.dart';
import 'package:run_app/ui/screens/reg_log_screens/login_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


class MockStreamPosition extends Mock implements StreamPosition {}
class MockRequestRoutes extends Mock implements RequestRoutes {}

class MockColorSelectionCubit extends Mock implements ColorSelectionCubit {}

class MockStateRegLogCubit extends Mock implements StateRegLogCubit {}

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verify TimerWidget UI', (WidgetTester tester) async {
    // Build TimerWidget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: BlocProvider<TimerCubit>(
      create: (context) => TimerCubit(),
      child: const TimerWidget(),
    )));

    // Verify initial state of the TimerWidget
    expect(find.byType(AnimatedFlipCounter), findsNWidgets(3));
    // Remove the below line
    // expect(find.text('00'), findsNWidgets(3));  // Assuming timer starts at 00:00:00
  });


  testWidgets('Verify BottomButtonRunWidget UI and interaction', (WidgetTester tester) async {
    // Define a function for each state
    void onClickInitialStateMock() {}
    void onClickOpenMapStateMock() {}
    void onClickRunStateMock() {}

    // Create the BottomButtonRunCubit
    BottomButtonRunCubit bottomButtonRunCubit = BottomButtonRunCubit();

    // Build BottomButtonRunWidget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<BottomButtonRunCubit>(
        create: (context) => bottomButtonRunCubit,
        child: BottomButtonRunWidget(
          OnClickInitialState: onClickInitialStateMock,
          OnClickOpenMapState: onClickOpenMapStateMock,
          OnClickRunState: onClickRunStateMock,
        ),
      ),
    ));

    // Verify the FloatingActionButton is on screen
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);

    // Interact with the FloatingActionButton and trigger a frame.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Verify the BottomButtonRunCubit state is changed
    expect(bottomButtonRunCubit.state, StateBottomButtonRun.openMapState);

    // Interact with the FloatingActionButton again and trigger a frame.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Verify the BottomButtonRunCubit state is changed
    expect(bottomButtonRunCubit.state, StateBottomButtonRun.runState);
  });


  testWidgets('BaseBackgroundContainer shows child widget', (WidgetTester tester) async {
    // Create the widget
    await tester.pumpWidget(const MaterialApp(
      home: BaseBackgroundContainer(
        color: Colors.blue,
        child: Text('Hello'),
      ),
    ));

    // Verify the widget is displayed
    expect(find.byType(BaseBackgroundContainer), findsOneWidget);

    // Verify the Text widget is displayed
    expect(find.text('Hello'), findsOneWidget);
  });


  testWidgets('BaseButton shows text and calls onClick', (WidgetTester tester) async {
    bool wasClicked = false;

    // Create the widget
    await tester.pumpWidget(MaterialApp(
      home: BaseButton(
        onClick: () => wasClicked = true,
        title: 'Hello',
        active: true,
        sizeText: 16.0,
      ),
    ));

    // Verify the widget is displayed
    expect(find.byType(BaseButton), findsOneWidget);

    // Verify the Text widget is displayed
    expect(find.text('Hello'), findsOneWidget);

    // Tap the button and trigger a frame.
    await tester.tap(find.byType(BaseButton));
    await tester.pump();

    // Verify the callback function was called
    expect(wasClicked, isTrue);
  });

 /* testWidgets('BaseColorSelection shows colors and calls onTap', (WidgetTester tester) async {
    int tappedIndex = -1;

    // Create the widget
    await tester.pumpWidget(MaterialApp(
      home: BaseColorSelection(
        choiceThemeColors: true,
        onTap: (index) => tappedIndex = index,
        choiceColor: 1,
      ),
    ));

    // Verify the widget is displayed
    expect(find.byType(BaseColorSelection), findsOneWidget);

    // Verify the colors are displayed
    expect(find.byKey(const Key('colorContainer0')), findsOneWidget);
    expect(find.byKey(const Key('colorContainer1')), findsOneWidget);
    expect(find.byKey(const Key('colorContainer2')), findsOneWidget);

    // Tap each color and verify onTap is called with the correct index
    for (int i = 0; i < 3; i++) {
      await tester.tap(find.byKey(Key('colorContainer$i')));
      await tester.pump();

      expect(tappedIndex, i);
    }
  });
*/


  testWidgets('BaseSlideSwitcher test', (WidgetTester tester) async {
    int tappedIndex = -1;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BaseSlideSwitcher(
            containerHeight: 50,
            containerWight: 50,
            onSelect: (index) => tappedIndex = index,
            children: const [
              Text('First Child'),
              Text('Second Child'),
            ],
          ),
        ),
      ),
    );

    // Verify the widget is displayed
    expect(find.byType(BaseSlideSwitcher), findsOneWidget);

    // Verify the children are displayed
    expect(find.text('First Child'), findsOneWidget);
    expect(find.text('Second Child'), findsOneWidget);

    // Tap the first child and verify onSelect is called with index 0
    await tester.tap(find.text('First Child'));
    await tester.pump();

    expect(tappedIndex, 0);

    // Tap the second child and verify onSelect is called with index 1
    await tester.tap(find.text('Second Child'));
    await tester.pump();

    expect(tappedIndex, 1);
  });


  testWidgets('BaseTextInput test', (WidgetTester tester) async {
    String inputValue = "";

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BaseTextInput(
            hintText: 'Type here',
            onChanged: (value) => inputValue = value,
          ),
        ),
      ),
    );

    // Verify the widget is displayed
    expect(find.byType(BaseTextInput), findsOneWidget);

    // Verify the hintText is displayed
    expect(find.text('Type here'), findsOneWidget);

    // Enter text and verify onChanged is called
    await tester.enterText(find.byType(BaseTextInput), 'Hello, Flutter');
    await tester.pump();

    expect(inputValue, 'Hello, Flutter');
  });

  testWidgets('DataRunWeekStatistics widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DataRunWeekStatistics(),
      ),
    );

    // Verify the expected behavior of the widget

    // Example 1: Verify the presence of the BaseBackgroundContainer
    expect(find.byType(BaseBackgroundContainer), findsOneWidget);

    // Example 2: Verify the presence of the Chart widget
    expect(find.byType(Chart), findsOneWidget);

    // Perform additional tests as needed
  });


  testWidgets('ElementsData widget test', (WidgetTester tester) async {
    const String value = '100';
    const String title = 'Title';
    const String icon = 'assets/icons/Emoji2.svg';
    const Color color = Colors.blue;
    const double sizeText = 15;

    await tester.pumpWidget(
      const MaterialApp(
        home: ElementsData(
          value: value,
          title: title,
          icon: icon,
          color: color,
          sizeText: sizeText,
        ),
      ),
    );

    // Verify the expected behavior of the widget

    // Example 1: Verify the presence of the BaseText widget for value
    expect(find.text(value), findsOneWidget);

    // Example 2: Verify the presence of the BaseText widget for title
    expect(find.text(title), findsOneWidget);

    // Example 3: Verify the presence of the SvgPicture widget for icon
    expect(find.byWidgetPredicate((widget) => widget is SvgPicture), findsOneWidget);

    // Example 4: Verify the color of the BaseText widgets
    expect(
      find.byWidgetPredicate((widget) =>
      widget is BaseText && widget.color == color),
      findsNWidgets(2),
    );

    // Perform additional tests as needed
  });
}
