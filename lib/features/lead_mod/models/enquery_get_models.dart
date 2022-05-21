import 'dart:convert';

class EnquerySingle {
  EnqueryData? data;
  MetaData? meta;
  EnquerySingle({
    this.data,
    this.meta,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data?.toMap(),
      'meta': meta?.toMap(),
    };
  }

  factory EnquerySingle.fromMap(Map<String, dynamic> map) {
    return EnquerySingle(
      data: map['data'] != null ? EnqueryData.fromMap(map['data']) : null,
      meta: map['meta'] != null ? MetaData.fromMap(map['meta']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnquerySingle.fromJson(String source) =>
      EnquerySingle.fromMap(json.decode(source));
}

class Enquery {
  List<EnqueryData>? data;
  MetaData? meta;
  Enquery({
    this.data,
    this.meta,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data?.map((x) => x.toMap()).toList(),
      'meta': meta?.toMap(),
    };
  }

  factory Enquery.fromMap(Map<String, dynamic> map) {
    return Enquery(
      data: map['data'] != null
          ? List<EnqueryData>.from(
              map['data']?.map((x) => EnqueryData.fromMap(x)))
          : null,
      meta: map['meta'] != null ? MetaData.fromMap(map['meta']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Enquery.fromJson(String source) =>
      Enquery.fromMap(json.decode(source));
}

class MetaData {
  Pagination? pagination;
  MetaData({
    this.pagination,
  });

  Map<String, dynamic> toMap() {
    return {
      'pagination': pagination?.toMap(),
    };
  }

  factory MetaData.fromMap(Map<String, dynamic> map) {
    return MetaData(
      pagination: map['pagination'] != null
          ? Pagination.fromMap(map['pagination'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MetaData.fromJson(String source) =>
      MetaData.fromMap(json.decode(source));
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;
  Pagination({
    this.page,
    this.pageSize,
    this.pageCount,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pageSize,
      'pageCount': pageCount,
      'total': total,
    };
  }

  factory Pagination.fromMap(Map<String, dynamic> map) {
    return Pagination(
      page: map['page']?.toInt(),
      pageSize: map['pageSize']?.toInt(),
      pageCount: map['pageCount']?.toInt(),
      total: map['total']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pagination.fromJson(String source) =>
      Pagination.fromMap(json.decode(source));
}

class EnqueryData {
  int? id;
  Lead? attributes;
  EnqueryData({
    this.id,
    this.attributes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'attributes': attributes?.toMap(),
    };
  }

  factory EnqueryData.fromMap(Map<String, dynamic> map) {
    return EnqueryData(
      id: map['id']?.toInt(),
      attributes:
          map['attributes'] != null ? Lead.fromMap(map['attributes']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnqueryData.fromJson(String source) =>
      EnqueryData.fromMap(json.decode(source));
}

class Lead {
  String? purpose;
  // ignore: non_constant_identifier_names
  String? customer_name;
  // ignore: non_constant_identifier_names
  String? customer_email;
  // ignore: non_constant_identifier_names
  String? customer_mobile;
  String? source;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? status;
  List<Followup>? followup;
  Lead({
    this.purpose,
    // ignore: non_constant_identifier_names
    this.customer_name,
    // ignore: non_constant_identifier_names
    this.customer_email,
    // ignore: non_constant_identifier_names
    this.customer_mobile,
    this.source,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.status,
    this.followup,
  });

  Map<String, dynamic> toMap() {
    return {
      'purpose': purpose,
      'customer_name': customer_name,
      'customer_email': customer_email,
      'customer_mobile': customer_mobile,
      'source': source,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'publishedAt': publishedAt,
      'status': status,
      'followup': followup?.map((x) => x.toMap()).toList(),
    };
  }

  factory Lead.fromMap(Map<String, dynamic> map) {
    return Lead(
      purpose: map['purpose'],
      customer_name: map['customer_name'],
      customer_email: map['customer_email'],
      customer_mobile: map['customer_mobile'],
      source: map['source'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      publishedAt: map['publishedAt'],
      status: map['status'],
      followup: map['followup'] != null
          ? List<Followup>.from(
              map['followup']?.map((x) => Followup.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lead.fromJson(String source) => Lead.fromMap(json.decode(source));
}

class Followup {
  int? id;
  // ignore: non_constant_identifier_names
  String? discuss_details;
  String? status;
  Followup({
    this.id,
    // ignore: non_constant_identifier_names
    this.discuss_details,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'discuss_details': discuss_details,
      'status': status,
    };
  }

  factory Followup.fromMap(Map<String, dynamic> map) {
    return Followup(
      id: map['id']?.toInt(),
      discuss_details: map['discuss_details'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Followup.fromJson(String source) =>
      Followup.fromMap(json.decode(source));
}
