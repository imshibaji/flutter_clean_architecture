class Contact {
  int? id;
  String? name;
  String? email;
  String? mobile;
  Status? status;
  Contact({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.status,
  });
}

enum Status {
  none,
  pending,
}
