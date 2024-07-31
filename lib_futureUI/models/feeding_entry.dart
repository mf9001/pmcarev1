class FeedingEntry {
  DateTime startTime;
  DateTime endTime;
  String type;
  String details;
  String? breast; // "left" or "right"
  double? amount; // in ml or oz
  String? unit; // "ml" or "oz"

  FeedingEntry({
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.details,
    this.breast,
    this.amount,
    this.unit,
  });
}
