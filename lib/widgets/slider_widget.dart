import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderWidget extends StatefulWidget {
  final Function(double) onValueChanged;

  const SliderWidget({super.key, required this.onValueChanged});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Slider(
            value: _currentSliderValue,
            min: 1,
            max: 15,
            divisions: 14,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
              widget.onValueChanged(value);
            },
            activeColor: Colors.red,
            inactiveColor: Colors.red.withOpacity(0.6),
            thumbColor: const Color(0xFFf44235),
          ),
        ),
      ],
    );
  }
}
