import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/count/count_bloc.dart';

class CountButton extends StatefulWidget {
  const CountButton({Key? key}) : super(key: key);

  @override
  _CountButtonState createState() => _CountButtonState();
}

class _CountButtonState extends State<CountButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool animated = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 0),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  void _tapDown(int count) {
    _animationController.forward();
    HapticFeedback.heavyImpact();
    BlocProvider.of<CountBloc>(context).add(CountIncrementEvent(count));
  }

  void _tapUp() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 - _animationController.value;
    return BlocBuilder<CountBloc, CountState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: Duration(seconds: 2),
          curve: Curves.easeIn,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                child: Transform.scale(
                  scale: scale,
                  child: Text(
                    "${state.count}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => _tapUp(), // onTapUp
                  onTapDown: (TapDownDetails details) => _tapDown(state.count),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
