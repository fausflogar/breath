// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({
    required this.leading,
    required this.title,
    this.subtitle,
    required this.trailing,
    this.start = false,
    this.end = false,
    super.key,
  });

  final Widget leading;
  final Widget title;
  final Widget? subtitle;
  final Widget trailing;

  // When enabled, the top border is rounded
  final bool start;

  // When enabled, the bottom border is rounded
  final bool end;

  @override
  _SettingsCard createState() => _SettingsCard();
}

class _SettingsCard extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      margin: const EdgeInsets.only(bottom: 1, left: 21, right: 21),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(widget.start ? 20.0 : 0.0),
          bottom: Radius.circular(widget.end ? 20.0 : 0.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          widget.leading,
          const SizedBox(
            width: 21,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.title,
              widget.subtitle ?? Container(),
            ],
          ).expanded(),
          const SizedBox(
            width: 12,
          ),
          widget.trailing,
        ],
      ),
    );
  }
}
