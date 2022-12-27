import 'dart:convert';

ImageUploadResponse imageUploadResponseFromJson(String str) =>
    ImageUploadResponse.fromJson(json.decode(str));

String imageUploadResponseToJson(ImageUploadResponse data) =>
    json.encode(data.toJson());

class ImageUploadResponse {
  ImageUploadResponse({
    String? msg,
    List<Files>? files,
  }) {
    _msg = msg;
    _files = files;
  }

  ImageUploadResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    if (json['files'] != null) {
      _files = [];
      json['files'].forEach((v) {
        _files?.add(Files.fromJson(v));
      });
    }
  }

  String? _msg;
  List<Files>? _files;

  ImageUploadResponse copyWith({
    String? msg,
    List<Files>? files,
  }) =>
      ImageUploadResponse(
        msg: msg ?? _msg,
        files: files ?? _files,
      );

  String? get msg => _msg;

  List<Files>? get files => _files;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    if (_files != null) {
      map['files'] = _files?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// fieldname : "input_files"
/// originalname : "truck.jpg"
/// encoding : "7bit"
/// mimetype : "image/jpeg"
/// newName : "3637b0b8-4da2-4cfd-8f52-92698b5e5156.jpg"
/// size : 94570
/// bucket : "callmylawyerappfiles"
/// key : "public_asset/3637b0b8-4da2-4cfd-8f52-92698b5e5156.jpg"
/// acl : "public-read"
/// contentType : "image/jpeg"
/// contentDisposition : null
/// contentEncoding : null
/// storageClass : "STANDARD"
/// serverSideEncryption : null
/// metadata : null
/// location : "https://callmylawyerappfiles.s3.amazonaws.com/public_asset/3637b0b8-4da2-4cfd-8f52-92698b5e5156.jpg"
/// etag : "\"f660ef32d1bd95a8084efef9048b3949\""

Files filesFromJson(String str) => Files.fromJson(json.decode(str));

String filesToJson(Files data) => json.encode(data.toJson());

class Files {
  Files({
    String? fieldname,
    String? originalname,
    String? encoding,
    String? mimetype,
    String? newName,
    int? size,
    String? bucket,
    String? key,
    String? acl,
    String? contentType,
    dynamic contentDisposition,
    dynamic contentEncoding,
    String? storageClass,
    dynamic serverSideEncryption,
    dynamic metadata,
    String? location,
    String? etag,
  }) {
    _fieldname = fieldname;
    _originalname = originalname;
    _encoding = encoding;
    _mimetype = mimetype;
    _newName = newName;
    _size = size;
    _bucket = bucket;
    _key = key;
    _acl = acl;
    _contentType = contentType;
    _contentDisposition = contentDisposition;
    _contentEncoding = contentEncoding;
    _storageClass = storageClass;
    _serverSideEncryption = serverSideEncryption;
    _metadata = metadata;
    _location = location;
    _etag = etag;
  }

  Files.fromJson(dynamic json) {
    _fieldname = json['fieldname'];
    _originalname = json['originalname'];
    _encoding = json['encoding'];
    _mimetype = json['mimetype'];
    _newName = json['newName'];
    _size = json['size'];
    _bucket = json['bucket'];
    _key = json['key'];
    _acl = json['acl'];
    _contentType = json['contentType'];
    _contentDisposition = json['contentDisposition'];
    _contentEncoding = json['contentEncoding'];
    _storageClass = json['storageClass'];
    _serverSideEncryption = json['serverSideEncryption'];
    _metadata = json['metadata'];
    _location = json['location'];
    _etag = json['etag'];
  }

  String? _fieldname;
  String? _originalname;
  String? _encoding;
  String? _mimetype;
  String? _newName;
  int? _size;
  String? _bucket;
  String? _key;
  String? _acl;
  String? _contentType;
  dynamic _contentDisposition;
  dynamic _contentEncoding;
  String? _storageClass;
  dynamic _serverSideEncryption;
  dynamic _metadata;
  String? _location;
  String? _etag;

  Files copyWith({
    String? fieldname,
    String? originalname,
    String? encoding,
    String? mimetype,
    String? newName,
    int? size,
    String? bucket,
    String? key,
    String? acl,
    String? contentType,
    dynamic contentDisposition,
    dynamic contentEncoding,
    String? storageClass,
    dynamic serverSideEncryption,
    dynamic metadata,
    String? location,
    String? etag,
  }) =>
      Files(
        fieldname: fieldname ?? _fieldname,
        originalname: originalname ?? _originalname,
        encoding: encoding ?? _encoding,
        mimetype: mimetype ?? _mimetype,
        newName: newName ?? _newName,
        size: size ?? _size,
        bucket: bucket ?? _bucket,
        key: key ?? _key,
        acl: acl ?? _acl,
        contentType: contentType ?? _contentType,
        contentDisposition: contentDisposition ?? _contentDisposition,
        contentEncoding: contentEncoding ?? _contentEncoding,
        storageClass: storageClass ?? _storageClass,
        serverSideEncryption: serverSideEncryption ?? _serverSideEncryption,
        metadata: metadata ?? _metadata,
        location: location ?? _location,
        etag: etag ?? _etag,
      );

  String? get fieldname => _fieldname;

  String? get originalname => _originalname;

  String? get encoding => _encoding;

  String? get mimetype => _mimetype;

  String? get newName => _newName;

  int? get size => _size;

  String? get bucket => _bucket;

  String? get key => _key;

  String? get acl => _acl;

  String? get contentType => _contentType;

  dynamic get contentDisposition => _contentDisposition;

  dynamic get contentEncoding => _contentEncoding;

  String? get storageClass => _storageClass;

  dynamic get serverSideEncryption => _serverSideEncryption;

  dynamic get metadata => _metadata;

  String? get location => _location;

  String? get etag => _etag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fieldname'] = _fieldname;
    map['originalname'] = _originalname;
    map['encoding'] = _encoding;
    map['mimetype'] = _mimetype;
    map['newName'] = _newName;
    map['size'] = _size;
    map['bucket'] = _bucket;
    map['key'] = _key;
    map['acl'] = _acl;
    map['contentType'] = _contentType;
    map['contentDisposition'] = _contentDisposition;
    map['contentEncoding'] = _contentEncoding;
    map['storageClass'] = _storageClass;
    map['serverSideEncryption'] = _serverSideEncryption;
    map['metadata'] = _metadata;
    map['location'] = _location;
    map['etag'] = _etag;
    return map;
  }
}
