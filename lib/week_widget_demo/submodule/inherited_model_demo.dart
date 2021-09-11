import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class InheritedModelDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ValueableManage(
      child: Column(children: [
        _ValueA(),
        _ValueB(),
      ]),
    );
  }
}

class _ValueableManage extends StatefulWidget {
  final Widget child;

  _ValueableManage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  __ValueableManageState createState() => __ValueableManageState();
}

class __ValueableManageState extends State<_ValueableManage> {
  int _valueA = 0;
  int _valueB = 0;

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: _Valueable(
        valueA: _valueA,
        valueB: _valueB,
        child: Column(
          children: [
            widget.child,
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _valueA += 1;
                    });
                  },
                  child: Text("Add valueA"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _valueB += 1;
                    });
                  },
                  child: Text("Add valueB"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ValueA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = InheritedModel.inheritFrom<_Valueable>(
      context,
      aspect: 0,
    );
    return Text(
      "valueA: ${value?.valueA ?? 0} rand: ${Random.secure().nextInt(1024)}",
    );
  }
}

class _ValueB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = InheritedModel.inheritFrom<_Valueable>(
      context,
      aspect: 1,
    );
    return Text(
      "valueA: ${value?.valueB ?? 0} rand: ${Random.secure().nextInt(1024)}",
    );
  }
}

class _Valueable extends InheritedModel<int> {
  final Widget child;
  final int valueA;
  final int valueB;

  _Valueable({
    Key? key,
    required this.valueA,
    required this.valueB,
    required this.child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_Valueable oldWidget) {
    return oldWidget.valueA != valueA || oldWidget.valueB != valueB;
  }

  @override
  bool updateShouldNotifyDependent(
      _Valueable oldWidget, Set<int> dependencies) {
    bool result = false;
    print(dependencies.toList());
    if (dependencies.contains(0)) {
      result |= oldWidget.valueA != valueA;
    }
    if (dependencies.contains(1)) {
      result |= oldWidget.valueB != valueB;
    }
    print(result);
    return result;
  }
}
