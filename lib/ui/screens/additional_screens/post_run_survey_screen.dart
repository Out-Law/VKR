import 'package:flutter/material.dart';
import 'package:run_app/ui/components/post_run_survey_component/mark_map_end_screen.dart';
import 'package:run_app/ui/components/post_run_survey_component/center_next_button.dart';
import 'package:run_app/ui/components/post_run_survey_component/well_being_assessment_screen.dart';
import 'package:run_app/ui/components/post_run_survey_component/statistics_run_end_screen.dart';
import 'package:run_app/ui/components/post_run_survey_component/start_survey_screen.dart';
import 'package:run_app/ui/components/post_run_survey_component/top_back_skip_view.dart';
import 'package:run_app/ui/components/post_run_survey_component/end_survey_screen.dart';

class PostRunSurveyScreen extends StatefulWidget {
  const PostRunSurveyScreen({Key? key}) : super(key: key);

  @override
  _PostRunSurveyScreenState createState() =>
      _PostRunSurveyScreenState();
}

class _PostRunSurveyScreenState
    extends State<PostRunSurveyScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7EBE1),
      body: ClipRect(
        child: Stack(
          children: [
            StartSurveyScreen(
              animationController: _animationController!,
            ),
            StatisticsRunEndScreen(
              animationController: _animationController!,
            ),
            MarkMapEndScreen(
              animationController: _animationController!,
            ),
            WellBeingAssessmentScreen(
              animationController: _animationController!,
            ),
            EndSurveyScreen(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: const Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.pop(context);
  }
}
