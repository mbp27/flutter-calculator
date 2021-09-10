import 'dart:convert';

import 'package:flutter/foundation.dart';

class Primes {
  final int start;
  final int end;
  final List<int> result;

  Primes({
    required this.start,
    required this.end,
    required this.result,
  });

  Primes copyWith({
    int? start,
    int? end,
    List<int>? result,
  }) {
    return Primes(
      start: start ?? this.start,
      end: end ?? this.end,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
      'result': result,
    };
  }

  factory Primes.fromMap(Map<String, dynamic> map) {
    return Primes(
      start: map['start'],
      end: map['end'],
      result: List<int>.from(map['result']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Primes.fromJson(String source) => Primes.fromMap(json.decode(source));

  @override
  String toString() => 'Primes(start: $start, end: $end, result: $result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Primes &&
        other.start == start &&
        other.end == end &&
        listEquals(other.result, result);
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ result.hashCode;
}
