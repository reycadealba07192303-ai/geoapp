// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BranchesTable extends Branches with TableInfo<$BranchesTable, Branch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('kainan'),
  );
  static const VerificationMeta _openingHoursMeta = const VerificationMeta(
    'openingHours',
  );
  @override
  late final GeneratedColumn<String> openingHours = GeneratedColumn<String>(
    'opening_hours',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _websiteMeta = const VerificationMeta(
    'website',
  );
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
    'website',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _operatorNameMeta = const VerificationMeta(
    'operatorName',
  );
  @override
  late final GeneratedColumn<String> operatorName = GeneratedColumn<String>(
    'operator_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cuisineMeta = const VerificationMeta(
    'cuisine',
  );
  @override
  late final GeneratedColumn<String> cuisine = GeneratedColumn<String>(
    'cuisine',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wheelchairMeta = const VerificationMeta(
    'wheelchair',
  );
  @override
  late final GeneratedColumn<String> wheelchair = GeneratedColumn<String>(
    'wheelchair',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outdoorSeatingMeta = const VerificationMeta(
    'outdoorSeating',
  );
  @override
  late final GeneratedColumn<String> outdoorSeating = GeneratedColumn<String>(
    'outdoor_seating',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _internetAccessMeta = const VerificationMeta(
    'internetAccess',
  );
  @override
  late final GeneratedColumn<String> internetAccess = GeneratedColumn<String>(
    'internet_access',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deliveryMeta = const VerificationMeta(
    'delivery',
  );
  @override
  late final GeneratedColumn<String> delivery = GeneratedColumn<String>(
    'delivery',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _takeawayMeta = const VerificationMeta(
    'takeaway',
  );
  @override
  late final GeneratedColumn<String> takeaway = GeneratedColumn<String>(
    'takeaway',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _capacityMeta = const VerificationMeta(
    'capacity',
  );
  @override
  late final GeneratedColumn<String> capacity = GeneratedColumn<String>(
    'capacity',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _facebookMeta = const VerificationMeta(
    'facebook',
  );
  @override
  late final GeneratedColumn<String> facebook = GeneratedColumn<String>(
    'facebook',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instagramMeta = const VerificationMeta(
    'instagram',
  );
  @override
  late final GeneratedColumn<String> instagram = GeneratedColumn<String>(
    'instagram',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    brand,
    name,
    address,
    lat,
    lng,
    category,
    openingHours,
    phone,
    website,
    operatorName,
    email,
    cuisine,
    description,
    wheelchair,
    outdoorSeating,
    internetAccess,
    delivery,
    takeaway,
    capacity,
    facebook,
    instagram,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Branch> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('opening_hours')) {
      context.handle(
        _openingHoursMeta,
        openingHours.isAcceptableOrUnknown(
          data['opening_hours']!,
          _openingHoursMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('website')) {
      context.handle(
        _websiteMeta,
        website.isAcceptableOrUnknown(data['website']!, _websiteMeta),
      );
    }
    if (data.containsKey('operator_name')) {
      context.handle(
        _operatorNameMeta,
        operatorName.isAcceptableOrUnknown(
          data['operator_name']!,
          _operatorNameMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('cuisine')) {
      context.handle(
        _cuisineMeta,
        cuisine.isAcceptableOrUnknown(data['cuisine']!, _cuisineMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('wheelchair')) {
      context.handle(
        _wheelchairMeta,
        wheelchair.isAcceptableOrUnknown(data['wheelchair']!, _wheelchairMeta),
      );
    }
    if (data.containsKey('outdoor_seating')) {
      context.handle(
        _outdoorSeatingMeta,
        outdoorSeating.isAcceptableOrUnknown(
          data['outdoor_seating']!,
          _outdoorSeatingMeta,
        ),
      );
    }
    if (data.containsKey('internet_access')) {
      context.handle(
        _internetAccessMeta,
        internetAccess.isAcceptableOrUnknown(
          data['internet_access']!,
          _internetAccessMeta,
        ),
      );
    }
    if (data.containsKey('delivery')) {
      context.handle(
        _deliveryMeta,
        delivery.isAcceptableOrUnknown(data['delivery']!, _deliveryMeta),
      );
    }
    if (data.containsKey('takeaway')) {
      context.handle(
        _takeawayMeta,
        takeaway.isAcceptableOrUnknown(data['takeaway']!, _takeawayMeta),
      );
    }
    if (data.containsKey('capacity')) {
      context.handle(
        _capacityMeta,
        capacity.isAcceptableOrUnknown(data['capacity']!, _capacityMeta),
      );
    }
    if (data.containsKey('facebook')) {
      context.handle(
        _facebookMeta,
        facebook.isAcceptableOrUnknown(data['facebook']!, _facebookMeta),
      );
    }
    if (data.containsKey('instagram')) {
      context.handle(
        _instagramMeta,
        instagram.isAcceptableOrUnknown(data['instagram']!, _instagramMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Branch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Branch(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lng'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      openingHours: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opening_hours'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      website: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website'],
      ),
      operatorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operator_name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      cuisine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cuisine'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      wheelchair: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wheelchair'],
      ),
      outdoorSeating: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outdoor_seating'],
      ),
      internetAccess: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}internet_access'],
      ),
      delivery: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}delivery'],
      ),
      takeaway: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}takeaway'],
      ),
      capacity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}capacity'],
      ),
      facebook: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}facebook'],
      ),
      instagram: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instagram'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $BranchesTable createAlias(String alias) {
    return $BranchesTable(attachedDatabase, alias);
  }
}

class Branch extends DataClass implements Insertable<Branch> {
  /// `osm-<type>-<id>`.
  final String id;

  /// OSM `brand` tag (e.g. Jollibee); empty when unbranded.
  final String brand;
  final String name;
  final String? address;
  final double lat;
  final double lng;

  /// `PlaceCategory.name` (fastFood, kainan, coffee, …).
  final String category;

  /// Raw OSM `opening_hours`.
  final String? openingHours;
  final String? phone;
  final String? website;
  final String? operatorName;
  final String? email;
  final String? cuisine;
  final String? description;
  final String? wheelchair;
  final String? outdoorSeating;
  final String? internetAccess;
  final String? delivery;
  final String? takeaway;
  final String? capacity;
  final String? facebook;
  final String? instagram;
  final bool isActive;
  const Branch({
    required this.id,
    required this.brand,
    required this.name,
    this.address,
    required this.lat,
    required this.lng,
    required this.category,
    this.openingHours,
    this.phone,
    this.website,
    this.operatorName,
    this.email,
    this.cuisine,
    this.description,
    this.wheelchair,
    this.outdoorSeating,
    this.internetAccess,
    this.delivery,
    this.takeaway,
    this.capacity,
    this.facebook,
    this.instagram,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['brand'] = Variable<String>(brand);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || openingHours != null) {
      map['opening_hours'] = Variable<String>(openingHours);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || operatorName != null) {
      map['operator_name'] = Variable<String>(operatorName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || cuisine != null) {
      map['cuisine'] = Variable<String>(cuisine);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || wheelchair != null) {
      map['wheelchair'] = Variable<String>(wheelchair);
    }
    if (!nullToAbsent || outdoorSeating != null) {
      map['outdoor_seating'] = Variable<String>(outdoorSeating);
    }
    if (!nullToAbsent || internetAccess != null) {
      map['internet_access'] = Variable<String>(internetAccess);
    }
    if (!nullToAbsent || delivery != null) {
      map['delivery'] = Variable<String>(delivery);
    }
    if (!nullToAbsent || takeaway != null) {
      map['takeaway'] = Variable<String>(takeaway);
    }
    if (!nullToAbsent || capacity != null) {
      map['capacity'] = Variable<String>(capacity);
    }
    if (!nullToAbsent || facebook != null) {
      map['facebook'] = Variable<String>(facebook);
    }
    if (!nullToAbsent || instagram != null) {
      map['instagram'] = Variable<String>(instagram);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  BranchesCompanion toCompanion(bool nullToAbsent) {
    return BranchesCompanion(
      id: Value(id),
      brand: Value(brand),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      lat: Value(lat),
      lng: Value(lng),
      category: Value(category),
      openingHours: openingHours == null && nullToAbsent
          ? const Value.absent()
          : Value(openingHours),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      operatorName: operatorName == null && nullToAbsent
          ? const Value.absent()
          : Value(operatorName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      cuisine: cuisine == null && nullToAbsent
          ? const Value.absent()
          : Value(cuisine),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      wheelchair: wheelchair == null && nullToAbsent
          ? const Value.absent()
          : Value(wheelchair),
      outdoorSeating: outdoorSeating == null && nullToAbsent
          ? const Value.absent()
          : Value(outdoorSeating),
      internetAccess: internetAccess == null && nullToAbsent
          ? const Value.absent()
          : Value(internetAccess),
      delivery: delivery == null && nullToAbsent
          ? const Value.absent()
          : Value(delivery),
      takeaway: takeaway == null && nullToAbsent
          ? const Value.absent()
          : Value(takeaway),
      capacity: capacity == null && nullToAbsent
          ? const Value.absent()
          : Value(capacity),
      facebook: facebook == null && nullToAbsent
          ? const Value.absent()
          : Value(facebook),
      instagram: instagram == null && nullToAbsent
          ? const Value.absent()
          : Value(instagram),
      isActive: Value(isActive),
    );
  }

  factory Branch.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Branch(
      id: serializer.fromJson<String>(json['id']),
      brand: serializer.fromJson<String>(json['brand']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      category: serializer.fromJson<String>(json['category']),
      openingHours: serializer.fromJson<String?>(json['openingHours']),
      phone: serializer.fromJson<String?>(json['phone']),
      website: serializer.fromJson<String?>(json['website']),
      operatorName: serializer.fromJson<String?>(json['operatorName']),
      email: serializer.fromJson<String?>(json['email']),
      cuisine: serializer.fromJson<String?>(json['cuisine']),
      description: serializer.fromJson<String?>(json['description']),
      wheelchair: serializer.fromJson<String?>(json['wheelchair']),
      outdoorSeating: serializer.fromJson<String?>(json['outdoorSeating']),
      internetAccess: serializer.fromJson<String?>(json['internetAccess']),
      delivery: serializer.fromJson<String?>(json['delivery']),
      takeaway: serializer.fromJson<String?>(json['takeaway']),
      capacity: serializer.fromJson<String?>(json['capacity']),
      facebook: serializer.fromJson<String?>(json['facebook']),
      instagram: serializer.fromJson<String?>(json['instagram']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'brand': serializer.toJson<String>(brand),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'category': serializer.toJson<String>(category),
      'openingHours': serializer.toJson<String?>(openingHours),
      'phone': serializer.toJson<String?>(phone),
      'website': serializer.toJson<String?>(website),
      'operatorName': serializer.toJson<String?>(operatorName),
      'email': serializer.toJson<String?>(email),
      'cuisine': serializer.toJson<String?>(cuisine),
      'description': serializer.toJson<String?>(description),
      'wheelchair': serializer.toJson<String?>(wheelchair),
      'outdoorSeating': serializer.toJson<String?>(outdoorSeating),
      'internetAccess': serializer.toJson<String?>(internetAccess),
      'delivery': serializer.toJson<String?>(delivery),
      'takeaway': serializer.toJson<String?>(takeaway),
      'capacity': serializer.toJson<String?>(capacity),
      'facebook': serializer.toJson<String?>(facebook),
      'instagram': serializer.toJson<String?>(instagram),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Branch copyWith({
    String? id,
    String? brand,
    String? name,
    Value<String?> address = const Value.absent(),
    double? lat,
    double? lng,
    String? category,
    Value<String?> openingHours = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> website = const Value.absent(),
    Value<String?> operatorName = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> cuisine = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> wheelchair = const Value.absent(),
    Value<String?> outdoorSeating = const Value.absent(),
    Value<String?> internetAccess = const Value.absent(),
    Value<String?> delivery = const Value.absent(),
    Value<String?> takeaway = const Value.absent(),
    Value<String?> capacity = const Value.absent(),
    Value<String?> facebook = const Value.absent(),
    Value<String?> instagram = const Value.absent(),
    bool? isActive,
  }) => Branch(
    id: id ?? this.id,
    brand: brand ?? this.brand,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
    category: category ?? this.category,
    openingHours: openingHours.present ? openingHours.value : this.openingHours,
    phone: phone.present ? phone.value : this.phone,
    website: website.present ? website.value : this.website,
    operatorName: operatorName.present ? operatorName.value : this.operatorName,
    email: email.present ? email.value : this.email,
    cuisine: cuisine.present ? cuisine.value : this.cuisine,
    description: description.present ? description.value : this.description,
    wheelchair: wheelchair.present ? wheelchair.value : this.wheelchair,
    outdoorSeating: outdoorSeating.present
        ? outdoorSeating.value
        : this.outdoorSeating,
    internetAccess: internetAccess.present
        ? internetAccess.value
        : this.internetAccess,
    delivery: delivery.present ? delivery.value : this.delivery,
    takeaway: takeaway.present ? takeaway.value : this.takeaway,
    capacity: capacity.present ? capacity.value : this.capacity,
    facebook: facebook.present ? facebook.value : this.facebook,
    instagram: instagram.present ? instagram.value : this.instagram,
    isActive: isActive ?? this.isActive,
  );
  Branch copyWithCompanion(BranchesCompanion data) {
    return Branch(
      id: data.id.present ? data.id.value : this.id,
      brand: data.brand.present ? data.brand.value : this.brand,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
      category: data.category.present ? data.category.value : this.category,
      openingHours: data.openingHours.present
          ? data.openingHours.value
          : this.openingHours,
      phone: data.phone.present ? data.phone.value : this.phone,
      website: data.website.present ? data.website.value : this.website,
      operatorName: data.operatorName.present
          ? data.operatorName.value
          : this.operatorName,
      email: data.email.present ? data.email.value : this.email,
      cuisine: data.cuisine.present ? data.cuisine.value : this.cuisine,
      description: data.description.present
          ? data.description.value
          : this.description,
      wheelchair: data.wheelchair.present
          ? data.wheelchair.value
          : this.wheelchair,
      outdoorSeating: data.outdoorSeating.present
          ? data.outdoorSeating.value
          : this.outdoorSeating,
      internetAccess: data.internetAccess.present
          ? data.internetAccess.value
          : this.internetAccess,
      delivery: data.delivery.present ? data.delivery.value : this.delivery,
      takeaway: data.takeaway.present ? data.takeaway.value : this.takeaway,
      capacity: data.capacity.present ? data.capacity.value : this.capacity,
      facebook: data.facebook.present ? data.facebook.value : this.facebook,
      instagram: data.instagram.present ? data.instagram.value : this.instagram,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Branch(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('category: $category, ')
          ..write('openingHours: $openingHours, ')
          ..write('phone: $phone, ')
          ..write('website: $website, ')
          ..write('operatorName: $operatorName, ')
          ..write('email: $email, ')
          ..write('cuisine: $cuisine, ')
          ..write('description: $description, ')
          ..write('wheelchair: $wheelchair, ')
          ..write('outdoorSeating: $outdoorSeating, ')
          ..write('internetAccess: $internetAccess, ')
          ..write('delivery: $delivery, ')
          ..write('takeaway: $takeaway, ')
          ..write('capacity: $capacity, ')
          ..write('facebook: $facebook, ')
          ..write('instagram: $instagram, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    brand,
    name,
    address,
    lat,
    lng,
    category,
    openingHours,
    phone,
    website,
    operatorName,
    email,
    cuisine,
    description,
    wheelchair,
    outdoorSeating,
    internetAccess,
    delivery,
    takeaway,
    capacity,
    facebook,
    instagram,
    isActive,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Branch &&
          other.id == this.id &&
          other.brand == this.brand &&
          other.name == this.name &&
          other.address == this.address &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.category == this.category &&
          other.openingHours == this.openingHours &&
          other.phone == this.phone &&
          other.website == this.website &&
          other.operatorName == this.operatorName &&
          other.email == this.email &&
          other.cuisine == this.cuisine &&
          other.description == this.description &&
          other.wheelchair == this.wheelchair &&
          other.outdoorSeating == this.outdoorSeating &&
          other.internetAccess == this.internetAccess &&
          other.delivery == this.delivery &&
          other.takeaway == this.takeaway &&
          other.capacity == this.capacity &&
          other.facebook == this.facebook &&
          other.instagram == this.instagram &&
          other.isActive == this.isActive);
}

class BranchesCompanion extends UpdateCompanion<Branch> {
  final Value<String> id;
  final Value<String> brand;
  final Value<String> name;
  final Value<String?> address;
  final Value<double> lat;
  final Value<double> lng;
  final Value<String> category;
  final Value<String?> openingHours;
  final Value<String?> phone;
  final Value<String?> website;
  final Value<String?> operatorName;
  final Value<String?> email;
  final Value<String?> cuisine;
  final Value<String?> description;
  final Value<String?> wheelchair;
  final Value<String?> outdoorSeating;
  final Value<String?> internetAccess;
  final Value<String?> delivery;
  final Value<String?> takeaway;
  final Value<String?> capacity;
  final Value<String?> facebook;
  final Value<String?> instagram;
  final Value<bool> isActive;
  final Value<int> rowid;
  const BranchesCompanion({
    this.id = const Value.absent(),
    this.brand = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.category = const Value.absent(),
    this.openingHours = const Value.absent(),
    this.phone = const Value.absent(),
    this.website = const Value.absent(),
    this.operatorName = const Value.absent(),
    this.email = const Value.absent(),
    this.cuisine = const Value.absent(),
    this.description = const Value.absent(),
    this.wheelchair = const Value.absent(),
    this.outdoorSeating = const Value.absent(),
    this.internetAccess = const Value.absent(),
    this.delivery = const Value.absent(),
    this.takeaway = const Value.absent(),
    this.capacity = const Value.absent(),
    this.facebook = const Value.absent(),
    this.instagram = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BranchesCompanion.insert({
    required String id,
    required String brand,
    required String name,
    this.address = const Value.absent(),
    required double lat,
    required double lng,
    this.category = const Value.absent(),
    this.openingHours = const Value.absent(),
    this.phone = const Value.absent(),
    this.website = const Value.absent(),
    this.operatorName = const Value.absent(),
    this.email = const Value.absent(),
    this.cuisine = const Value.absent(),
    this.description = const Value.absent(),
    this.wheelchair = const Value.absent(),
    this.outdoorSeating = const Value.absent(),
    this.internetAccess = const Value.absent(),
    this.delivery = const Value.absent(),
    this.takeaway = const Value.absent(),
    this.capacity = const Value.absent(),
    this.facebook = const Value.absent(),
    this.instagram = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       brand = Value(brand),
       name = Value(name),
       lat = Value(lat),
       lng = Value(lng);
  static Insertable<Branch> custom({
    Expression<String>? id,
    Expression<String>? brand,
    Expression<String>? name,
    Expression<String>? address,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<String>? category,
    Expression<String>? openingHours,
    Expression<String>? phone,
    Expression<String>? website,
    Expression<String>? operatorName,
    Expression<String>? email,
    Expression<String>? cuisine,
    Expression<String>? description,
    Expression<String>? wheelchair,
    Expression<String>? outdoorSeating,
    Expression<String>? internetAccess,
    Expression<String>? delivery,
    Expression<String>? takeaway,
    Expression<String>? capacity,
    Expression<String>? facebook,
    Expression<String>? instagram,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brand != null) 'brand': brand,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (category != null) 'category': category,
      if (openingHours != null) 'opening_hours': openingHours,
      if (phone != null) 'phone': phone,
      if (website != null) 'website': website,
      if (operatorName != null) 'operator_name': operatorName,
      if (email != null) 'email': email,
      if (cuisine != null) 'cuisine': cuisine,
      if (description != null) 'description': description,
      if (wheelchair != null) 'wheelchair': wheelchair,
      if (outdoorSeating != null) 'outdoor_seating': outdoorSeating,
      if (internetAccess != null) 'internet_access': internetAccess,
      if (delivery != null) 'delivery': delivery,
      if (takeaway != null) 'takeaway': takeaway,
      if (capacity != null) 'capacity': capacity,
      if (facebook != null) 'facebook': facebook,
      if (instagram != null) 'instagram': instagram,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BranchesCompanion copyWith({
    Value<String>? id,
    Value<String>? brand,
    Value<String>? name,
    Value<String?>? address,
    Value<double>? lat,
    Value<double>? lng,
    Value<String>? category,
    Value<String?>? openingHours,
    Value<String?>? phone,
    Value<String?>? website,
    Value<String?>? operatorName,
    Value<String?>? email,
    Value<String?>? cuisine,
    Value<String?>? description,
    Value<String?>? wheelchair,
    Value<String?>? outdoorSeating,
    Value<String?>? internetAccess,
    Value<String?>? delivery,
    Value<String?>? takeaway,
    Value<String?>? capacity,
    Value<String?>? facebook,
    Value<String?>? instagram,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return BranchesCompanion(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      name: name ?? this.name,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      category: category ?? this.category,
      openingHours: openingHours ?? this.openingHours,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      operatorName: operatorName ?? this.operatorName,
      email: email ?? this.email,
      cuisine: cuisine ?? this.cuisine,
      description: description ?? this.description,
      wheelchair: wheelchair ?? this.wheelchair,
      outdoorSeating: outdoorSeating ?? this.outdoorSeating,
      internetAccess: internetAccess ?? this.internetAccess,
      delivery: delivery ?? this.delivery,
      takeaway: takeaway ?? this.takeaway,
      capacity: capacity ?? this.capacity,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (openingHours.present) {
      map['opening_hours'] = Variable<String>(openingHours.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (operatorName.present) {
      map['operator_name'] = Variable<String>(operatorName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (cuisine.present) {
      map['cuisine'] = Variable<String>(cuisine.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (wheelchair.present) {
      map['wheelchair'] = Variable<String>(wheelchair.value);
    }
    if (outdoorSeating.present) {
      map['outdoor_seating'] = Variable<String>(outdoorSeating.value);
    }
    if (internetAccess.present) {
      map['internet_access'] = Variable<String>(internetAccess.value);
    }
    if (delivery.present) {
      map['delivery'] = Variable<String>(delivery.value);
    }
    if (takeaway.present) {
      map['takeaway'] = Variable<String>(takeaway.value);
    }
    if (capacity.present) {
      map['capacity'] = Variable<String>(capacity.value);
    }
    if (facebook.present) {
      map['facebook'] = Variable<String>(facebook.value);
    }
    if (instagram.present) {
      map['instagram'] = Variable<String>(instagram.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchesCompanion(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('category: $category, ')
          ..write('openingHours: $openingHours, ')
          ..write('phone: $phone, ')
          ..write('website: $website, ')
          ..write('operatorName: $operatorName, ')
          ..write('email: $email, ')
          ..write('cuisine: $cuisine, ')
          ..write('description: $description, ')
          ..write('wheelchair: $wheelchair, ')
          ..write('outdoorSeating: $outdoorSeating, ')
          ..write('internetAccess: $internetAccess, ')
          ..write('delivery: $delivery, ')
          ..write('takeaway: $takeaway, ')
          ..write('capacity: $capacity, ')
          ..write('facebook: $facebook, ')
          ..write('instagram: $instagram, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaceFetchesTable extends PlaceFetches
    with TableInfo<$PlaceFetchesTable, PlaceFetch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaceFetchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _centerLatMeta = const VerificationMeta(
    'centerLat',
  );
  @override
  late final GeneratedColumn<double> centerLat = GeneratedColumn<double>(
    'center_lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _centerLngMeta = const VerificationMeta(
    'centerLng',
  );
  @override
  late final GeneratedColumn<double> centerLng = GeneratedColumn<double>(
    'center_lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _radiusMetersMeta = const VerificationMeta(
    'radiusMeters',
  );
  @override
  late final GeneratedColumn<double> radiusMeters = GeneratedColumn<double>(
    'radius_meters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    centerLat,
    centerLng,
    radiusMeters,
    fetchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'place_fetches';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaceFetch> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('center_lat')) {
      context.handle(
        _centerLatMeta,
        centerLat.isAcceptableOrUnknown(data['center_lat']!, _centerLatMeta),
      );
    } else if (isInserting) {
      context.missing(_centerLatMeta);
    }
    if (data.containsKey('center_lng')) {
      context.handle(
        _centerLngMeta,
        centerLng.isAcceptableOrUnknown(data['center_lng']!, _centerLngMeta),
      );
    } else if (isInserting) {
      context.missing(_centerLngMeta);
    }
    if (data.containsKey('radius_meters')) {
      context.handle(
        _radiusMetersMeta,
        radiusMeters.isAcceptableOrUnknown(
          data['radius_meters']!,
          _radiusMetersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_radiusMetersMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaceFetch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaceFetch(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      centerLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}center_lat'],
      )!,
      centerLng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}center_lng'],
      )!,
      radiusMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}radius_meters'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $PlaceFetchesTable createAlias(String alias) {
    return $PlaceFetchesTable(attachedDatabase, alias);
  }
}

class PlaceFetch extends DataClass implements Insertable<PlaceFetch> {
  final int id;
  final double centerLat;
  final double centerLng;
  final double radiusMeters;
  final DateTime fetchedAt;
  const PlaceFetch({
    required this.id,
    required this.centerLat,
    required this.centerLng,
    required this.radiusMeters,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['center_lat'] = Variable<double>(centerLat);
    map['center_lng'] = Variable<double>(centerLng);
    map['radius_meters'] = Variable<double>(radiusMeters);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  PlaceFetchesCompanion toCompanion(bool nullToAbsent) {
    return PlaceFetchesCompanion(
      id: Value(id),
      centerLat: Value(centerLat),
      centerLng: Value(centerLng),
      radiusMeters: Value(radiusMeters),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory PlaceFetch.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaceFetch(
      id: serializer.fromJson<int>(json['id']),
      centerLat: serializer.fromJson<double>(json['centerLat']),
      centerLng: serializer.fromJson<double>(json['centerLng']),
      radiusMeters: serializer.fromJson<double>(json['radiusMeters']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'centerLat': serializer.toJson<double>(centerLat),
      'centerLng': serializer.toJson<double>(centerLng),
      'radiusMeters': serializer.toJson<double>(radiusMeters),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  PlaceFetch copyWith({
    int? id,
    double? centerLat,
    double? centerLng,
    double? radiusMeters,
    DateTime? fetchedAt,
  }) => PlaceFetch(
    id: id ?? this.id,
    centerLat: centerLat ?? this.centerLat,
    centerLng: centerLng ?? this.centerLng,
    radiusMeters: radiusMeters ?? this.radiusMeters,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  PlaceFetch copyWithCompanion(PlaceFetchesCompanion data) {
    return PlaceFetch(
      id: data.id.present ? data.id.value : this.id,
      centerLat: data.centerLat.present ? data.centerLat.value : this.centerLat,
      centerLng: data.centerLng.present ? data.centerLng.value : this.centerLng,
      radiusMeters: data.radiusMeters.present
          ? data.radiusMeters.value
          : this.radiusMeters,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaceFetch(')
          ..write('id: $id, ')
          ..write('centerLat: $centerLat, ')
          ..write('centerLng: $centerLng, ')
          ..write('radiusMeters: $radiusMeters, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, centerLat, centerLng, radiusMeters, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceFetch &&
          other.id == this.id &&
          other.centerLat == this.centerLat &&
          other.centerLng == this.centerLng &&
          other.radiusMeters == this.radiusMeters &&
          other.fetchedAt == this.fetchedAt);
}

class PlaceFetchesCompanion extends UpdateCompanion<PlaceFetch> {
  final Value<int> id;
  final Value<double> centerLat;
  final Value<double> centerLng;
  final Value<double> radiusMeters;
  final Value<DateTime> fetchedAt;
  const PlaceFetchesCompanion({
    this.id = const Value.absent(),
    this.centerLat = const Value.absent(),
    this.centerLng = const Value.absent(),
    this.radiusMeters = const Value.absent(),
    this.fetchedAt = const Value.absent(),
  });
  PlaceFetchesCompanion.insert({
    this.id = const Value.absent(),
    required double centerLat,
    required double centerLng,
    required double radiusMeters,
    required DateTime fetchedAt,
  }) : centerLat = Value(centerLat),
       centerLng = Value(centerLng),
       radiusMeters = Value(radiusMeters),
       fetchedAt = Value(fetchedAt);
  static Insertable<PlaceFetch> custom({
    Expression<int>? id,
    Expression<double>? centerLat,
    Expression<double>? centerLng,
    Expression<double>? radiusMeters,
    Expression<DateTime>? fetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (centerLat != null) 'center_lat': centerLat,
      if (centerLng != null) 'center_lng': centerLng,
      if (radiusMeters != null) 'radius_meters': radiusMeters,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
    });
  }

  PlaceFetchesCompanion copyWith({
    Value<int>? id,
    Value<double>? centerLat,
    Value<double>? centerLng,
    Value<double>? radiusMeters,
    Value<DateTime>? fetchedAt,
  }) {
    return PlaceFetchesCompanion(
      id: id ?? this.id,
      centerLat: centerLat ?? this.centerLat,
      centerLng: centerLng ?? this.centerLng,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (centerLat.present) {
      map['center_lat'] = Variable<double>(centerLat.value);
    }
    if (centerLng.present) {
      map['center_lng'] = Variable<double>(centerLng.value);
    }
    if (radiusMeters.present) {
      map['radius_meters'] = Variable<double>(radiusMeters.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaceFetchesCompanion(')
          ..write('id: $id, ')
          ..write('centerLat: $centerLat, ')
          ..write('centerLng: $centerLng, ')
          ..write('radiusMeters: $radiusMeters, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }
}

class $ForecastsTable extends Forecasts
    with TableInfo<$ForecastsTable, Forecast> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ForecastsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
    'day_of_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
    'hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _crowdIndexMeta = const VerificationMeta(
    'crowdIndex',
  );
  @override
  late final GeneratedColumn<double> crowdIndex = GeneratedColumn<double>(
    'crowd_index',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.5),
  );
  static const VerificationMeta _sampleCountMeta = const VerificationMeta(
    'sampleCount',
  );
  @override
  late final GeneratedColumn<int> sampleCount = GeneratedColumn<int>(
    'sample_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('estimate'),
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    dayOfWeek,
    hour,
    crowdIndex,
    confidence,
    sampleCount,
    source,
    lastUpdated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'forecasts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Forecast> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('hour')) {
      context.handle(
        _hourMeta,
        hour.isAcceptableOrUnknown(data['hour']!, _hourMeta),
      );
    } else if (isInserting) {
      context.missing(_hourMeta);
    }
    if (data.containsKey('crowd_index')) {
      context.handle(
        _crowdIndexMeta,
        crowdIndex.isAcceptableOrUnknown(data['crowd_index']!, _crowdIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_crowdIndexMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('sample_count')) {
      context.handle(
        _sampleCountMeta,
        sampleCount.isAcceptableOrUnknown(
          data['sample_count']!,
          _sampleCountMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Forecast map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Forecast(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      dayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_week'],
      )!,
      hour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hour'],
      )!,
      crowdIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}crowd_index'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sampleCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sample_count'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      ),
    );
  }

  @override
  $ForecastsTable createAlias(String alias) {
    return $ForecastsTable(attachedDatabase, alias);
  }
}

class Forecast extends DataClass implements Insertable<Forecast> {
  final int id;
  final String branchId;

  /// 1 = Monday … 7 = Sunday (ISO weekday).
  final int dayOfWeek;

  /// 0–23 local hour.
  final int hour;
  final double crowdIndex;
  final double confidence;
  final int sampleCount;
  final String source;
  final DateTime? lastUpdated;
  const Forecast({
    required this.id,
    required this.branchId,
    required this.dayOfWeek,
    required this.hour,
    required this.crowdIndex,
    required this.confidence,
    required this.sampleCount,
    required this.source,
    this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['hour'] = Variable<int>(hour);
    map['crowd_index'] = Variable<double>(crowdIndex);
    map['confidence'] = Variable<double>(confidence);
    map['sample_count'] = Variable<int>(sampleCount);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || lastUpdated != null) {
      map['last_updated'] = Variable<DateTime>(lastUpdated);
    }
    return map;
  }

  ForecastsCompanion toCompanion(bool nullToAbsent) {
    return ForecastsCompanion(
      id: Value(id),
      branchId: Value(branchId),
      dayOfWeek: Value(dayOfWeek),
      hour: Value(hour),
      crowdIndex: Value(crowdIndex),
      confidence: Value(confidence),
      sampleCount: Value(sampleCount),
      source: Value(source),
      lastUpdated: lastUpdated == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdated),
    );
  }

  factory Forecast.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Forecast(
      id: serializer.fromJson<int>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
      hour: serializer.fromJson<int>(json['hour']),
      crowdIndex: serializer.fromJson<double>(json['crowdIndex']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sampleCount: serializer.fromJson<int>(json['sampleCount']),
      source: serializer.fromJson<String>(json['source']),
      lastUpdated: serializer.fromJson<DateTime?>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'branchId': serializer.toJson<String>(branchId),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
      'hour': serializer.toJson<int>(hour),
      'crowdIndex': serializer.toJson<double>(crowdIndex),
      'confidence': serializer.toJson<double>(confidence),
      'sampleCount': serializer.toJson<int>(sampleCount),
      'source': serializer.toJson<String>(source),
      'lastUpdated': serializer.toJson<DateTime?>(lastUpdated),
    };
  }

  Forecast copyWith({
    int? id,
    String? branchId,
    int? dayOfWeek,
    int? hour,
    double? crowdIndex,
    double? confidence,
    int? sampleCount,
    String? source,
    Value<DateTime?> lastUpdated = const Value.absent(),
  }) => Forecast(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    hour: hour ?? this.hour,
    crowdIndex: crowdIndex ?? this.crowdIndex,
    confidence: confidence ?? this.confidence,
    sampleCount: sampleCount ?? this.sampleCount,
    source: source ?? this.source,
    lastUpdated: lastUpdated.present ? lastUpdated.value : this.lastUpdated,
  );
  Forecast copyWithCompanion(ForecastsCompanion data) {
    return Forecast(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      hour: data.hour.present ? data.hour.value : this.hour,
      crowdIndex: data.crowdIndex.present
          ? data.crowdIndex.value
          : this.crowdIndex,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sampleCount: data.sampleCount.present
          ? data.sampleCount.value
          : this.sampleCount,
      source: data.source.present ? data.source.value : this.source,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Forecast(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('hour: $hour, ')
          ..write('crowdIndex: $crowdIndex, ')
          ..write('confidence: $confidence, ')
          ..write('sampleCount: $sampleCount, ')
          ..write('source: $source, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    branchId,
    dayOfWeek,
    hour,
    crowdIndex,
    confidence,
    sampleCount,
    source,
    lastUpdated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Forecast &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.dayOfWeek == this.dayOfWeek &&
          other.hour == this.hour &&
          other.crowdIndex == this.crowdIndex &&
          other.confidence == this.confidence &&
          other.sampleCount == this.sampleCount &&
          other.source == this.source &&
          other.lastUpdated == this.lastUpdated);
}

class ForecastsCompanion extends UpdateCompanion<Forecast> {
  final Value<int> id;
  final Value<String> branchId;
  final Value<int> dayOfWeek;
  final Value<int> hour;
  final Value<double> crowdIndex;
  final Value<double> confidence;
  final Value<int> sampleCount;
  final Value<String> source;
  final Value<DateTime?> lastUpdated;
  const ForecastsCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.hour = const Value.absent(),
    this.crowdIndex = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sampleCount = const Value.absent(),
    this.source = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  ForecastsCompanion.insert({
    this.id = const Value.absent(),
    required String branchId,
    required int dayOfWeek,
    required int hour,
    required double crowdIndex,
    this.confidence = const Value.absent(),
    this.sampleCount = const Value.absent(),
    this.source = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  }) : branchId = Value(branchId),
       dayOfWeek = Value(dayOfWeek),
       hour = Value(hour),
       crowdIndex = Value(crowdIndex);
  static Insertable<Forecast> custom({
    Expression<int>? id,
    Expression<String>? branchId,
    Expression<int>? dayOfWeek,
    Expression<int>? hour,
    Expression<double>? crowdIndex,
    Expression<double>? confidence,
    Expression<int>? sampleCount,
    Expression<String>? source,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (hour != null) 'hour': hour,
      if (crowdIndex != null) 'crowd_index': crowdIndex,
      if (confidence != null) 'confidence': confidence,
      if (sampleCount != null) 'sample_count': sampleCount,
      if (source != null) 'source': source,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  ForecastsCompanion copyWith({
    Value<int>? id,
    Value<String>? branchId,
    Value<int>? dayOfWeek,
    Value<int>? hour,
    Value<double>? crowdIndex,
    Value<double>? confidence,
    Value<int>? sampleCount,
    Value<String>? source,
    Value<DateTime?>? lastUpdated,
  }) {
    return ForecastsCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      hour: hour ?? this.hour,
      crowdIndex: crowdIndex ?? this.crowdIndex,
      confidence: confidence ?? this.confidence,
      sampleCount: sampleCount ?? this.sampleCount,
      source: source ?? this.source,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (crowdIndex.present) {
      map['crowd_index'] = Variable<double>(crowdIndex.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sampleCount.present) {
      map['sample_count'] = Variable<int>(sampleCount.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ForecastsCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('hour: $hour, ')
          ..write('crowdIndex: $crowdIndex, ')
          ..write('confidence: $confidence, ')
          ..write('sampleCount: $sampleCount, ')
          ..write('source: $source, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $ObservationsTable extends Observations
    with TableInfo<$ObservationsTable, Observation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObservationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _observedAtMeta = const VerificationMeta(
    'observedAt',
  );
  @override
  late final GeneratedColumn<DateTime> observedAt = GeneratedColumn<DateTime>(
    'observed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _crowdLevelMeta = const VerificationMeta(
    'crowdLevel',
  );
  @override
  late final GeneratedColumn<int> crowdLevel = GeneratedColumn<int>(
    'crowd_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queueLengthMeta = const VerificationMeta(
    'queueLength',
  );
  @override
  late final GeneratedColumn<int> queueLength = GeneratedColumn<int>(
    'queue_length',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observerIdMeta = const VerificationMeta(
    'observerId',
  );
  @override
  late final GeneratedColumn<String> observerId = GeneratedColumn<String>(
    'observer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    observedAt,
    crowdLevel,
    queueLength,
    notes,
    observerId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'observations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Observation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('observed_at')) {
      context.handle(
        _observedAtMeta,
        observedAt.isAcceptableOrUnknown(data['observed_at']!, _observedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_observedAtMeta);
    }
    if (data.containsKey('crowd_level')) {
      context.handle(
        _crowdLevelMeta,
        crowdLevel.isAcceptableOrUnknown(data['crowd_level']!, _crowdLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_crowdLevelMeta);
    }
    if (data.containsKey('queue_length')) {
      context.handle(
        _queueLengthMeta,
        queueLength.isAcceptableOrUnknown(
          data['queue_length']!,
          _queueLengthMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('observer_id')) {
      context.handle(
        _observerIdMeta,
        observerId.isAcceptableOrUnknown(data['observer_id']!, _observerIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Observation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Observation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      observedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}observed_at'],
      )!,
      crowdLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}crowd_level'],
      )!,
      queueLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}queue_length'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      observerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observer_id'],
      ),
    );
  }

  @override
  $ObservationsTable createAlias(String alias) {
    return $ObservationsTable(attachedDatabase, alias);
  }
}

class Observation extends DataClass implements Insertable<Observation> {
  final int id;
  final String branchId;
  final DateTime observedAt;

  /// Observer score 1–5 (1 = empty, 5 = packed).
  final int crowdLevel;
  final int? queueLength;
  final String? notes;
  final String? observerId;
  const Observation({
    required this.id,
    required this.branchId,
    required this.observedAt,
    required this.crowdLevel,
    this.queueLength,
    this.notes,
    this.observerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['observed_at'] = Variable<DateTime>(observedAt);
    map['crowd_level'] = Variable<int>(crowdLevel);
    if (!nullToAbsent || queueLength != null) {
      map['queue_length'] = Variable<int>(queueLength);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || observerId != null) {
      map['observer_id'] = Variable<String>(observerId);
    }
    return map;
  }

  ObservationsCompanion toCompanion(bool nullToAbsent) {
    return ObservationsCompanion(
      id: Value(id),
      branchId: Value(branchId),
      observedAt: Value(observedAt),
      crowdLevel: Value(crowdLevel),
      queueLength: queueLength == null && nullToAbsent
          ? const Value.absent()
          : Value(queueLength),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      observerId: observerId == null && nullToAbsent
          ? const Value.absent()
          : Value(observerId),
    );
  }

  factory Observation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Observation(
      id: serializer.fromJson<int>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      observedAt: serializer.fromJson<DateTime>(json['observedAt']),
      crowdLevel: serializer.fromJson<int>(json['crowdLevel']),
      queueLength: serializer.fromJson<int?>(json['queueLength']),
      notes: serializer.fromJson<String?>(json['notes']),
      observerId: serializer.fromJson<String?>(json['observerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'branchId': serializer.toJson<String>(branchId),
      'observedAt': serializer.toJson<DateTime>(observedAt),
      'crowdLevel': serializer.toJson<int>(crowdLevel),
      'queueLength': serializer.toJson<int?>(queueLength),
      'notes': serializer.toJson<String?>(notes),
      'observerId': serializer.toJson<String?>(observerId),
    };
  }

  Observation copyWith({
    int? id,
    String? branchId,
    DateTime? observedAt,
    int? crowdLevel,
    Value<int?> queueLength = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> observerId = const Value.absent(),
  }) => Observation(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    observedAt: observedAt ?? this.observedAt,
    crowdLevel: crowdLevel ?? this.crowdLevel,
    queueLength: queueLength.present ? queueLength.value : this.queueLength,
    notes: notes.present ? notes.value : this.notes,
    observerId: observerId.present ? observerId.value : this.observerId,
  );
  Observation copyWithCompanion(ObservationsCompanion data) {
    return Observation(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      observedAt: data.observedAt.present
          ? data.observedAt.value
          : this.observedAt,
      crowdLevel: data.crowdLevel.present
          ? data.crowdLevel.value
          : this.crowdLevel,
      queueLength: data.queueLength.present
          ? data.queueLength.value
          : this.queueLength,
      notes: data.notes.present ? data.notes.value : this.notes,
      observerId: data.observerId.present
          ? data.observerId.value
          : this.observerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Observation(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('observedAt: $observedAt, ')
          ..write('crowdLevel: $crowdLevel, ')
          ..write('queueLength: $queueLength, ')
          ..write('notes: $notes, ')
          ..write('observerId: $observerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    branchId,
    observedAt,
    crowdLevel,
    queueLength,
    notes,
    observerId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Observation &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.observedAt == this.observedAt &&
          other.crowdLevel == this.crowdLevel &&
          other.queueLength == this.queueLength &&
          other.notes == this.notes &&
          other.observerId == this.observerId);
}

class ObservationsCompanion extends UpdateCompanion<Observation> {
  final Value<int> id;
  final Value<String> branchId;
  final Value<DateTime> observedAt;
  final Value<int> crowdLevel;
  final Value<int?> queueLength;
  final Value<String?> notes;
  final Value<String?> observerId;
  const ObservationsCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.observedAt = const Value.absent(),
    this.crowdLevel = const Value.absent(),
    this.queueLength = const Value.absent(),
    this.notes = const Value.absent(),
    this.observerId = const Value.absent(),
  });
  ObservationsCompanion.insert({
    this.id = const Value.absent(),
    required String branchId,
    required DateTime observedAt,
    required int crowdLevel,
    this.queueLength = const Value.absent(),
    this.notes = const Value.absent(),
    this.observerId = const Value.absent(),
  }) : branchId = Value(branchId),
       observedAt = Value(observedAt),
       crowdLevel = Value(crowdLevel);
  static Insertable<Observation> custom({
    Expression<int>? id,
    Expression<String>? branchId,
    Expression<DateTime>? observedAt,
    Expression<int>? crowdLevel,
    Expression<int>? queueLength,
    Expression<String>? notes,
    Expression<String>? observerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (observedAt != null) 'observed_at': observedAt,
      if (crowdLevel != null) 'crowd_level': crowdLevel,
      if (queueLength != null) 'queue_length': queueLength,
      if (notes != null) 'notes': notes,
      if (observerId != null) 'observer_id': observerId,
    });
  }

  ObservationsCompanion copyWith({
    Value<int>? id,
    Value<String>? branchId,
    Value<DateTime>? observedAt,
    Value<int>? crowdLevel,
    Value<int?>? queueLength,
    Value<String?>? notes,
    Value<String?>? observerId,
  }) {
    return ObservationsCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      observedAt: observedAt ?? this.observedAt,
      crowdLevel: crowdLevel ?? this.crowdLevel,
      queueLength: queueLength ?? this.queueLength,
      notes: notes ?? this.notes,
      observerId: observerId ?? this.observerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (observedAt.present) {
      map['observed_at'] = Variable<DateTime>(observedAt.value);
    }
    if (crowdLevel.present) {
      map['crowd_level'] = Variable<int>(crowdLevel.value);
    }
    if (queueLength.present) {
      map['queue_length'] = Variable<int>(queueLength.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (observerId.present) {
      map['observer_id'] = Variable<String>(observerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObservationsCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('observedAt: $observedAt, ')
          ..write('crowdLevel: $crowdLevel, ')
          ..write('queueLength: $queueLength, ')
          ..write('notes: $notes, ')
          ..write('observerId: $observerId')
          ..write(')'))
        .toString();
  }
}

class $UserReportsTable extends UserReports
    with TableInfo<$UserReportsTable, UserReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _reportedAtMeta = const VerificationMeta(
    'reportedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reportedAt = GeneratedColumn<DateTime>(
    'reported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _crowdLevelMeta = const VerificationMeta(
    'crowdLevel',
  );
  @override
  late final GeneratedColumn<int> crowdLevel = GeneratedColumn<int>(
    'crowd_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    reportedAt,
    crowdLevel,
    note,
    synced,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('reported_at')) {
      context.handle(
        _reportedAtMeta,
        reportedAt.isAcceptableOrUnknown(data['reported_at']!, _reportedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reportedAtMeta);
    }
    if (data.containsKey('crowd_level')) {
      context.handle(
        _crowdLevelMeta,
        crowdLevel.isAcceptableOrUnknown(data['crowd_level']!, _crowdLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_crowdLevelMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      reportedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reported_at'],
      )!,
      crowdLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}crowd_level'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $UserReportsTable createAlias(String alias) {
    return $UserReportsTable(attachedDatabase, alias);
  }
}

class UserReport extends DataClass implements Insertable<UserReport> {
  final String id;
  final String branchId;
  final DateTime reportedAt;

  /// User score 1–5.
  final int crowdLevel;
  final String? note;
  final bool synced;
  final DateTime? syncedAt;
  const UserReport({
    required this.id,
    required this.branchId,
    required this.reportedAt,
    required this.crowdLevel,
    this.note,
    required this.synced,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['reported_at'] = Variable<DateTime>(reportedAt);
    map['crowd_level'] = Variable<int>(crowdLevel);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  UserReportsCompanion toCompanion(bool nullToAbsent) {
    return UserReportsCompanion(
      id: Value(id),
      branchId: Value(branchId),
      reportedAt: Value(reportedAt),
      crowdLevel: Value(crowdLevel),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory UserReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserReport(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      reportedAt: serializer.fromJson<DateTime>(json['reportedAt']),
      crowdLevel: serializer.fromJson<int>(json['crowdLevel']),
      note: serializer.fromJson<String?>(json['note']),
      synced: serializer.fromJson<bool>(json['synced']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'reportedAt': serializer.toJson<DateTime>(reportedAt),
      'crowdLevel': serializer.toJson<int>(crowdLevel),
      'note': serializer.toJson<String?>(note),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  UserReport copyWith({
    String? id,
    String? branchId,
    DateTime? reportedAt,
    int? crowdLevel,
    Value<String?> note = const Value.absent(),
    bool? synced,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => UserReport(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    reportedAt: reportedAt ?? this.reportedAt,
    crowdLevel: crowdLevel ?? this.crowdLevel,
    note: note.present ? note.value : this.note,
    synced: synced ?? this.synced,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  UserReport copyWithCompanion(UserReportsCompanion data) {
    return UserReport(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      reportedAt: data.reportedAt.present
          ? data.reportedAt.value
          : this.reportedAt,
      crowdLevel: data.crowdLevel.present
          ? data.crowdLevel.value
          : this.crowdLevel,
      note: data.note.present ? data.note.value : this.note,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserReport(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('reportedAt: $reportedAt, ')
          ..write('crowdLevel: $crowdLevel, ')
          ..write('note: $note, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, branchId, reportedAt, crowdLevel, note, synced, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserReport &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.reportedAt == this.reportedAt &&
          other.crowdLevel == this.crowdLevel &&
          other.note == this.note &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt);
}

class UserReportsCompanion extends UpdateCompanion<UserReport> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<DateTime> reportedAt;
  final Value<int> crowdLevel;
  final Value<String?> note;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const UserReportsCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.reportedAt = const Value.absent(),
    this.crowdLevel = const Value.absent(),
    this.note = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserReportsCompanion.insert({
    required String id,
    required String branchId,
    required DateTime reportedAt,
    required int crowdLevel,
    this.note = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       reportedAt = Value(reportedAt),
       crowdLevel = Value(crowdLevel);
  static Insertable<UserReport> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<DateTime>? reportedAt,
    Expression<int>? crowdLevel,
    Expression<String>? note,
    Expression<bool>? synced,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (reportedAt != null) 'reported_at': reportedAt,
      if (crowdLevel != null) 'crowd_level': crowdLevel,
      if (note != null) 'note': note,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserReportsCompanion copyWith({
    Value<String>? id,
    Value<String>? branchId,
    Value<DateTime>? reportedAt,
    Value<int>? crowdLevel,
    Value<String?>? note,
    Value<bool>? synced,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return UserReportsCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      reportedAt: reportedAt ?? this.reportedAt,
      crowdLevel: crowdLevel ?? this.crowdLevel,
      note: note ?? this.note,
      synced: synced ?? this.synced,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (reportedAt.present) {
      map['reported_at'] = Variable<DateTime>(reportedAt.value);
    }
    if (crowdLevel.present) {
      map['crowd_level'] = Variable<int>(crowdLevel.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserReportsCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('reportedAt: $reportedAt, ')
          ..write('crowdLevel: $crowdLevel, ')
          ..write('note: $note, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BranchesTable branches = $BranchesTable(this);
  late final $PlaceFetchesTable placeFetches = $PlaceFetchesTable(this);
  late final $ForecastsTable forecasts = $ForecastsTable(this);
  late final $ObservationsTable observations = $ObservationsTable(this);
  late final $UserReportsTable userReports = $UserReportsTable(this);
  late final BranchesDao branchesDao = BranchesDao(this as AppDatabase);
  late final ForecastsDao forecastsDao = ForecastsDao(this as AppDatabase);
  late final ObservationsDao observationsDao = ObservationsDao(
    this as AppDatabase,
  );
  late final UserReportsDao userReportsDao = UserReportsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    branches,
    placeFetches,
    forecasts,
    observations,
    userReports,
  ];
}

typedef $$BranchesTableCreateCompanionBuilder =
    BranchesCompanion Function({
      required String id,
      required String brand,
      required String name,
      Value<String?> address,
      required double lat,
      required double lng,
      Value<String> category,
      Value<String?> openingHours,
      Value<String?> phone,
      Value<String?> website,
      Value<String?> operatorName,
      Value<String?> email,
      Value<String?> cuisine,
      Value<String?> description,
      Value<String?> wheelchair,
      Value<String?> outdoorSeating,
      Value<String?> internetAccess,
      Value<String?> delivery,
      Value<String?> takeaway,
      Value<String?> capacity,
      Value<String?> facebook,
      Value<String?> instagram,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$BranchesTableUpdateCompanionBuilder =
    BranchesCompanion Function({
      Value<String> id,
      Value<String> brand,
      Value<String> name,
      Value<String?> address,
      Value<double> lat,
      Value<double> lng,
      Value<String> category,
      Value<String?> openingHours,
      Value<String?> phone,
      Value<String?> website,
      Value<String?> operatorName,
      Value<String?> email,
      Value<String?> cuisine,
      Value<String?> description,
      Value<String?> wheelchair,
      Value<String?> outdoorSeating,
      Value<String?> internetAccess,
      Value<String?> delivery,
      Value<String?> takeaway,
      Value<String?> capacity,
      Value<String?> facebook,
      Value<String?> instagram,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$BranchesTableReferences
    extends BaseReferences<_$AppDatabase, $BranchesTable, Branch> {
  $$BranchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ForecastsTable, List<Forecast>>
  _forecastsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.forecasts,
    aliasName: 'branches__id__forecasts__branch_id',
  );

  $$ForecastsTableProcessedTableManager get forecastsRefs {
    final manager = $$ForecastsTableTableManager(
      $_db,
      $_db.forecasts,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_forecastsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ObservationsTable, List<Observation>>
  _observationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.observations,
    aliasName: 'branches__id__observations__branch_id',
  );

  $$ObservationsTableProcessedTableManager get observationsRefs {
    final manager = $$ObservationsTableTableManager(
      $_db,
      $_db.observations,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_observationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserReportsTable, List<UserReport>>
  _userReportsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userReports,
    aliasName: 'branches__id__user_reports__branch_id',
  );

  $$UserReportsTableProcessedTableManager get userReportsRefs {
    final manager = $$UserReportsTableTableManager(
      $_db,
      $_db.userReports,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userReportsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BranchesTableFilterComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cuisine => $composableBuilder(
    column: $table.cuisine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wheelchair => $composableBuilder(
    column: $table.wheelchair,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outdoorSeating => $composableBuilder(
    column: $table.outdoorSeating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get internetAccess => $composableBuilder(
    column: $table.internetAccess,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get delivery => $composableBuilder(
    column: $table.delivery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get takeaway => $composableBuilder(
    column: $table.takeaway,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get capacity => $composableBuilder(
    column: $table.capacity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get facebook => $composableBuilder(
    column: $table.facebook,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instagram => $composableBuilder(
    column: $table.instagram,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> forecastsRefs(
    Expression<bool> Function($$ForecastsTableFilterComposer f) f,
  ) {
    final $$ForecastsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.forecasts,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ForecastsTableFilterComposer(
            $db: $db,
            $table: $db.forecasts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> observationsRefs(
    Expression<bool> Function($$ObservationsTableFilterComposer f) f,
  ) {
    final $$ObservationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.observations,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationsTableFilterComposer(
            $db: $db,
            $table: $db.observations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userReportsRefs(
    Expression<bool> Function($$UserReportsTableFilterComposer f) f,
  ) {
    final $$UserReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userReports,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserReportsTableFilterComposer(
            $db: $db,
            $table: $db.userReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BranchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cuisine => $composableBuilder(
    column: $table.cuisine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wheelchair => $composableBuilder(
    column: $table.wheelchair,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outdoorSeating => $composableBuilder(
    column: $table.outdoorSeating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get internetAccess => $composableBuilder(
    column: $table.internetAccess,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get delivery => $composableBuilder(
    column: $table.delivery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get takeaway => $composableBuilder(
    column: $table.takeaway,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get capacity => $composableBuilder(
    column: $table.capacity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get facebook => $composableBuilder(
    column: $table.facebook,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instagram => $composableBuilder(
    column: $table.instagram,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BranchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get cuisine =>
      $composableBuilder(column: $table.cuisine, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wheelchair => $composableBuilder(
    column: $table.wheelchair,
    builder: (column) => column,
  );

  GeneratedColumn<String> get outdoorSeating => $composableBuilder(
    column: $table.outdoorSeating,
    builder: (column) => column,
  );

  GeneratedColumn<String> get internetAccess => $composableBuilder(
    column: $table.internetAccess,
    builder: (column) => column,
  );

  GeneratedColumn<String> get delivery =>
      $composableBuilder(column: $table.delivery, builder: (column) => column);

  GeneratedColumn<String> get takeaway =>
      $composableBuilder(column: $table.takeaway, builder: (column) => column);

  GeneratedColumn<String> get capacity =>
      $composableBuilder(column: $table.capacity, builder: (column) => column);

  GeneratedColumn<String> get facebook =>
      $composableBuilder(column: $table.facebook, builder: (column) => column);

  GeneratedColumn<String> get instagram =>
      $composableBuilder(column: $table.instagram, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> forecastsRefs<T extends Object>(
    Expression<T> Function($$ForecastsTableAnnotationComposer a) f,
  ) {
    final $$ForecastsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.forecasts,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ForecastsTableAnnotationComposer(
            $db: $db,
            $table: $db.forecasts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> observationsRefs<T extends Object>(
    Expression<T> Function($$ObservationsTableAnnotationComposer a) f,
  ) {
    final $$ObservationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.observations,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObservationsTableAnnotationComposer(
            $db: $db,
            $table: $db.observations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userReportsRefs<T extends Object>(
    Expression<T> Function($$UserReportsTableAnnotationComposer a) f,
  ) {
    final $$UserReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userReports,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.userReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BranchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BranchesTable,
          Branch,
          $$BranchesTableFilterComposer,
          $$BranchesTableOrderingComposer,
          $$BranchesTableAnnotationComposer,
          $$BranchesTableCreateCompanionBuilder,
          $$BranchesTableUpdateCompanionBuilder,
          (Branch, $$BranchesTableReferences),
          Branch,
          PrefetchHooks Function({
            bool forecastsRefs,
            bool observationsRefs,
            bool userReportsRefs,
          })
        > {
  $$BranchesTableTableManager(_$AppDatabase db, $BranchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lng = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> openingHours = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> operatorName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> cuisine = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> wheelchair = const Value.absent(),
                Value<String?> outdoorSeating = const Value.absent(),
                Value<String?> internetAccess = const Value.absent(),
                Value<String?> delivery = const Value.absent(),
                Value<String?> takeaway = const Value.absent(),
                Value<String?> capacity = const Value.absent(),
                Value<String?> facebook = const Value.absent(),
                Value<String?> instagram = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchesCompanion(
                id: id,
                brand: brand,
                name: name,
                address: address,
                lat: lat,
                lng: lng,
                category: category,
                openingHours: openingHours,
                phone: phone,
                website: website,
                operatorName: operatorName,
                email: email,
                cuisine: cuisine,
                description: description,
                wheelchair: wheelchair,
                outdoorSeating: outdoorSeating,
                internetAccess: internetAccess,
                delivery: delivery,
                takeaway: takeaway,
                capacity: capacity,
                facebook: facebook,
                instagram: instagram,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String brand,
                required String name,
                Value<String?> address = const Value.absent(),
                required double lat,
                required double lng,
                Value<String> category = const Value.absent(),
                Value<String?> openingHours = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> operatorName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> cuisine = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> wheelchair = const Value.absent(),
                Value<String?> outdoorSeating = const Value.absent(),
                Value<String?> internetAccess = const Value.absent(),
                Value<String?> delivery = const Value.absent(),
                Value<String?> takeaway = const Value.absent(),
                Value<String?> capacity = const Value.absent(),
                Value<String?> facebook = const Value.absent(),
                Value<String?> instagram = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchesCompanion.insert(
                id: id,
                brand: brand,
                name: name,
                address: address,
                lat: lat,
                lng: lng,
                category: category,
                openingHours: openingHours,
                phone: phone,
                website: website,
                operatorName: operatorName,
                email: email,
                cuisine: cuisine,
                description: description,
                wheelchair: wheelchair,
                outdoorSeating: outdoorSeating,
                internetAccess: internetAccess,
                delivery: delivery,
                takeaway: takeaway,
                capacity: capacity,
                facebook: facebook,
                instagram: instagram,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BranchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                forecastsRefs = false,
                observationsRefs = false,
                userReportsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (forecastsRefs) db.forecasts,
                    if (observationsRefs) db.observations,
                    if (userReportsRefs) db.userReports,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (forecastsRefs)
                        await $_getPrefetchedData<
                          Branch,
                          $BranchesTable,
                          Forecast
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._forecastsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).forecastsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (observationsRefs)
                        await $_getPrefetchedData<
                          Branch,
                          $BranchesTable,
                          Observation
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._observationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).observationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userReportsRefs)
                        await $_getPrefetchedData<
                          Branch,
                          $BranchesTable,
                          UserReport
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._userReportsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).userReportsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BranchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BranchesTable,
      Branch,
      $$BranchesTableFilterComposer,
      $$BranchesTableOrderingComposer,
      $$BranchesTableAnnotationComposer,
      $$BranchesTableCreateCompanionBuilder,
      $$BranchesTableUpdateCompanionBuilder,
      (Branch, $$BranchesTableReferences),
      Branch,
      PrefetchHooks Function({
        bool forecastsRefs,
        bool observationsRefs,
        bool userReportsRefs,
      })
    >;
typedef $$PlaceFetchesTableCreateCompanionBuilder =
    PlaceFetchesCompanion Function({
      Value<int> id,
      required double centerLat,
      required double centerLng,
      required double radiusMeters,
      required DateTime fetchedAt,
    });
typedef $$PlaceFetchesTableUpdateCompanionBuilder =
    PlaceFetchesCompanion Function({
      Value<int> id,
      Value<double> centerLat,
      Value<double> centerLng,
      Value<double> radiusMeters,
      Value<DateTime> fetchedAt,
    });

class $$PlaceFetchesTableFilterComposer
    extends Composer<_$AppDatabase, $PlaceFetchesTable> {
  $$PlaceFetchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get centerLat => $composableBuilder(
    column: $table.centerLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get centerLng => $composableBuilder(
    column: $table.centerLng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get radiusMeters => $composableBuilder(
    column: $table.radiusMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlaceFetchesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaceFetchesTable> {
  $$PlaceFetchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get centerLat => $composableBuilder(
    column: $table.centerLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get centerLng => $composableBuilder(
    column: $table.centerLng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get radiusMeters => $composableBuilder(
    column: $table.radiusMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlaceFetchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaceFetchesTable> {
  $$PlaceFetchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get centerLat =>
      $composableBuilder(column: $table.centerLat, builder: (column) => column);

  GeneratedColumn<double> get centerLng =>
      $composableBuilder(column: $table.centerLng, builder: (column) => column);

  GeneratedColumn<double> get radiusMeters => $composableBuilder(
    column: $table.radiusMeters,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$PlaceFetchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlaceFetchesTable,
          PlaceFetch,
          $$PlaceFetchesTableFilterComposer,
          $$PlaceFetchesTableOrderingComposer,
          $$PlaceFetchesTableAnnotationComposer,
          $$PlaceFetchesTableCreateCompanionBuilder,
          $$PlaceFetchesTableUpdateCompanionBuilder,
          (
            PlaceFetch,
            BaseReferences<_$AppDatabase, $PlaceFetchesTable, PlaceFetch>,
          ),
          PlaceFetch,
          PrefetchHooks Function()
        > {
  $$PlaceFetchesTableTableManager(_$AppDatabase db, $PlaceFetchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaceFetchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaceFetchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaceFetchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> centerLat = const Value.absent(),
                Value<double> centerLng = const Value.absent(),
                Value<double> radiusMeters = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => PlaceFetchesCompanion(
                id: id,
                centerLat: centerLat,
                centerLng: centerLng,
                radiusMeters: radiusMeters,
                fetchedAt: fetchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double centerLat,
                required double centerLng,
                required double radiusMeters,
                required DateTime fetchedAt,
              }) => PlaceFetchesCompanion.insert(
                id: id,
                centerLat: centerLat,
                centerLng: centerLng,
                radiusMeters: radiusMeters,
                fetchedAt: fetchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlaceFetchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlaceFetchesTable,
      PlaceFetch,
      $$PlaceFetchesTableFilterComposer,
      $$PlaceFetchesTableOrderingComposer,
      $$PlaceFetchesTableAnnotationComposer,
      $$PlaceFetchesTableCreateCompanionBuilder,
      $$PlaceFetchesTableUpdateCompanionBuilder,
      (
        PlaceFetch,
        BaseReferences<_$AppDatabase, $PlaceFetchesTable, PlaceFetch>,
      ),
      PlaceFetch,
      PrefetchHooks Function()
    >;
typedef $$ForecastsTableCreateCompanionBuilder =
    ForecastsCompanion Function({
      Value<int> id,
      required String branchId,
      required int dayOfWeek,
      required int hour,
      required double crowdIndex,
      Value<double> confidence,
      Value<int> sampleCount,
      Value<String> source,
      Value<DateTime?> lastUpdated,
    });
typedef $$ForecastsTableUpdateCompanionBuilder =
    ForecastsCompanion Function({
      Value<int> id,
      Value<String> branchId,
      Value<int> dayOfWeek,
      Value<int> hour,
      Value<double> crowdIndex,
      Value<double> confidence,
      Value<int> sampleCount,
      Value<String> source,
      Value<DateTime?> lastUpdated,
    });

final class $$ForecastsTableReferences
    extends BaseReferences<_$AppDatabase, $ForecastsTable, Forecast> {
  $$ForecastsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('forecasts__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ForecastsTableFilterComposer
    extends Composer<_$AppDatabase, $ForecastsTable> {
  $$ForecastsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get crowdIndex => $composableBuilder(
    column: $table.crowdIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ForecastsTableOrderingComposer
    extends Composer<_$AppDatabase, $ForecastsTable> {
  $$ForecastsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get crowdIndex => $composableBuilder(
    column: $table.crowdIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ForecastsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ForecastsTable> {
  $$ForecastsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<double> get crowdIndex => $composableBuilder(
    column: $table.crowdIndex,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ForecastsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ForecastsTable,
          Forecast,
          $$ForecastsTableFilterComposer,
          $$ForecastsTableOrderingComposer,
          $$ForecastsTableAnnotationComposer,
          $$ForecastsTableCreateCompanionBuilder,
          $$ForecastsTableUpdateCompanionBuilder,
          (Forecast, $$ForecastsTableReferences),
          Forecast,
          PrefetchHooks Function({bool branchId})
        > {
  $$ForecastsTableTableManager(_$AppDatabase db, $ForecastsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ForecastsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ForecastsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ForecastsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<int> dayOfWeek = const Value.absent(),
                Value<int> hour = const Value.absent(),
                Value<double> crowdIndex = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<int> sampleCount = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime?> lastUpdated = const Value.absent(),
              }) => ForecastsCompanion(
                id: id,
                branchId: branchId,
                dayOfWeek: dayOfWeek,
                hour: hour,
                crowdIndex: crowdIndex,
                confidence: confidence,
                sampleCount: sampleCount,
                source: source,
                lastUpdated: lastUpdated,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String branchId,
                required int dayOfWeek,
                required int hour,
                required double crowdIndex,
                Value<double> confidence = const Value.absent(),
                Value<int> sampleCount = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime?> lastUpdated = const Value.absent(),
              }) => ForecastsCompanion.insert(
                id: id,
                branchId: branchId,
                dayOfWeek: dayOfWeek,
                hour: hour,
                crowdIndex: crowdIndex,
                confidence: confidence,
                sampleCount: sampleCount,
                source: source,
                lastUpdated: lastUpdated,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ForecastsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$ForecastsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$ForecastsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ForecastsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ForecastsTable,
      Forecast,
      $$ForecastsTableFilterComposer,
      $$ForecastsTableOrderingComposer,
      $$ForecastsTableAnnotationComposer,
      $$ForecastsTableCreateCompanionBuilder,
      $$ForecastsTableUpdateCompanionBuilder,
      (Forecast, $$ForecastsTableReferences),
      Forecast,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$ObservationsTableCreateCompanionBuilder =
    ObservationsCompanion Function({
      Value<int> id,
      required String branchId,
      required DateTime observedAt,
      required int crowdLevel,
      Value<int?> queueLength,
      Value<String?> notes,
      Value<String?> observerId,
    });
typedef $$ObservationsTableUpdateCompanionBuilder =
    ObservationsCompanion Function({
      Value<int> id,
      Value<String> branchId,
      Value<DateTime> observedAt,
      Value<int> crowdLevel,
      Value<int?> queueLength,
      Value<String?> notes,
      Value<String?> observerId,
    });

final class $$ObservationsTableReferences
    extends BaseReferences<_$AppDatabase, $ObservationsTable, Observation> {
  $$ObservationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('observations__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ObservationsTableFilterComposer
    extends Composer<_$AppDatabase, $ObservationsTable> {
  $$ObservationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get crowdLevel => $composableBuilder(
    column: $table.crowdLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get queueLength => $composableBuilder(
    column: $table.queueLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observerId => $composableBuilder(
    column: $table.observerId,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ObservationsTable> {
  $$ObservationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get crowdLevel => $composableBuilder(
    column: $table.crowdLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get queueLength => $composableBuilder(
    column: $table.queueLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observerId => $composableBuilder(
    column: $table.observerId,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ObservationsTable> {
  $$ObservationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get observedAt => $composableBuilder(
    column: $table.observedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get crowdLevel => $composableBuilder(
    column: $table.crowdLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get queueLength => $composableBuilder(
    column: $table.queueLength,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get observerId => $composableBuilder(
    column: $table.observerId,
    builder: (column) => column,
  );

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObservationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ObservationsTable,
          Observation,
          $$ObservationsTableFilterComposer,
          $$ObservationsTableOrderingComposer,
          $$ObservationsTableAnnotationComposer,
          $$ObservationsTableCreateCompanionBuilder,
          $$ObservationsTableUpdateCompanionBuilder,
          (Observation, $$ObservationsTableReferences),
          Observation,
          PrefetchHooks Function({bool branchId})
        > {
  $$ObservationsTableTableManager(_$AppDatabase db, $ObservationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ObservationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ObservationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ObservationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<DateTime> observedAt = const Value.absent(),
                Value<int> crowdLevel = const Value.absent(),
                Value<int?> queueLength = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> observerId = const Value.absent(),
              }) => ObservationsCompanion(
                id: id,
                branchId: branchId,
                observedAt: observedAt,
                crowdLevel: crowdLevel,
                queueLength: queueLength,
                notes: notes,
                observerId: observerId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String branchId,
                required DateTime observedAt,
                required int crowdLevel,
                Value<int?> queueLength = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> observerId = const Value.absent(),
              }) => ObservationsCompanion.insert(
                id: id,
                branchId: branchId,
                observedAt: observedAt,
                crowdLevel: crowdLevel,
                queueLength: queueLength,
                notes: notes,
                observerId: observerId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ObservationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$ObservationsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$ObservationsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ObservationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ObservationsTable,
      Observation,
      $$ObservationsTableFilterComposer,
      $$ObservationsTableOrderingComposer,
      $$ObservationsTableAnnotationComposer,
      $$ObservationsTableCreateCompanionBuilder,
      $$ObservationsTableUpdateCompanionBuilder,
      (Observation, $$ObservationsTableReferences),
      Observation,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$UserReportsTableCreateCompanionBuilder =
    UserReportsCompanion Function({
      required String id,
      required String branchId,
      required DateTime reportedAt,
      required int crowdLevel,
      Value<String?> note,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$UserReportsTableUpdateCompanionBuilder =
    UserReportsCompanion Function({
      Value<String> id,
      Value<String> branchId,
      Value<DateTime> reportedAt,
      Value<int> crowdLevel,
      Value<String?> note,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

final class $$UserReportsTableReferences
    extends BaseReferences<_$AppDatabase, $UserReportsTable, UserReport> {
  $$UserReportsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('user_reports__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserReportsTableFilterComposer
    extends Composer<_$AppDatabase, $UserReportsTable> {
  $$UserReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get crowdLevel => $composableBuilder(
    column: $table.crowdLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserReportsTable> {
  $$UserReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get crowdLevel => $composableBuilder(
    column: $table.crowdLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserReportsTable> {
  $$UserReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get crowdLevel => $composableBuilder(
    column: $table.crowdLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserReportsTable,
          UserReport,
          $$UserReportsTableFilterComposer,
          $$UserReportsTableOrderingComposer,
          $$UserReportsTableAnnotationComposer,
          $$UserReportsTableCreateCompanionBuilder,
          $$UserReportsTableUpdateCompanionBuilder,
          (UserReport, $$UserReportsTableReferences),
          UserReport,
          PrefetchHooks Function({bool branchId})
        > {
  $$UserReportsTableTableManager(_$AppDatabase db, $UserReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<DateTime> reportedAt = const Value.absent(),
                Value<int> crowdLevel = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserReportsCompanion(
                id: id,
                branchId: branchId,
                reportedAt: reportedAt,
                crowdLevel: crowdLevel,
                note: note,
                synced: synced,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String branchId,
                required DateTime reportedAt,
                required int crowdLevel,
                Value<String?> note = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserReportsCompanion.insert(
                id: id,
                branchId: branchId,
                reportedAt: reportedAt,
                crowdLevel: crowdLevel,
                note: note,
                synced: synced,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserReportsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$UserReportsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$UserReportsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserReportsTable,
      UserReport,
      $$UserReportsTableFilterComposer,
      $$UserReportsTableOrderingComposer,
      $$UserReportsTableAnnotationComposer,
      $$UserReportsTableCreateCompanionBuilder,
      $$UserReportsTableUpdateCompanionBuilder,
      (UserReport, $$UserReportsTableReferences),
      UserReport,
      PrefetchHooks Function({bool branchId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BranchesTableTableManager get branches =>
      $$BranchesTableTableManager(_db, _db.branches);
  $$PlaceFetchesTableTableManager get placeFetches =>
      $$PlaceFetchesTableTableManager(_db, _db.placeFetches);
  $$ForecastsTableTableManager get forecasts =>
      $$ForecastsTableTableManager(_db, _db.forecasts);
  $$ObservationsTableTableManager get observations =>
      $$ObservationsTableTableManager(_db, _db.observations);
  $$UserReportsTableTableManager get userReports =>
      $$UserReportsTableTableManager(_db, _db.userReports);
}
