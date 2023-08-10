import 'dart:convert';

class UpdatePondInput {
  final String pondID;
  final String status;
  UpdatePondInput({
    required this.pondID,
    required this.status,
  });

  UpdatePondInput copyWith({
    String? pondID,
    String? status,
  }) {
    return UpdatePondInput(
      pondID: pondID ?? this.pondID,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pondID': pondID,
      'status': status,
    };
  }

  factory UpdatePondInput.fromMap(Map<String, dynamic> map) {
    return UpdatePondInput(
      pondID: map['pondID'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdatePondInput.fromJson(String source) =>
      UpdatePondInput.fromMap(json.decode(source));

  @override
  String toString() => 'UpdatePondInput(pondID: $pondID, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdatePondInput &&
        other.pondID == pondID &&
        other.status == status;
  }

  @override
  int get hashCode => pondID.hashCode ^ status.hashCode;
}
