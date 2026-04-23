class KycApplication {
  final String id;
  final String userId;
  final String fullName;
  final String email;
  final String phone;
  final DateTime? dateOfBirth;
  final String? nationality;
  final String? emiratesId;
  final String? passportNumber;
  final String? emiratesIdFrontUrl;
  final String? emiratesIdBackUrl;
  final String? passportUrl;
  final String? selfieUrl;
  final String? employmentStatus;
  final String? employer;
  final String? annualIncome;
  final String? sourceOfFunds;
  final String? riskProfile;
  final String? investmentExperience;
  final String? investmentObjective;
  final String status;
  final String? reviewNotes;
  final String? rejectionReason;
  final DateTime? submittedAt;
  final DateTime? reviewedAt;
  final DateTime? approvedAt;
  final DateTime? createdAt;

  KycApplication({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    this.dateOfBirth,
    this.nationality,
    this.emiratesId,
    this.passportNumber,
    this.emiratesIdFrontUrl,
    this.emiratesIdBackUrl,
    this.passportUrl,
    this.selfieUrl,
    this.employmentStatus,
    this.employer,
    this.annualIncome,
    this.sourceOfFunds,
    this.riskProfile,
    this.investmentExperience,
    this.investmentObjective,
    required this.status,
    this.reviewNotes,
    this.rejectionReason,
    this.submittedAt,
    this.reviewedAt,
    this.approvedAt,
    this.createdAt,
  });

  factory KycApplication.fromJson(Map<String, dynamic> json) => KycApplication(
    id: json['_id'] ?? json['id'] ?? '',
    userId: json['userId'] ?? '',
    fullName: json['fullName'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    dateOfBirth: json['dateOfBirth'] != null ? DateTime.tryParse(json['dateOfBirth']) : null,
    nationality: json['nationality'],
    emiratesId: json['emiratesId'],
    passportNumber: json['passportNumber'],
    emiratesIdFrontUrl: json['emiratesIdFrontUrl'],
    emiratesIdBackUrl: json['emiratesIdBackUrl'],
    passportUrl: json['passportUrl'],
    selfieUrl: json['selfieUrl'],
    employmentStatus: json['employmentStatus'],
    employer: json['employer'],
    annualIncome: json['annualIncome'],
    sourceOfFunds: json['sourceOfFunds'],
    riskProfile: json['riskProfile'],
    investmentExperience: json['investmentExperience'],
    investmentObjective: json['investmentObjective'],
    status: json['status'] ?? 'not_started',
    reviewNotes: json['reviewNotes'],
    rejectionReason: json['rejectionReason'],
    submittedAt: json['submittedAt'] != null ? DateTime.tryParse(json['submittedAt']) : null,
    reviewedAt: json['reviewedAt'] != null ? DateTime.tryParse(json['reviewedAt']) : null,
    approvedAt: json['approvedAt'] != null ? DateTime.tryParse(json['approvedAt']) : null,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'phone': phone,
    if (dateOfBirth != null) 'dateOfBirth': dateOfBirth!.toIso8601String(),
    if (nationality != null) 'nationality': nationality,
    if (emiratesId != null) 'emiratesId': emiratesId,
    if (passportNumber != null) 'passportNumber': passportNumber,
    if (employmentStatus != null) 'employmentStatus': employmentStatus,
    if (employer != null) 'employer': employer,
    if (annualIncome != null) 'annualIncome': annualIncome,
    if (sourceOfFunds != null) 'sourceOfFunds': sourceOfFunds,
    if (riskProfile != null) 'riskProfile': riskProfile,
    if (investmentExperience != null) 'investmentExperience': investmentExperience,
    if (investmentObjective != null) 'investmentObjective': investmentObjective,
  };
}
