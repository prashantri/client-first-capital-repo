class Address {
  final String? line1;
  final String? line2;
  final String? city;
  final String? emirate;
  final String? country;
  final String? postalCode;

  Address({this.line1, this.line2, this.city, this.emirate, this.country, this.postalCode});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    line1: json['line1'],
    line2: json['line2'],
    city: json['city'],
    emirate: json['emirate'],
    country: json['country'],
    postalCode: json['postalCode'],
  );

  Map<String, dynamic> toJson() => {
    if (line1 != null) 'line1': line1,
    if (line2 != null) 'line2': line2,
    if (city != null) 'city': city,
    if (emirate != null) 'emirate': emirate,
    if (country != null) 'country': country,
    if (postalCode != null) 'postalCode': postalCode,
  };
}

class User {
  final String id;
  final String email;
  final String phone;
  final String fullName;
  final String firstName;
  final String lastName;
  final String role;
  final String status;
  final String kycStatus;
  final String? profileImageUrl;
  final String? emiratesId;
  final String? passportNumber;
  final String? nationality;
  final DateTime? dateOfBirth;
  final Address? address;
  final String? referralCode;
  final String? referredBy;
  final String? assignedAdvisor;
  final DateTime? lastLoginAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.status,
    required this.kycStatus,
    this.profileImageUrl,
    this.emiratesId,
    this.passportNumber,
    this.nationality,
    this.dateOfBirth,
    this.address,
    this.referralCode,
    this.referredBy,
    this.assignedAdvisor,
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['_id'] ?? json['id'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    fullName: json['fullName'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    role: json['role'] ?? '',
    status: json['status'] ?? 'pending',
    kycStatus: json['kycStatus'] ?? 'not_started',
    profileImageUrl: json['profileImageUrl'],
    emiratesId: json['emiratesId'],
    passportNumber: json['passportNumber'],
    nationality: json['nationality'],
    dateOfBirth: json['dateOfBirth'] != null ? DateTime.tryParse(json['dateOfBirth']) : null,
    address: json['address'] != null ? Address.fromJson(json['address']) : null,
    referralCode: json['referralCode'],
    referredBy: json['referredBy'],
    assignedAdvisor: json['assignedAdvisor'],
    lastLoginAt: json['lastLoginAt'] != null ? DateTime.tryParse(json['lastLoginAt']) : null,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
  );

  String get displayName => fullName.isNotEmpty ? fullName : '$firstName $lastName';
  bool get isAdmin => role == 'admin';
  bool get isIntroducer => role == 'introducer';
  bool get isAdvisor => role == 'advisor';
  bool get isCustomer => role == 'customer';
  bool get isInvestor => role == 'investor';
}
