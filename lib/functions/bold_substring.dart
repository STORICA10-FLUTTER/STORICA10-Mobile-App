import 'package:flutter/material.dart';

extension BoldSubString on Text {
  Text boldSubString(String target, TextStyle asal) {
    final textSpans = List.empty(growable: true);
    final escapedTarget = RegExp.escape(target);
    final pattern = RegExp(escapedTarget, caseSensitive: false);
    final matches = pattern.allMatches(data!);

    int currentIndex = 0;
    for (final match in matches) {
      final beforeMatch = data!.substring(currentIndex, match.start);
      if (beforeMatch.isNotEmpty) {
        textSpans.add(TextSpan(text: beforeMatch, style: asal));
      }

      final matchedText = data!.substring(match.start, match.end);
      textSpans.add(
        TextSpan(
          text: matchedText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: asal.color,
            fontFamily: asal.fontFamily,
            fontSize: asal.fontSize,
          ),
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < data!.length) {
      final remainingText = data!.substring(currentIndex);
      textSpans.add(TextSpan(text: remainingText, style: asal));
    }

    return Text.rich(
      TextSpan(children: <TextSpan>[...textSpans]),
    );
  }
}
