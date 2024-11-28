import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContainerModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Configurator',
      home: Scaffold(
        appBar: AppBar(title: Text('Container Configurator')),
        body: ContainerConfigurator(),
      ),
    );
  }
}

class ContainerModel with ChangeNotifier {
  double _width = 100;
  double _height = 100;
  double _borderRadius = 0;

  double get width => _width;
  double get height => _height;
  double get borderRadius => _borderRadius;

  void updateWidth(double newWidth) {
    _width = newWidth;
    notifyListeners();
  }

  void updateHeight(double newHeight) {
    _height = newHeight;
    notifyListeners();
  }

  void updateBorderRadius(double newRadius) {
    _borderRadius = newRadius;
    notifyListeners();
  }
}

class ContainerConfigurator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RedContainer(),
        SizedBox(height: 20),
        SliderSection(
          title: 'Width',
          min: 50,
          max: 300,
          onChanged: (value) {
            Provider.of<ContainerModel>(context, listen: false).updateWidth(value);
          },
        ),
        SliderSection(
          title: 'Height',
          min: 50,
          max: 300,
          onChanged: (value) {
            Provider.of<ContainerModel>(context, listen: false).updateHeight(value);
          },
        ),
        SliderSection(
          title: 'Radius',
          min: 0,
          max: 50,
          onChanged: (value) {
            Provider.of<ContainerModel>(context, listen: false).updateBorderRadius(value);
          },
        ),
      ],
    );
  }
}

class SliderSection extends StatelessWidget {
  final String title;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  SliderSection({required this.title, required this.min, required this.max, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    double currentValue;


    if (title == 'Width') {
      currentValue = Provider.of<ContainerModel>(context).width;
    } else if (title == 'Height') {
      currentValue = Provider.of<ContainerModel>(context).height;
    } else {
      currentValue = Provider.of<ContainerModel>(context).borderRadius;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(title),
              Slider(
                value: currentValue,
                min: min,
                max: max,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 50,
          child: Text(currentValue.toStringAsFixed(1)),
        ),
      ],
    );
  }
}

class RedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final containerModel = Provider.of<ContainerModel>(context);
    return Container(
      width: containerModel.width,
      height: containerModel.height,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(containerModel.borderRadius),
        ),
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}