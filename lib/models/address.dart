class Address {
  const Address({
    this.id,
    required this.label,
    required this.line1,
    this.line2,
    required this.city,
    required this.pincode,
    this.latitude,
    this.longitude,
    this.isDefault = false,
  });
 
  final int? id; // null until the server creates it
  final String label;
  final String line1;
  final String? line2;
  final String city;
  final String pincode;
  final double? latitude;
  final double? longitude;
  final bool isDefault;
 
  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'] as int?,
        label: json['label'] as String,
        line1: json['line1'] as String,
        line2: json['line2'] as String?,
        city: json['city'] as String,
        pincode: json['pincode'] as String,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        isDefault: json['is_default'] as bool? ?? false,
      );
 
  /// Used for POST /addresses (no id).
  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'label': label,
        'line1': line1,
        'line2': line2,
        'city': city,
        'pincode': pincode,
        'latitude': latitude,
        'longitude': longitude,
        'is_default': isDefault,
      };
 
  Address copyWith({int? id, bool? isDefault}) => Address(
        id: id ?? this.id,
        label: label,
        line1: line1,
        line2: line2,
        city: city,
        pincode: pincode,
        latitude: latitude,
        longitude: longitude,
        isDefault: isDefault ?? this.isDefault,
      );
 
  String get fullText => [
        line1,
        if (line2 != null && line2!.isNotEmpty) line2!,
        city,
        pincode,
      ].join(', ');
}