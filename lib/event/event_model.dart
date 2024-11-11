import 'dart:convert';

class EventModel {
  String? id;
  DateTime startTime;
  DateTime endTime;
  bool isAllDay;
  String subject;
  String? notes;
  String? recurrenceRule;

  EventModel({
    this.id,
    required this.startTime,
    required this.endTime,
    this.isAllDay = false,
    this.subject = '',
    this.notes,
    this.recurrenceRule,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] as String?,
      startTime: DateTime.parse(map['startTime'] as String),
      endTime: DateTime.parse(map['endTime'] as String),
      isAllDay: map['isAllDay'] as bool? ?? false,
      subject: map['subject'] as String? ?? '',
      notes: map['notes'] as String?,
      recurrenceRule: map['recurrenceRule'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isAllDay': isAllDay,
      'subject': subject,
      'notes': notes,
      'recurrenceRule': recurrenceRule,
    };
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) => EventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  EventModel copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    bool? isAllDay,
    String? subject,
    String? notes,
    String? recurrenceRule,
  }) {
    return EventModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAllDay: isAllDay ?? this.isAllDay,
      subject: subject ?? this.subject,
      notes: notes ?? this.notes,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
    );
  }

  @override
  String toString() {
    return 'EventModel(id: $id, startTime: $startTime, endTime: $endTime, isAllDay: $isAllDay, subject: $subject, notes: $notes, recurrenceRule: $recurrenceRule)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventModel &&
        other.id == id &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.isAllDay == isAllDay &&
        other.subject == subject &&
        other.notes == notes &&
        other.recurrenceRule == recurrenceRule;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        isAllDay.hashCode ^
        subject.hashCode ^
        notes.hashCode ^
        recurrenceRule.hashCode;
  }

  bool isValidrecurrenceRule() {
    if (recurrenceRule == null || recurrenceRule!.isEmpty) {
      return false;
    }
    return true;
  }

  Map<String, dynamic>? parserecurrenceRule() {
    if (recurrenceRule == null || recurrenceRule!.isEmpty) {
      return null;
    }
    return {'recurrenceRule': recurrenceRule};
  }
}

extension EventModelExtension on EventModel {
  String get formatedStartTimeString =>
      '${startTime.hour}:${startTime.minute}, ${startTime.day}/${startTime.month}/${startTime.year}';
  String get formatedEndTimeString =>
      '${endTime.hour}:${endTime.minute}, ${endTime.day}/${endTime.month}/${endTime.year}';
}
