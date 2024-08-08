import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final Function(double) onValueChanged; // Callback function

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

        const SizedBox(height: 10),
        Slider(
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
          activeColor: Colors.teal,
          inactiveColor: Colors.teal.withOpacity(0.3),
          thumbColor: Colors.tealAccent,
        ),
      ],
    );
  }
}
