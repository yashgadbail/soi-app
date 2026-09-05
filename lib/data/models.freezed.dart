// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Profile {

 String get id; String? get email;@JsonKey(name: 'full_name') String? get fullName; String? get city;@JsonKey(name: 'needs_name') bool get needsName;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Profile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.needsName, _this.needsName) || other.needsName == _this.needsName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Profile;
  return Object.hash(runtimeType,_this.id,_this.email,_this.fullName,_this.city,_this.needsName);
}

@override
String toString() {
  final _this = this as Profile;
  return 'Profile(id: ${_this.id}, email: ${_this.email}, fullName: ${_this.fullName}, city: ${_this.city}, needsName: ${_this.needsName})';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 String id, String? email,@JsonKey(name: 'full_name') String? fullName, String? city,@JsonKey(name: 'needs_name') bool needsName
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = freezed,Object? fullName = freezed,Object? city = freezed,Object? needsName = null,}) {
  return _then(Profile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,needsName: null == needsName ? _self.needsName : needsName // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Profile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Profile value)  $default,){
final _that = this;
switch (_that) {
case _Profile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Profile value)?  $default,){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? email, @JsonKey(name: 'full_name')  String? fullName,  String? city, @JsonKey(name: 'needs_name')  bool needsName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.email,_that.fullName,_that.city,_that.needsName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? email, @JsonKey(name: 'full_name')  String? fullName,  String? city, @JsonKey(name: 'needs_name')  bool needsName)  $default,) {final _that = this;
switch (_that) {
case _Profile():
return $default(_that.id,_that.email,_that.fullName,_that.city,_that.needsName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? email, @JsonKey(name: 'full_name')  String? fullName,  String? city, @JsonKey(name: 'needs_name')  bool needsName)?  $default,) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.email,_that.fullName,_that.city,_that.needsName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Profile implements Profile {
  const _Profile({required this.id, this.email, @JsonKey(name: 'full_name') this.fullName, this.city, @JsonKey(name: 'needs_name') this.needsName = true});
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override final  String id;
@override final  String? email;
@override@JsonKey(name: 'full_name') final  String? fullName;
@override final  String? city;
@override@JsonKey(name: 'needs_name') final  bool needsName;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.city, city) || other.city == city)&&(identical(other.needsName, needsName) || other.needsName == needsName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,email,fullName,city,needsName);
}

@override
String toString() {
    return 'Profile(id: $id, email: $email, fullName: $fullName, city: $city, needsName: $needsName)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String? email,@JsonKey(name: 'full_name') String? fullName, String? city,@JsonKey(name: 'needs_name') bool needsName
});




}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = freezed,Object? fullName = freezed,Object? city = freezed,Object? needsName = null,}) {
  return _then(_Profile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,needsName: null == needsName ? _self.needsName : needsName // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Membership {

@JsonKey(name: 'org_id') String get orgId;@JsonKey(name: 'org_name') String get orgName;@JsonKey(name: 'org_type') String get orgType;@JsonKey(name: 'verification_tier') int get verificationTier; String get role; String? get city;
/// Create a copy of Membership
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipCopyWith<Membership> get copyWith => _$MembershipCopyWithImpl<Membership>(this as Membership, _$identity);

  /// Serializes this Membership to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Membership;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Membership&&(identical(other.orgId, _this.orgId) || other.orgId == _this.orgId)&&(identical(other.orgName, _this.orgName) || other.orgName == _this.orgName)&&(identical(other.orgType, _this.orgType) || other.orgType == _this.orgType)&&(identical(other.verificationTier, _this.verificationTier) || other.verificationTier == _this.verificationTier)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.city, _this.city) || other.city == _this.city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Membership;
  return Object.hash(runtimeType,_this.orgId,_this.orgName,_this.orgType,_this.verificationTier,_this.role,_this.city);
}

@override
String toString() {
  final _this = this as Membership;
  return 'Membership(orgId: ${_this.orgId}, orgName: ${_this.orgName}, orgType: ${_this.orgType}, verificationTier: ${_this.verificationTier}, role: ${_this.role}, city: ${_this.city})';
}


}

/// @nodoc
abstract mixin class $MembershipCopyWith<$Res>  {
  factory $MembershipCopyWith(Membership value, $Res Function(Membership) _then) = _$MembershipCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'org_id') String orgId,@JsonKey(name: 'org_name') String orgName,@JsonKey(name: 'org_type') String orgType,@JsonKey(name: 'verification_tier') int verificationTier, String role, String? city
});




}
/// @nodoc
class _$MembershipCopyWithImpl<$Res>
    implements $MembershipCopyWith<$Res> {
  _$MembershipCopyWithImpl(this._self, this._then);

  final Membership _self;
  final $Res Function(Membership) _then;

/// Create a copy of Membership
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orgId = null,Object? orgName = null,Object? orgType = null,Object? verificationTier = null,Object? role = null,Object? city = freezed,}) {
  return _then(Membership(
orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,verificationTier: null == verificationTier ? _self.verificationTier : verificationTier // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Membership].
extension MembershipPatterns on Membership {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Membership value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Membership() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Membership value)  $default,){
final _that = this;
switch (_that) {
case _Membership():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Membership value)?  $default,){
final _that = this;
switch (_that) {
case _Membership() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'org_type')  String orgType, @JsonKey(name: 'verification_tier')  int verificationTier,  String role,  String? city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Membership() when $default != null:
return $default(_that.orgId,_that.orgName,_that.orgType,_that.verificationTier,_that.role,_that.city);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'org_type')  String orgType, @JsonKey(name: 'verification_tier')  int verificationTier,  String role,  String? city)  $default,) {final _that = this;
switch (_that) {
case _Membership():
return $default(_that.orgId,_that.orgName,_that.orgType,_that.verificationTier,_that.role,_that.city);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'org_type')  String orgType, @JsonKey(name: 'verification_tier')  int verificationTier,  String role,  String? city)?  $default,) {final _that = this;
switch (_that) {
case _Membership() when $default != null:
return $default(_that.orgId,_that.orgName,_that.orgType,_that.verificationTier,_that.role,_that.city);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Membership extends Membership {
  const _Membership({@JsonKey(name: 'org_id') required this.orgId, @JsonKey(name: 'org_name') required this.orgName, @JsonKey(name: 'org_type') required this.orgType, @JsonKey(name: 'verification_tier') this.verificationTier = 0, required this.role, this.city}): super._();
  factory _Membership.fromJson(Map<String, dynamic> json) => _$MembershipFromJson(json);

@override@JsonKey(name: 'org_id') final  String orgId;
@override@JsonKey(name: 'org_name') final  String orgName;
@override@JsonKey(name: 'org_type') final  String orgType;
@override@JsonKey(name: 'verification_tier') final  int verificationTier;
@override final  String role;
@override final  String? city;

/// Create a copy of Membership
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipCopyWith<_Membership> get copyWith => __$MembershipCopyWithImpl<_Membership>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MembershipToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Membership&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.orgName, orgName) || other.orgName == orgName)&&(identical(other.orgType, orgType) || other.orgType == orgType)&&(identical(other.verificationTier, verificationTier) || other.verificationTier == verificationTier)&&(identical(other.role, role) || other.role == role)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,orgId,orgName,orgType,verificationTier,role,city);
}

@override
String toString() {
    return 'Membership(orgId: $orgId, orgName: $orgName, orgType: $orgType, verificationTier: $verificationTier, role: $role, city: $city)';
}


}

/// @nodoc
abstract mixin class _$MembershipCopyWith<$Res> implements $MembershipCopyWith<$Res> {
  factory _$MembershipCopyWith(_Membership value, $Res Function(_Membership) _then) = __$MembershipCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'org_id') String orgId,@JsonKey(name: 'org_name') String orgName,@JsonKey(name: 'org_type') String orgType,@JsonKey(name: 'verification_tier') int verificationTier, String role, String? city
});




}
/// @nodoc
class __$MembershipCopyWithImpl<$Res>
    implements _$MembershipCopyWith<$Res> {
  __$MembershipCopyWithImpl(this._self, this._then);

  final _Membership _self;
  final $Res Function(_Membership) _then;

/// Create a copy of Membership
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orgId = null,Object? orgName = null,Object? orgType = null,Object? verificationTier = null,Object? role = null,Object? city = freezed,}) {
  return _then(_Membership(
orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,verificationTier: null == verificationTier ? _self.verificationTier : verificationTier // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DriveSummary {

 String get id; String get title; String? get cause; String? get venue; String? get city;@JsonKey(name: 'starts_at') DateTime get startsAt;@JsonKey(name: 'ends_at') DateTime get endsAt;@JsonKey(name: 'default_hours') num get defaultHours; int get capacity;@JsonKey(name: 'spots_left') int get spotsLeft;@JsonKey(name: 'org_id') String get orgId;@JsonKey(name: 'org_name') String get orgName;@JsonKey(name: 'org_verified') bool get orgVerified; bool get registered;
/// Create a copy of DriveSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveSummaryCopyWith<DriveSummary> get copyWith => _$DriveSummaryCopyWithImpl<DriveSummary>(this as DriveSummary, _$identity);

  /// Serializes this DriveSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriveSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.cause, _this.cause) || other.cause == _this.cause)&&(identical(other.venue, _this.venue) || other.venue == _this.venue)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.defaultHours, _this.defaultHours) || other.defaultHours == _this.defaultHours)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&(identical(other.spotsLeft, _this.spotsLeft) || other.spotsLeft == _this.spotsLeft)&&(identical(other.orgId, _this.orgId) || other.orgId == _this.orgId)&&(identical(other.orgName, _this.orgName) || other.orgName == _this.orgName)&&(identical(other.orgVerified, _this.orgVerified) || other.orgVerified == _this.orgVerified)&&(identical(other.registered, _this.registered) || other.registered == _this.registered));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriveSummary;
  return Object.hash(runtimeType,_this.id,_this.title,_this.cause,_this.venue,_this.city,_this.startsAt,_this.endsAt,_this.defaultHours,_this.capacity,_this.spotsLeft,_this.orgId,_this.orgName,_this.orgVerified,_this.registered);
}

@override
String toString() {
  final _this = this as DriveSummary;
  return 'DriveSummary(id: ${_this.id}, title: ${_this.title}, cause: ${_this.cause}, venue: ${_this.venue}, city: ${_this.city}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, defaultHours: ${_this.defaultHours}, capacity: ${_this.capacity}, spotsLeft: ${_this.spotsLeft}, orgId: ${_this.orgId}, orgName: ${_this.orgName}, orgVerified: ${_this.orgVerified}, registered: ${_this.registered})';
}


}

/// @nodoc
abstract mixin class $DriveSummaryCopyWith<$Res>  {
  factory $DriveSummaryCopyWith(DriveSummary value, $Res Function(DriveSummary) _then) = _$DriveSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? cause, String? venue, String? city,@JsonKey(name: 'starts_at') DateTime startsAt,@JsonKey(name: 'ends_at') DateTime endsAt,@JsonKey(name: 'default_hours') num defaultHours, int capacity,@JsonKey(name: 'spots_left') int spotsLeft,@JsonKey(name: 'org_id') String orgId,@JsonKey(name: 'org_name') String orgName,@JsonKey(name: 'org_verified') bool orgVerified, bool registered
});




}
/// @nodoc
class _$DriveSummaryCopyWithImpl<$Res>
    implements $DriveSummaryCopyWith<$Res> {
  _$DriveSummaryCopyWithImpl(this._self, this._then);

  final DriveSummary _self;
  final $Res Function(DriveSummary) _then;

/// Create a copy of DriveSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? cause = freezed,Object? venue = freezed,Object? city = freezed,Object? startsAt = null,Object? endsAt = null,Object? defaultHours = null,Object? capacity = null,Object? spotsLeft = null,Object? orgId = null,Object? orgName = null,Object? orgVerified = null,Object? registered = null,}) {
  return _then(DriveSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,defaultHours: null == defaultHours ? _self.defaultHours : defaultHours // ignore: cast_nullable_to_non_nullable
as num,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,spotsLeft: null == spotsLeft ? _self.spotsLeft : spotsLeft // ignore: cast_nullable_to_non_nullable
as int,orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,orgVerified: null == orgVerified ? _self.orgVerified : orgVerified // ignore: cast_nullable_to_non_nullable
as bool,registered: null == registered ? _self.registered : registered // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DriveSummary].
extension DriveSummaryPatterns on DriveSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveSummary value)  $default,){
final _that = this;
switch (_that) {
case _DriveSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DriveSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? cause,  String? venue,  String? city, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt, @JsonKey(name: 'default_hours')  num defaultHours,  int capacity, @JsonKey(name: 'spots_left')  int spotsLeft, @JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'org_verified')  bool orgVerified,  bool registered)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveSummary() when $default != null:
return $default(_that.id,_that.title,_that.cause,_that.venue,_that.city,_that.startsAt,_that.endsAt,_that.defaultHours,_that.capacity,_that.spotsLeft,_that.orgId,_that.orgName,_that.orgVerified,_that.registered);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? cause,  String? venue,  String? city, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt, @JsonKey(name: 'default_hours')  num defaultHours,  int capacity, @JsonKey(name: 'spots_left')  int spotsLeft, @JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'org_verified')  bool orgVerified,  bool registered)  $default,) {final _that = this;
switch (_that) {
case _DriveSummary():
return $default(_that.id,_that.title,_that.cause,_that.venue,_that.city,_that.startsAt,_that.endsAt,_that.defaultHours,_that.capacity,_that.spotsLeft,_that.orgId,_that.orgName,_that.orgVerified,_that.registered);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? cause,  String? venue,  String? city, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt, @JsonKey(name: 'default_hours')  num defaultHours,  int capacity, @JsonKey(name: 'spots_left')  int spotsLeft, @JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'org_verified')  bool orgVerified,  bool registered)?  $default,) {final _that = this;
switch (_that) {
case _DriveSummary() when $default != null:
return $default(_that.id,_that.title,_that.cause,_that.venue,_that.city,_that.startsAt,_that.endsAt,_that.defaultHours,_that.capacity,_that.spotsLeft,_that.orgId,_that.orgName,_that.orgVerified,_that.registered);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriveSummary extends DriveSummary {
  const _DriveSummary({required this.id, required this.title, this.cause, this.venue, this.city, @JsonKey(name: 'starts_at') required this.startsAt, @JsonKey(name: 'ends_at') required this.endsAt, @JsonKey(name: 'default_hours') required this.defaultHours, required this.capacity, @JsonKey(name: 'spots_left') this.spotsLeft = 0, @JsonKey(name: 'org_id') required this.orgId, @JsonKey(name: 'org_name') required this.orgName, @JsonKey(name: 'org_verified') this.orgVerified = false, this.registered = false}): super._();
  factory _DriveSummary.fromJson(Map<String, dynamic> json) => _$DriveSummaryFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? cause;
@override final  String? venue;
@override final  String? city;
@override@JsonKey(name: 'starts_at') final  DateTime startsAt;
@override@JsonKey(name: 'ends_at') final  DateTime endsAt;
@override@JsonKey(name: 'default_hours') final  num defaultHours;
@override final  int capacity;
@override@JsonKey(name: 'spots_left') final  int spotsLeft;
@override@JsonKey(name: 'org_id') final  String orgId;
@override@JsonKey(name: 'org_name') final  String orgName;
@override@JsonKey(name: 'org_verified') final  bool orgVerified;
@override@JsonKey() final  bool registered;

/// Create a copy of DriveSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveSummaryCopyWith<_DriveSummary> get copyWith => __$DriveSummaryCopyWithImpl<_DriveSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriveSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cause, cause) || other.cause == cause)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.city, city) || other.city == city)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.defaultHours, defaultHours) || other.defaultHours == defaultHours)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.spotsLeft, spotsLeft) || other.spotsLeft == spotsLeft)&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.orgName, orgName) || other.orgName == orgName)&&(identical(other.orgVerified, orgVerified) || other.orgVerified == orgVerified)&&(identical(other.registered, registered) || other.registered == registered));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,cause,venue,city,startsAt,endsAt,defaultHours,capacity,spotsLeft,orgId,orgName,orgVerified,registered);
}

@override
String toString() {
    return 'DriveSummary(id: $id, title: $title, cause: $cause, venue: $venue, city: $city, startsAt: $startsAt, endsAt: $endsAt, defaultHours: $defaultHours, capacity: $capacity, spotsLeft: $spotsLeft, orgId: $orgId, orgName: $orgName, orgVerified: $orgVerified, registered: $registered)';
}


}

/// @nodoc
abstract mixin class _$DriveSummaryCopyWith<$Res> implements $DriveSummaryCopyWith<$Res> {
  factory _$DriveSummaryCopyWith(_DriveSummary value, $Res Function(_DriveSummary) _then) = __$DriveSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? cause, String? venue, String? city,@JsonKey(name: 'starts_at') DateTime startsAt,@JsonKey(name: 'ends_at') DateTime endsAt,@JsonKey(name: 'default_hours') num defaultHours, int capacity,@JsonKey(name: 'spots_left') int spotsLeft,@JsonKey(name: 'org_id') String orgId,@JsonKey(name: 'org_name') String orgName,@JsonKey(name: 'org_verified') bool orgVerified, bool registered
});




}
/// @nodoc
class __$DriveSummaryCopyWithImpl<$Res>
    implements _$DriveSummaryCopyWith<$Res> {
  __$DriveSummaryCopyWithImpl(this._self, this._then);

  final _DriveSummary _self;
  final $Res Function(_DriveSummary) _then;

/// Create a copy of DriveSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? cause = freezed,Object? venue = freezed,Object? city = freezed,Object? startsAt = null,Object? endsAt = null,Object? defaultHours = null,Object? capacity = null,Object? spotsLeft = null,Object? orgId = null,Object? orgName = null,Object? orgVerified = null,Object? registered = null,}) {
  return _then(_DriveSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,defaultHours: null == defaultHours ? _self.defaultHours : defaultHours // ignore: cast_nullable_to_non_nullable
as num,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,spotsLeft: null == spotsLeft ? _self.spotsLeft : spotsLeft // ignore: cast_nullable_to_non_nullable
as int,orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,orgVerified: null == orgVerified ? _self.orgVerified : orgVerified // ignore: cast_nullable_to_non_nullable
as bool,registered: null == registered ? _self.registered : registered // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$OrgRef {

 String get id; String get name; String get type; String? get city;@JsonKey(name: 'verification_tier') int get verificationTier;
/// Create a copy of OrgRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrgRefCopyWith<OrgRef> get copyWith => _$OrgRefCopyWithImpl<OrgRef>(this as OrgRef, _$identity);

  /// Serializes this OrgRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrgRef;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrgRef&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.verificationTier, _this.verificationTier) || other.verificationTier == _this.verificationTier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrgRef;
  return Object.hash(runtimeType,_this.id,_this.name,_this.type,_this.city,_this.verificationTier);
}

@override
String toString() {
  final _this = this as OrgRef;
  return 'OrgRef(id: ${_this.id}, name: ${_this.name}, type: ${_this.type}, city: ${_this.city}, verificationTier: ${_this.verificationTier})';
}


}

/// @nodoc
abstract mixin class $OrgRefCopyWith<$Res>  {
  factory $OrgRefCopyWith(OrgRef value, $Res Function(OrgRef) _then) = _$OrgRefCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, String? city,@JsonKey(name: 'verification_tier') int verificationTier
});




}
/// @nodoc
class _$OrgRefCopyWithImpl<$Res>
    implements $OrgRefCopyWith<$Res> {
  _$OrgRefCopyWithImpl(this._self, this._then);

  final OrgRef _self;
  final $Res Function(OrgRef) _then;

/// Create a copy of OrgRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? city = freezed,Object? verificationTier = null,}) {
  return _then(OrgRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,verificationTier: null == verificationTier ? _self.verificationTier : verificationTier // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrgRef].
extension OrgRefPatterns on OrgRef {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrgRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrgRef() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrgRef value)  $default,){
final _that = this;
switch (_that) {
case _OrgRef():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrgRef value)?  $default,){
final _that = this;
switch (_that) {
case _OrgRef() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String? city, @JsonKey(name: 'verification_tier')  int verificationTier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrgRef() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.city,_that.verificationTier);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String? city, @JsonKey(name: 'verification_tier')  int verificationTier)  $default,) {final _that = this;
switch (_that) {
case _OrgRef():
return $default(_that.id,_that.name,_that.type,_that.city,_that.verificationTier);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  String? city, @JsonKey(name: 'verification_tier')  int verificationTier)?  $default,) {final _that = this;
switch (_that) {
case _OrgRef() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.city,_that.verificationTier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrgRef extends OrgRef {
  const _OrgRef({required this.id, required this.name, required this.type, this.city, @JsonKey(name: 'verification_tier') this.verificationTier = 0}): super._();
  factory _OrgRef.fromJson(Map<String, dynamic> json) => _$OrgRefFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
@override final  String? city;
@override@JsonKey(name: 'verification_tier') final  int verificationTier;

/// Create a copy of OrgRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrgRefCopyWith<_OrgRef> get copyWith => __$OrgRefCopyWithImpl<_OrgRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrgRefToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrgRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.city, city) || other.city == city)&&(identical(other.verificationTier, verificationTier) || other.verificationTier == verificationTier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,type,city,verificationTier);
}

@override
String toString() {
    return 'OrgRef(id: $id, name: $name, type: $type, city: $city, verificationTier: $verificationTier)';
}


}

/// @nodoc
abstract mixin class _$OrgRefCopyWith<$Res> implements $OrgRefCopyWith<$Res> {
  factory _$OrgRefCopyWith(_OrgRef value, $Res Function(_OrgRef) _then) = __$OrgRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, String? city,@JsonKey(name: 'verification_tier') int verificationTier
});




}
/// @nodoc
class __$OrgRefCopyWithImpl<$Res>
    implements _$OrgRefCopyWith<$Res> {
  __$OrgRefCopyWithImpl(this._self, this._then);

  final _OrgRef _self;
  final $Res Function(_OrgRef) _then;

/// Create a copy of OrgRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? city = freezed,Object? verificationTier = null,}) {
  return _then(_OrgRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,verificationTier: null == verificationTier ? _self.verificationTier : verificationTier // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MyAttendance {

 String get status; num get hours;@JsonKey(name: 'check_in_at') DateTime get checkInAt;
/// Create a copy of MyAttendance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyAttendanceCopyWith<MyAttendance> get copyWith => _$MyAttendanceCopyWithImpl<MyAttendance>(this as MyAttendance, _$identity);

  /// Serializes this MyAttendance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyAttendance;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyAttendance&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.hours, _this.hours) || other.hours == _this.hours)&&(identical(other.checkInAt, _this.checkInAt) || other.checkInAt == _this.checkInAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyAttendance;
  return Object.hash(runtimeType,_this.status,_this.hours,_this.checkInAt);
}

@override
String toString() {
  final _this = this as MyAttendance;
  return 'MyAttendance(status: ${_this.status}, hours: ${_this.hours}, checkInAt: ${_this.checkInAt})';
}


}

/// @nodoc
abstract mixin class $MyAttendanceCopyWith<$Res>  {
  factory $MyAttendanceCopyWith(MyAttendance value, $Res Function(MyAttendance) _then) = _$MyAttendanceCopyWithImpl;
@useResult
$Res call({
 String status, num hours,@JsonKey(name: 'check_in_at') DateTime checkInAt
});




}
/// @nodoc
class _$MyAttendanceCopyWithImpl<$Res>
    implements $MyAttendanceCopyWith<$Res> {
  _$MyAttendanceCopyWithImpl(this._self, this._then);

  final MyAttendance _self;
  final $Res Function(MyAttendance) _then;

/// Create a copy of MyAttendance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? hours = null,Object? checkInAt = null,}) {
  return _then(MyAttendance(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as num,checkInAt: null == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MyAttendance].
extension MyAttendancePatterns on MyAttendance {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyAttendance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyAttendance() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyAttendance value)  $default,){
final _that = this;
switch (_that) {
case _MyAttendance():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyAttendance value)?  $default,){
final _that = this;
switch (_that) {
case _MyAttendance() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  num hours, @JsonKey(name: 'check_in_at')  DateTime checkInAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyAttendance() when $default != null:
return $default(_that.status,_that.hours,_that.checkInAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  num hours, @JsonKey(name: 'check_in_at')  DateTime checkInAt)  $default,) {final _that = this;
switch (_that) {
case _MyAttendance():
return $default(_that.status,_that.hours,_that.checkInAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  num hours, @JsonKey(name: 'check_in_at')  DateTime checkInAt)?  $default,) {final _that = this;
switch (_that) {
case _MyAttendance() when $default != null:
return $default(_that.status,_that.hours,_that.checkInAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyAttendance implements MyAttendance {
  const _MyAttendance({required this.status, required this.hours, @JsonKey(name: 'check_in_at') required this.checkInAt});
  factory _MyAttendance.fromJson(Map<String, dynamic> json) => _$MyAttendanceFromJson(json);

@override final  String status;
@override final  num hours;
@override@JsonKey(name: 'check_in_at') final  DateTime checkInAt;

/// Create a copy of MyAttendance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyAttendanceCopyWith<_MyAttendance> get copyWith => __$MyAttendanceCopyWithImpl<_MyAttendance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyAttendanceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyAttendance&&(identical(other.status, status) || other.status == status)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,hours,checkInAt);
}

@override
String toString() {
    return 'MyAttendance(status: $status, hours: $hours, checkInAt: $checkInAt)';
}


}

/// @nodoc
abstract mixin class _$MyAttendanceCopyWith<$Res> implements $MyAttendanceCopyWith<$Res> {
  factory _$MyAttendanceCopyWith(_MyAttendance value, $Res Function(_MyAttendance) _then) = __$MyAttendanceCopyWithImpl;
@override @useResult
$Res call({
 String status, num hours,@JsonKey(name: 'check_in_at') DateTime checkInAt
});




}
/// @nodoc
class __$MyAttendanceCopyWithImpl<$Res>
    implements _$MyAttendanceCopyWith<$Res> {
  __$MyAttendanceCopyWithImpl(this._self, this._then);

  final _MyAttendance _self;
  final $Res Function(_MyAttendance) _then;

/// Create a copy of MyAttendance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? hours = null,Object? checkInAt = null,}) {
  return _then(_MyAttendance(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as num,checkInAt: null == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$DriveDetail {

 String get id; String get title; String? get description; String? get cause; String? get venue; String? get city;@JsonKey(name: 'starts_at') DateTime get startsAt;@JsonKey(name: 'ends_at') DateTime get endsAt; int get capacity;@JsonKey(name: 'default_hours') num get defaultHours; String get status;@JsonKey(name: 'spots_left') int get spotsLeft; int? get registrations; bool get registered;@JsonKey(name: 'can_manage') bool get canManage;@JsonKey(name: 'my_attendance') MyAttendance? get myAttendance; OrgRef get org;
/// Create a copy of DriveDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriveDetailCopyWith<DriveDetail> get copyWith => _$DriveDetailCopyWithImpl<DriveDetail>(this as DriveDetail, _$identity);

  /// Serializes this DriveDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriveDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveDetail&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.cause, _this.cause) || other.cause == _this.cause)&&(identical(other.venue, _this.venue) || other.venue == _this.venue)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&(identical(other.defaultHours, _this.defaultHours) || other.defaultHours == _this.defaultHours)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.spotsLeft, _this.spotsLeft) || other.spotsLeft == _this.spotsLeft)&&(identical(other.registrations, _this.registrations) || other.registrations == _this.registrations)&&(identical(other.registered, _this.registered) || other.registered == _this.registered)&&(identical(other.canManage, _this.canManage) || other.canManage == _this.canManage)&&(identical(other.myAttendance, _this.myAttendance) || other.myAttendance == _this.myAttendance)&&(identical(other.org, _this.org) || other.org == _this.org));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriveDetail;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.cause,_this.venue,_this.city,_this.startsAt,_this.endsAt,_this.capacity,_this.defaultHours,_this.status,_this.spotsLeft,_this.registrations,_this.registered,_this.canManage,_this.myAttendance,_this.org);
}

@override
String toString() {
  final _this = this as DriveDetail;
  return 'DriveDetail(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, cause: ${_this.cause}, venue: ${_this.venue}, city: ${_this.city}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, capacity: ${_this.capacity}, defaultHours: ${_this.defaultHours}, status: ${_this.status}, spotsLeft: ${_this.spotsLeft}, registrations: ${_this.registrations}, registered: ${_this.registered}, canManage: ${_this.canManage}, myAttendance: ${_this.myAttendance}, org: ${_this.org})';
}


}

/// @nodoc
abstract mixin class $DriveDetailCopyWith<$Res>  {
  factory $DriveDetailCopyWith(DriveDetail value, $Res Function(DriveDetail) _then) = _$DriveDetailCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String? cause, String? venue, String? city,@JsonKey(name: 'starts_at') DateTime startsAt,@JsonKey(name: 'ends_at') DateTime endsAt, int capacity,@JsonKey(name: 'default_hours') num defaultHours, String status,@JsonKey(name: 'spots_left') int spotsLeft, int? registrations, bool registered,@JsonKey(name: 'can_manage') bool canManage,@JsonKey(name: 'my_attendance') MyAttendance? myAttendance, OrgRef org
});


$MyAttendanceCopyWith<$Res>? get myAttendance;$OrgRefCopyWith<$Res> get org;

}
/// @nodoc
class _$DriveDetailCopyWithImpl<$Res>
    implements $DriveDetailCopyWith<$Res> {
  _$DriveDetailCopyWithImpl(this._self, this._then);

  final DriveDetail _self;
  final $Res Function(DriveDetail) _then;

/// Create a copy of DriveDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? cause = freezed,Object? venue = freezed,Object? city = freezed,Object? startsAt = null,Object? endsAt = null,Object? capacity = null,Object? defaultHours = null,Object? status = null,Object? spotsLeft = null,Object? registrations = freezed,Object? registered = null,Object? canManage = null,Object? myAttendance = freezed,Object? org = null,}) {
  return _then(DriveDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,cause: freezed == cause ? _self.cause : cause // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,defaultHours: null == defaultHours ? _self.defaultHours : defaultHours // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,spotsLeft: null == spotsLeft ? _self.spotsLeft : spotsLeft // ignore: cast_nullable_to_non_nullable
as int,registrations: freezed == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as int?,registered: null == registered ? _self.registered : registered // ignore: cast_nullable_to_non_nullable
as bool,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,myAttendance: freezed == myAttendance ? _self.myAttendance : myAttendance // ignore: cast_nullable_to_non_nullable
as MyAttendance?,org: null == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as OrgRef,
  ));
}
/// Create a copy of DriveDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyAttendanceCopyWith<$Res>? get myAttendance {
    if (_self.myAttendance == null) {
    return null;
  }

  return $MyAttendanceCopyWith<$Res>(_self.myAttendance!, (value) {
    return _then(_self.copyWith(myAttendance: value));
  });
}/// Create a copy of DriveDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrgRefCopyWith<$Res> get org {
  
  return $OrgRefCopyWith<$Res>(_self.org, (value) {
    return _then(_self.copyWith(org: value));
  });
}
}


/// Adds pattern-matching-related methods to [DriveDetail].
extension DriveDetailPatterns on DriveDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriveDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriveDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriveDetail value)  $default,){
final _that = this;
switch (_that) {
case _DriveDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriveDetail value)?  $default,){
final _that = this;
switch (_that) {
case _DriveDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? cause,  String? venue,  String? city, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt,  int capacity, @JsonKey(name: 'default_hours')  num defaultHours,  String status, @JsonKey(name: 'spots_left')  int spotsLeft,  int? registrations,  bool registered, @JsonKey(name: 'can_manage')  bool canManage, @JsonKey(name: 'my_attendance')  MyAttendance? myAttendance,  OrgRef org)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriveDetail() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.cause,_that.venue,_that.city,_that.startsAt,_that.endsAt,_that.capacity,_that.defaultHours,_that.status,_that.spotsLeft,_that.registrations,_that.registered,_that.canManage,_that.myAttendance,_that.org);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? cause,  String? venue,  String? city, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt,  int capacity, @JsonKey(name: 'default_hours')  num defaultHours,  String status, @JsonKey(name: 'spots_left')  int spotsLeft,  int? registrations,  bool registered, @JsonKey(name: 'can_manage')  bool canManage, @JsonKey(name: 'my_attendance')  MyAttendance? myAttendance,  OrgRef org)  $default,) {final _that = this;
switch (_that) {
case _DriveDetail():
return $default(_that.id,_that.title,_that.description,_that.cause,_that.venue,_that.city,_that.startsAt,_that.endsAt,_that.capacity,_that.defaultHours,_that.status,_that.spotsLeft,_that.registrations,_that.registered,_that.canManage,_that.myAttendance,_that.org);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String? cause,  String? venue,  String? city, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt,  int capacity, @JsonKey(name: 'default_hours')  num defaultHours,  String status, @JsonKey(name: 'spots_left')  int spotsLeft,  int? registrations,  bool registered, @JsonKey(name: 'can_manage')  bool canManage, @JsonKey(name: 'my_attendance')  MyAttendance? myAttendance,  OrgRef org)?  $default,) {final _that = this;
switch (_that) {
case _DriveDetail() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.cause,_that.venue,_that.city,_that.startsAt,_that.endsAt,_that.capacity,_that.defaultHours,_that.status,_that.spotsLeft,_that.registrations,_that.registered,_that.canManage,_that.myAttendance,_that.org);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriveDetail extends DriveDetail {
  const _DriveDetail({required this.id, required this.title, this.description, this.cause, this.venue, this.city, @JsonKey(name: 'starts_at') required this.startsAt, @JsonKey(name: 'ends_at') required this.endsAt, required this.capacity, @JsonKey(name: 'default_hours') required this.defaultHours, required this.status, @JsonKey(name: 'spots_left') this.spotsLeft = 0, this.registrations, this.registered = false, @JsonKey(name: 'can_manage') this.canManage = false, @JsonKey(name: 'my_attendance') this.myAttendance, required this.org}): super._();
  factory _DriveDetail.fromJson(Map<String, dynamic> json) => _$DriveDetailFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  String? cause;
@override final  String? venue;
@override final  String? city;
@override@JsonKey(name: 'starts_at') final  DateTime startsAt;
@override@JsonKey(name: 'ends_at') final  DateTime endsAt;
@override final  int capacity;
@override@JsonKey(name: 'default_hours') final  num defaultHours;
@override final  String status;
@override@JsonKey(name: 'spots_left') final  int spotsLeft;
@override final  int? registrations;
@override@JsonKey() final  bool registered;
@override@JsonKey(name: 'can_manage') final  bool canManage;
@override@JsonKey(name: 'my_attendance') final  MyAttendance? myAttendance;
@override final  OrgRef org;

/// Create a copy of DriveDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriveDetailCopyWith<_DriveDetail> get copyWith => __$DriveDetailCopyWithImpl<_DriveDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriveDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriveDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.cause, cause) || other.cause == cause)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.city, city) || other.city == city)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.defaultHours, defaultHours) || other.defaultHours == defaultHours)&&(identical(other.status, status) || other.status == status)&&(identical(other.spotsLeft, spotsLeft) || other.spotsLeft == spotsLeft)&&(identical(other.registrations, registrations) || other.registrations == registrations)&&(identical(other.registered, registered) || other.registered == registered)&&(identical(other.canManage, canManage) || other.canManage == canManage)&&(identical(other.myAttendance, myAttendance) || other.myAttendance == myAttendance)&&(identical(other.org, org) || other.org == org));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,cause,venue,city,startsAt,endsAt,capacity,defaultHours,status,spotsLeft,registrations,registered,canManage,myAttendance,org);
}

@override
String toString() {
    return 'DriveDetail(id: $id, title: $title, description: $description, cause: $cause, venue: $venue, city: $city, startsAt: $startsAt, endsAt: $endsAt, capacity: $capacity, defaultHours: $defaultHours, status: $status, spotsLeft: $spotsLeft, registrations: $registrations, registered: $registered, canManage: $canManage, myAttendance: $myAttendance, org: $org)';
}


}

/// @nodoc
abstract mixin class _$DriveDetailCopyWith<$Res> implements $DriveDetailCopyWith<$Res> {
  factory _$DriveDetailCopyWith(_DriveDetail value, $Res Function(_DriveDetail) _then) = __$DriveDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String? cause, String? venue, String? city,@JsonKey(name: 'starts_at') DateTime startsAt,@JsonKey(name: 'ends_at') DateTime endsAt, int capacity,@JsonKey(name: 'default_hours') num defaultHours, String status,@JsonKey(name: 'spots_left') int spotsLeft, int? registrations, bool registered,@JsonKey(name: 'can_manage') bool canManage,@JsonKey(name: 'my_attendance') MyAttendance? myAttendance, OrgRef org
});


@override $MyAttendanceCopyWith<$Res>? get myAttendance;@override $OrgRefCopyWith<$Res> get org;

}
/// @nodoc
class __$DriveDetailCopyWithImpl<$Res>
    implements _$DriveDetailCopyWith<$Res> {
  __$DriveDetailCopyWithImpl(this._self, this._then);

  final _DriveDetail _self;
  final $Res Function(_DriveDetail) _then;

/// Create a copy of DriveDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? cause = freezed,Object? venue = freezed,Object? city = freezed,Object? startsAt = null,Object? endsAt = null,Object? capacity = null,Object? defaultHours = null,Object? status = null,Object? spotsLeft = null,Object? registrations = freezed,Object? registered = null,Object? canManage = null,Object? myAttendance = freezed,Object? org = null,}) {
  return _then(_DriveDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,cause: freezed == cause ? _self.cause : cause // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,defaultHours: null == defaultHours ? _self.defaultHours : defaultHours // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,spotsLeft: null == spotsLeft ? _self.spotsLeft : spotsLeft // ignore: cast_nullable_to_non_nullable
as int,registrations: freezed == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as int?,registered: null == registered ? _self.registered : registered // ignore: cast_nullable_to_non_nullable
as bool,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,myAttendance: freezed == myAttendance ? _self.myAttendance : myAttendance // ignore: cast_nullable_to_non_nullable
as MyAttendance?,org: null == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as OrgRef,
  ));
}

/// Create a copy of DriveDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyAttendanceCopyWith<$Res>? get myAttendance {
    if (_self.myAttendance == null) {
    return null;
  }

  return $MyAttendanceCopyWith<$Res>(_self.myAttendance!, (value) {
    return _then(_self.copyWith(myAttendance: value));
  });
}/// Create a copy of DriveDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrgRefCopyWith<$Res> get org {
  
  return $OrgRefCopyWith<$Res>(_self.org, (value) {
    return _then(_self.copyWith(org: value));
  });
}
}


/// @nodoc
mixin _$Facets {

 List<Facet> get causes; List<Facet> get cities;
/// Create a copy of Facets
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FacetsCopyWith<Facets> get copyWith => _$FacetsCopyWithImpl<Facets>(this as Facets, _$identity);

  /// Serializes this Facets to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Facets;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Facets&&const DeepCollectionEquality().equals(other.causes, _this.causes)&&const DeepCollectionEquality().equals(other.cities, _this.cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Facets;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.causes),const DeepCollectionEquality().hash(_this.cities));
}

@override
String toString() {
  final _this = this as Facets;
  return 'Facets(causes: ${_this.causes}, cities: ${_this.cities})';
}


}

/// @nodoc
abstract mixin class $FacetsCopyWith<$Res>  {
  factory $FacetsCopyWith(Facets value, $Res Function(Facets) _then) = _$FacetsCopyWithImpl;
@useResult
$Res call({
 List<Facet> causes, List<Facet> cities
});




}
/// @nodoc
class _$FacetsCopyWithImpl<$Res>
    implements $FacetsCopyWith<$Res> {
  _$FacetsCopyWithImpl(this._self, this._then);

  final Facets _self;
  final $Res Function(Facets) _then;

/// Create a copy of Facets
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? causes = null,Object? cities = null,}) {
  return _then(Facets(
causes: null == causes ? _self.causes : causes // ignore: cast_nullable_to_non_nullable
as List<Facet>,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<Facet>,
  ));
}

}


/// Adds pattern-matching-related methods to [Facets].
extension FacetsPatterns on Facets {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Facets value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Facets() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Facets value)  $default,){
final _that = this;
switch (_that) {
case _Facets():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Facets value)?  $default,){
final _that = this;
switch (_that) {
case _Facets() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Facet> causes,  List<Facet> cities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Facets() when $default != null:
return $default(_that.causes,_that.cities);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Facet> causes,  List<Facet> cities)  $default,) {final _that = this;
switch (_that) {
case _Facets():
return $default(_that.causes,_that.cities);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Facet> causes,  List<Facet> cities)?  $default,) {final _that = this;
switch (_that) {
case _Facets() when $default != null:
return $default(_that.causes,_that.cities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Facets implements Facets {
  const _Facets({ List<Facet> causes = const [],  List<Facet> cities = const []}): _causes = causes,_cities = cities;
  factory _Facets.fromJson(Map<String, dynamic> json) => _$FacetsFromJson(json);

 final  List<Facet> _causes;
@override@JsonKey() List<Facet> get causes {
  if (_causes is EqualUnmodifiableListView) return _causes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_causes);
}

 final  List<Facet> _cities;
@override@JsonKey() List<Facet> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of Facets
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FacetsCopyWith<_Facets> get copyWith => __$FacetsCopyWithImpl<_Facets>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FacetsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Facets&&const DeepCollectionEquality().equals(other.causes, _causes)&&const DeepCollectionEquality().equals(other.cities, _cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_causes),const DeepCollectionEquality().hash(_cities));
}

@override
String toString() {
    return 'Facets(causes: $causes, cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$FacetsCopyWith<$Res> implements $FacetsCopyWith<$Res> {
  factory _$FacetsCopyWith(_Facets value, $Res Function(_Facets) _then) = __$FacetsCopyWithImpl;
@override @useResult
$Res call({
 List<Facet> causes, List<Facet> cities
});




}
/// @nodoc
class __$FacetsCopyWithImpl<$Res>
    implements _$FacetsCopyWith<$Res> {
  __$FacetsCopyWithImpl(this._self, this._then);

  final _Facets _self;
  final $Res Function(_Facets) _then;

/// Create a copy of Facets
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? causes = null,Object? cities = null,}) {
  return _then(_Facets(
causes: null == causes ? _self._causes : causes // ignore: cast_nullable_to_non_nullable
as List<Facet>,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<Facet>,
  ));
}


}


/// @nodoc
mixin _$Facet {

 String get value; int get count;
/// Create a copy of Facet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FacetCopyWith<Facet> get copyWith => _$FacetCopyWithImpl<Facet>(this as Facet, _$identity);

  /// Serializes this Facet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Facet;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Facet&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Facet;
  return Object.hash(runtimeType,_this.value,_this.count);
}

@override
String toString() {
  final _this = this as Facet;
  return 'Facet(value: ${_this.value}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $FacetCopyWith<$Res>  {
  factory $FacetCopyWith(Facet value, $Res Function(Facet) _then) = _$FacetCopyWithImpl;
@useResult
$Res call({
 String value, int count
});




}
/// @nodoc
class _$FacetCopyWithImpl<$Res>
    implements $FacetCopyWith<$Res> {
  _$FacetCopyWithImpl(this._self, this._then);

  final Facet _self;
  final $Res Function(Facet) _then;

/// Create a copy of Facet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? count = null,}) {
  return _then(Facet(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Facet].
extension FacetPatterns on Facet {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Facet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Facet() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Facet value)  $default,){
final _that = this;
switch (_that) {
case _Facet():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Facet value)?  $default,){
final _that = this;
switch (_that) {
case _Facet() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Facet() when $default != null:
return $default(_that.value,_that.count);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  int count)  $default,) {final _that = this;
switch (_that) {
case _Facet():
return $default(_that.value,_that.count);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  int count)?  $default,) {final _that = this;
switch (_that) {
case _Facet() when $default != null:
return $default(_that.value,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Facet implements Facet {
  const _Facet({required this.value, required this.count});
  factory _Facet.fromJson(Map<String, dynamic> json) => _$FacetFromJson(json);

@override final  String value;
@override final  int count;

/// Create a copy of Facet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FacetCopyWith<_Facet> get copyWith => __$FacetCopyWithImpl<_Facet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FacetToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Facet&&(identical(other.value, value) || other.value == value)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,value,count);
}

@override
String toString() {
    return 'Facet(value: $value, count: $count)';
}


}

/// @nodoc
abstract mixin class _$FacetCopyWith<$Res> implements $FacetCopyWith<$Res> {
  factory _$FacetCopyWith(_Facet value, $Res Function(_Facet) _then) = __$FacetCopyWithImpl;
@override @useResult
$Res call({
 String value, int count
});




}
/// @nodoc
class __$FacetCopyWithImpl<$Res>
    implements _$FacetCopyWith<$Res> {
  __$FacetCopyWithImpl(this._self, this._then);

  final _Facet _self;
  final $Res Function(_Facet) _then;

/// Create a copy of Facet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? count = null,}) {
  return _then(_Facet(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Stats {

 int get organisations; int get drives;@JsonKey(name: 'certified_hours') num get certifiedHours; int get volunteers; int get pledges;
/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatsCopyWith<Stats> get copyWith => _$StatsCopyWithImpl<Stats>(this as Stats, _$identity);

  /// Serializes this Stats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Stats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Stats&&(identical(other.organisations, _this.organisations) || other.organisations == _this.organisations)&&(identical(other.drives, _this.drives) || other.drives == _this.drives)&&(identical(other.certifiedHours, _this.certifiedHours) || other.certifiedHours == _this.certifiedHours)&&(identical(other.volunteers, _this.volunteers) || other.volunteers == _this.volunteers)&&(identical(other.pledges, _this.pledges) || other.pledges == _this.pledges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Stats;
  return Object.hash(runtimeType,_this.organisations,_this.drives,_this.certifiedHours,_this.volunteers,_this.pledges);
}

@override
String toString() {
  final _this = this as Stats;
  return 'Stats(organisations: ${_this.organisations}, drives: ${_this.drives}, certifiedHours: ${_this.certifiedHours}, volunteers: ${_this.volunteers}, pledges: ${_this.pledges})';
}


}

/// @nodoc
abstract mixin class $StatsCopyWith<$Res>  {
  factory $StatsCopyWith(Stats value, $Res Function(Stats) _then) = _$StatsCopyWithImpl;
@useResult
$Res call({
 int organisations, int drives,@JsonKey(name: 'certified_hours') num certifiedHours, int volunteers, int pledges
});




}
/// @nodoc
class _$StatsCopyWithImpl<$Res>
    implements $StatsCopyWith<$Res> {
  _$StatsCopyWithImpl(this._self, this._then);

  final Stats _self;
  final $Res Function(Stats) _then;

/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organisations = null,Object? drives = null,Object? certifiedHours = null,Object? volunteers = null,Object? pledges = null,}) {
  return _then(Stats(
organisations: null == organisations ? _self.organisations : organisations // ignore: cast_nullable_to_non_nullable
as int,drives: null == drives ? _self.drives : drives // ignore: cast_nullable_to_non_nullable
as int,certifiedHours: null == certifiedHours ? _self.certifiedHours : certifiedHours // ignore: cast_nullable_to_non_nullable
as num,volunteers: null == volunteers ? _self.volunteers : volunteers // ignore: cast_nullable_to_non_nullable
as int,pledges: null == pledges ? _self.pledges : pledges // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Stats].
extension StatsPatterns on Stats {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Stats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Stats() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Stats value)  $default,){
final _that = this;
switch (_that) {
case _Stats():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Stats value)?  $default,){
final _that = this;
switch (_that) {
case _Stats() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int organisations,  int drives, @JsonKey(name: 'certified_hours')  num certifiedHours,  int volunteers,  int pledges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Stats() when $default != null:
return $default(_that.organisations,_that.drives,_that.certifiedHours,_that.volunteers,_that.pledges);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int organisations,  int drives, @JsonKey(name: 'certified_hours')  num certifiedHours,  int volunteers,  int pledges)  $default,) {final _that = this;
switch (_that) {
case _Stats():
return $default(_that.organisations,_that.drives,_that.certifiedHours,_that.volunteers,_that.pledges);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int organisations,  int drives, @JsonKey(name: 'certified_hours')  num certifiedHours,  int volunteers,  int pledges)?  $default,) {final _that = this;
switch (_that) {
case _Stats() when $default != null:
return $default(_that.organisations,_that.drives,_that.certifiedHours,_that.volunteers,_that.pledges);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Stats implements Stats {
  const _Stats({this.organisations = 0, this.drives = 0, @JsonKey(name: 'certified_hours') this.certifiedHours = 0, this.volunteers = 0, this.pledges = 0});
  factory _Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

@override@JsonKey() final  int organisations;
@override@JsonKey() final  int drives;
@override@JsonKey(name: 'certified_hours') final  num certifiedHours;
@override@JsonKey() final  int volunteers;
@override@JsonKey() final  int pledges;

/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatsCopyWith<_Stats> get copyWith => __$StatsCopyWithImpl<_Stats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stats&&(identical(other.organisations, organisations) || other.organisations == organisations)&&(identical(other.drives, drives) || other.drives == drives)&&(identical(other.certifiedHours, certifiedHours) || other.certifiedHours == certifiedHours)&&(identical(other.volunteers, volunteers) || other.volunteers == volunteers)&&(identical(other.pledges, pledges) || other.pledges == pledges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,organisations,drives,certifiedHours,volunteers,pledges);
}

@override
String toString() {
    return 'Stats(organisations: $organisations, drives: $drives, certifiedHours: $certifiedHours, volunteers: $volunteers, pledges: $pledges)';
}


}

/// @nodoc
abstract mixin class _$StatsCopyWith<$Res> implements $StatsCopyWith<$Res> {
  factory _$StatsCopyWith(_Stats value, $Res Function(_Stats) _then) = __$StatsCopyWithImpl;
@override @useResult
$Res call({
 int organisations, int drives,@JsonKey(name: 'certified_hours') num certifiedHours, int volunteers, int pledges
});




}
/// @nodoc
class __$StatsCopyWithImpl<$Res>
    implements _$StatsCopyWith<$Res> {
  __$StatsCopyWithImpl(this._self, this._then);

  final _Stats _self;
  final $Res Function(_Stats) _then;

/// Create a copy of Stats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organisations = null,Object? drives = null,Object? certifiedHours = null,Object? volunteers = null,Object? pledges = null,}) {
  return _then(_Stats(
organisations: null == organisations ? _self.organisations : organisations // ignore: cast_nullable_to_non_nullable
as int,drives: null == drives ? _self.drives : drives // ignore: cast_nullable_to_non_nullable
as int,certifiedHours: null == certifiedHours ? _self.certifiedHours : certifiedHours // ignore: cast_nullable_to_non_nullable
as num,volunteers: null == volunteers ? _self.volunteers : volunteers // ignore: cast_nullable_to_non_nullable
as int,pledges: null == pledges ? _self.pledges : pledges // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CheckInResult {

@JsonKey(name: 'attendance_id') String get attendanceId;@JsonKey(name: 'drive_title') String get driveTitle;@JsonKey(name: 'org_name') String get orgName; num get hours; String get status; bool get already;
/// Create a copy of CheckInResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckInResultCopyWith<CheckInResult> get copyWith => _$CheckInResultCopyWithImpl<CheckInResult>(this as CheckInResult, _$identity);

  /// Serializes this CheckInResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CheckInResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckInResult&&(identical(other.attendanceId, _this.attendanceId) || other.attendanceId == _this.attendanceId)&&(identical(other.driveTitle, _this.driveTitle) || other.driveTitle == _this.driveTitle)&&(identical(other.orgName, _this.orgName) || other.orgName == _this.orgName)&&(identical(other.hours, _this.hours) || other.hours == _this.hours)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.already, _this.already) || other.already == _this.already));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CheckInResult;
  return Object.hash(runtimeType,_this.attendanceId,_this.driveTitle,_this.orgName,_this.hours,_this.status,_this.already);
}

@override
String toString() {
  final _this = this as CheckInResult;
  return 'CheckInResult(attendanceId: ${_this.attendanceId}, driveTitle: ${_this.driveTitle}, orgName: ${_this.orgName}, hours: ${_this.hours}, status: ${_this.status}, already: ${_this.already})';
}


}

/// @nodoc
abstract mixin class $CheckInResultCopyWith<$Res>  {
  factory $CheckInResultCopyWith(CheckInResult value, $Res Function(CheckInResult) _then) = _$CheckInResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'attendance_id') String attendanceId,@JsonKey(name: 'drive_title') String driveTitle,@JsonKey(name: 'org_name') String orgName, num hours, String status, bool already
});




}
/// @nodoc
class _$CheckInResultCopyWithImpl<$Res>
    implements $CheckInResultCopyWith<$Res> {
  _$CheckInResultCopyWithImpl(this._self, this._then);

  final CheckInResult _self;
  final $Res Function(CheckInResult) _then;

/// Create a copy of CheckInResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attendanceId = null,Object? driveTitle = null,Object? orgName = null,Object? hours = null,Object? status = null,Object? already = null,}) {
  return _then(CheckInResult(
attendanceId: null == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String,driveTitle: null == driveTitle ? _self.driveTitle : driveTitle // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,already: null == already ? _self.already : already // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckInResult].
extension CheckInResultPatterns on CheckInResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckInResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckInResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckInResult value)  $default,){
final _that = this;
switch (_that) {
case _CheckInResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckInResult value)?  $default,){
final _that = this;
switch (_that) {
case _CheckInResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'drive_title')  String driveTitle, @JsonKey(name: 'org_name')  String orgName,  num hours,  String status,  bool already)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckInResult() when $default != null:
return $default(_that.attendanceId,_that.driveTitle,_that.orgName,_that.hours,_that.status,_that.already);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'drive_title')  String driveTitle, @JsonKey(name: 'org_name')  String orgName,  num hours,  String status,  bool already)  $default,) {final _that = this;
switch (_that) {
case _CheckInResult():
return $default(_that.attendanceId,_that.driveTitle,_that.orgName,_that.hours,_that.status,_that.already);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'drive_title')  String driveTitle, @JsonKey(name: 'org_name')  String orgName,  num hours,  String status,  bool already)?  $default,) {final _that = this;
switch (_that) {
case _CheckInResult() when $default != null:
return $default(_that.attendanceId,_that.driveTitle,_that.orgName,_that.hours,_that.status,_that.already);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckInResult implements CheckInResult {
  const _CheckInResult({@JsonKey(name: 'attendance_id') required this.attendanceId, @JsonKey(name: 'drive_title') required this.driveTitle, @JsonKey(name: 'org_name') required this.orgName, required this.hours, required this.status, this.already = false});
  factory _CheckInResult.fromJson(Map<String, dynamic> json) => _$CheckInResultFromJson(json);

@override@JsonKey(name: 'attendance_id') final  String attendanceId;
@override@JsonKey(name: 'drive_title') final  String driveTitle;
@override@JsonKey(name: 'org_name') final  String orgName;
@override final  num hours;
@override final  String status;
@override@JsonKey() final  bool already;

/// Create a copy of CheckInResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckInResultCopyWith<_CheckInResult> get copyWith => __$CheckInResultCopyWithImpl<_CheckInResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckInResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckInResult&&(identical(other.attendanceId, attendanceId) || other.attendanceId == attendanceId)&&(identical(other.driveTitle, driveTitle) || other.driveTitle == driveTitle)&&(identical(other.orgName, orgName) || other.orgName == orgName)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.status, status) || other.status == status)&&(identical(other.already, already) || other.already == already));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,attendanceId,driveTitle,orgName,hours,status,already);
}

@override
String toString() {
    return 'CheckInResult(attendanceId: $attendanceId, driveTitle: $driveTitle, orgName: $orgName, hours: $hours, status: $status, already: $already)';
}


}

/// @nodoc
abstract mixin class _$CheckInResultCopyWith<$Res> implements $CheckInResultCopyWith<$Res> {
  factory _$CheckInResultCopyWith(_CheckInResult value, $Res Function(_CheckInResult) _then) = __$CheckInResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'attendance_id') String attendanceId,@JsonKey(name: 'drive_title') String driveTitle,@JsonKey(name: 'org_name') String orgName, num hours, String status, bool already
});




}
/// @nodoc
class __$CheckInResultCopyWithImpl<$Res>
    implements _$CheckInResultCopyWith<$Res> {
  __$CheckInResultCopyWithImpl(this._self, this._then);

  final _CheckInResult _self;
  final $Res Function(_CheckInResult) _then;

/// Create a copy of CheckInResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attendanceId = null,Object? driveTitle = null,Object? orgName = null,Object? hours = null,Object? status = null,Object? already = null,}) {
  return _then(_CheckInResult(
attendanceId: null == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String,driveTitle: null == driveTitle ? _self.driveTitle : driveTitle // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,already: null == already ? _self.already : already // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PassportRow {

@JsonKey(name: 'attendance_id') String get attendanceId;@JsonKey(name: 'drive_id') String get driveId;@JsonKey(name: 'drive_title') String get driveTitle;@JsonKey(name: 'starts_at') DateTime get startsAt;@JsonKey(name: 'drive_status') String get driveStatus;@JsonKey(name: 'org_id') String get orgId;@JsonKey(name: 'org_name') String get orgName; num get hours; String get status; String get method;@JsonKey(name: 'check_in_at') DateTime get checkInAt;@JsonKey(name: 'certified_at') DateTime? get certifiedAt;@JsonKey(name: 'certificate_code') String? get certificateCode;
/// Create a copy of PassportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PassportRowCopyWith<PassportRow> get copyWith => _$PassportRowCopyWithImpl<PassportRow>(this as PassportRow, _$identity);

  /// Serializes this PassportRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PassportRow;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PassportRow&&(identical(other.attendanceId, _this.attendanceId) || other.attendanceId == _this.attendanceId)&&(identical(other.driveId, _this.driveId) || other.driveId == _this.driveId)&&(identical(other.driveTitle, _this.driveTitle) || other.driveTitle == _this.driveTitle)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.driveStatus, _this.driveStatus) || other.driveStatus == _this.driveStatus)&&(identical(other.orgId, _this.orgId) || other.orgId == _this.orgId)&&(identical(other.orgName, _this.orgName) || other.orgName == _this.orgName)&&(identical(other.hours, _this.hours) || other.hours == _this.hours)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.method, _this.method) || other.method == _this.method)&&(identical(other.checkInAt, _this.checkInAt) || other.checkInAt == _this.checkInAt)&&(identical(other.certifiedAt, _this.certifiedAt) || other.certifiedAt == _this.certifiedAt)&&(identical(other.certificateCode, _this.certificateCode) || other.certificateCode == _this.certificateCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PassportRow;
  return Object.hash(runtimeType,_this.attendanceId,_this.driveId,_this.driveTitle,_this.startsAt,_this.driveStatus,_this.orgId,_this.orgName,_this.hours,_this.status,_this.method,_this.checkInAt,_this.certifiedAt,_this.certificateCode);
}

@override
String toString() {
  final _this = this as PassportRow;
  return 'PassportRow(attendanceId: ${_this.attendanceId}, driveId: ${_this.driveId}, driveTitle: ${_this.driveTitle}, startsAt: ${_this.startsAt}, driveStatus: ${_this.driveStatus}, orgId: ${_this.orgId}, orgName: ${_this.orgName}, hours: ${_this.hours}, status: ${_this.status}, method: ${_this.method}, checkInAt: ${_this.checkInAt}, certifiedAt: ${_this.certifiedAt}, certificateCode: ${_this.certificateCode})';
}


}

/// @nodoc
abstract mixin class $PassportRowCopyWith<$Res>  {
  factory $PassportRowCopyWith(PassportRow value, $Res Function(PassportRow) _then) = _$PassportRowCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'attendance_id') String attendanceId,@JsonKey(name: 'drive_id') String driveId,@JsonKey(name: 'drive_title') String driveTitle,@JsonKey(name: 'starts_at') DateTime startsAt,@JsonKey(name: 'drive_status') String driveStatus,@JsonKey(name: 'org_id') String orgId,@JsonKey(name: 'org_name') String orgName, num hours, String status, String method,@JsonKey(name: 'check_in_at') DateTime checkInAt,@JsonKey(name: 'certified_at') DateTime? certifiedAt,@JsonKey(name: 'certificate_code') String? certificateCode
});




}
/// @nodoc
class _$PassportRowCopyWithImpl<$Res>
    implements $PassportRowCopyWith<$Res> {
  _$PassportRowCopyWithImpl(this._self, this._then);

  final PassportRow _self;
  final $Res Function(PassportRow) _then;

/// Create a copy of PassportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attendanceId = null,Object? driveId = null,Object? driveTitle = null,Object? startsAt = null,Object? driveStatus = null,Object? orgId = null,Object? orgName = null,Object? hours = null,Object? status = null,Object? method = null,Object? checkInAt = null,Object? certifiedAt = freezed,Object? certificateCode = freezed,}) {
  return _then(PassportRow(
attendanceId: null == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String,driveId: null == driveId ? _self.driveId : driveId // ignore: cast_nullable_to_non_nullable
as String,driveTitle: null == driveTitle ? _self.driveTitle : driveTitle // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,driveStatus: null == driveStatus ? _self.driveStatus : driveStatus // ignore: cast_nullable_to_non_nullable
as String,orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,checkInAt: null == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime,certifiedAt: freezed == certifiedAt ? _self.certifiedAt : certifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,certificateCode: freezed == certificateCode ? _self.certificateCode : certificateCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PassportRow].
extension PassportRowPatterns on PassportRow {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PassportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PassportRow() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PassportRow value)  $default,){
final _that = this;
switch (_that) {
case _PassportRow():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PassportRow value)?  $default,){
final _that = this;
switch (_that) {
case _PassportRow() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'drive_id')  String driveId, @JsonKey(name: 'drive_title')  String driveTitle, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'drive_status')  String driveStatus, @JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName,  num hours,  String status,  String method, @JsonKey(name: 'check_in_at')  DateTime checkInAt, @JsonKey(name: 'certified_at')  DateTime? certifiedAt, @JsonKey(name: 'certificate_code')  String? certificateCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PassportRow() when $default != null:
return $default(_that.attendanceId,_that.driveId,_that.driveTitle,_that.startsAt,_that.driveStatus,_that.orgId,_that.orgName,_that.hours,_that.status,_that.method,_that.checkInAt,_that.certifiedAt,_that.certificateCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'drive_id')  String driveId, @JsonKey(name: 'drive_title')  String driveTitle, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'drive_status')  String driveStatus, @JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName,  num hours,  String status,  String method, @JsonKey(name: 'check_in_at')  DateTime checkInAt, @JsonKey(name: 'certified_at')  DateTime? certifiedAt, @JsonKey(name: 'certificate_code')  String? certificateCode)  $default,) {final _that = this;
switch (_that) {
case _PassportRow():
return $default(_that.attendanceId,_that.driveId,_that.driveTitle,_that.startsAt,_that.driveStatus,_that.orgId,_that.orgName,_that.hours,_that.status,_that.method,_that.checkInAt,_that.certifiedAt,_that.certificateCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'drive_id')  String driveId, @JsonKey(name: 'drive_title')  String driveTitle, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'drive_status')  String driveStatus, @JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName,  num hours,  String status,  String method, @JsonKey(name: 'check_in_at')  DateTime checkInAt, @JsonKey(name: 'certified_at')  DateTime? certifiedAt, @JsonKey(name: 'certificate_code')  String? certificateCode)?  $default,) {final _that = this;
switch (_that) {
case _PassportRow() when $default != null:
return $default(_that.attendanceId,_that.driveId,_that.driveTitle,_that.startsAt,_that.driveStatus,_that.orgId,_that.orgName,_that.hours,_that.status,_that.method,_that.checkInAt,_that.certifiedAt,_that.certificateCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PassportRow extends PassportRow {
  const _PassportRow({@JsonKey(name: 'attendance_id') required this.attendanceId, @JsonKey(name: 'drive_id') required this.driveId, @JsonKey(name: 'drive_title') required this.driveTitle, @JsonKey(name: 'starts_at') required this.startsAt, @JsonKey(name: 'drive_status') required this.driveStatus, @JsonKey(name: 'org_id') required this.orgId, @JsonKey(name: 'org_name') required this.orgName, required this.hours, required this.status, required this.method, @JsonKey(name: 'check_in_at') required this.checkInAt, @JsonKey(name: 'certified_at') this.certifiedAt, @JsonKey(name: 'certificate_code') this.certificateCode}): super._();
  factory _PassportRow.fromJson(Map<String, dynamic> json) => _$PassportRowFromJson(json);

@override@JsonKey(name: 'attendance_id') final  String attendanceId;
@override@JsonKey(name: 'drive_id') final  String driveId;
@override@JsonKey(name: 'drive_title') final  String driveTitle;
@override@JsonKey(name: 'starts_at') final  DateTime startsAt;
@override@JsonKey(name: 'drive_status') final  String driveStatus;
@override@JsonKey(name: 'org_id') final  String orgId;
@override@JsonKey(name: 'org_name') final  String orgName;
@override final  num hours;
@override final  String status;
@override final  String method;
@override@JsonKey(name: 'check_in_at') final  DateTime checkInAt;
@override@JsonKey(name: 'certified_at') final  DateTime? certifiedAt;
@override@JsonKey(name: 'certificate_code') final  String? certificateCode;

/// Create a copy of PassportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PassportRowCopyWith<_PassportRow> get copyWith => __$PassportRowCopyWithImpl<_PassportRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PassportRowToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PassportRow&&(identical(other.attendanceId, attendanceId) || other.attendanceId == attendanceId)&&(identical(other.driveId, driveId) || other.driveId == driveId)&&(identical(other.driveTitle, driveTitle) || other.driveTitle == driveTitle)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.driveStatus, driveStatus) || other.driveStatus == driveStatus)&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.orgName, orgName) || other.orgName == orgName)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.status, status) || other.status == status)&&(identical(other.method, method) || other.method == method)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.certifiedAt, certifiedAt) || other.certifiedAt == certifiedAt)&&(identical(other.certificateCode, certificateCode) || other.certificateCode == certificateCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,attendanceId,driveId,driveTitle,startsAt,driveStatus,orgId,orgName,hours,status,method,checkInAt,certifiedAt,certificateCode);
}

@override
String toString() {
    return 'PassportRow(attendanceId: $attendanceId, driveId: $driveId, driveTitle: $driveTitle, startsAt: $startsAt, driveStatus: $driveStatus, orgId: $orgId, orgName: $orgName, hours: $hours, status: $status, method: $method, checkInAt: $checkInAt, certifiedAt: $certifiedAt, certificateCode: $certificateCode)';
}


}

/// @nodoc
abstract mixin class _$PassportRowCopyWith<$Res> implements $PassportRowCopyWith<$Res> {
  factory _$PassportRowCopyWith(_PassportRow value, $Res Function(_PassportRow) _then) = __$PassportRowCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'attendance_id') String attendanceId,@JsonKey(name: 'drive_id') String driveId,@JsonKey(name: 'drive_title') String driveTitle,@JsonKey(name: 'starts_at') DateTime startsAt,@JsonKey(name: 'drive_status') String driveStatus,@JsonKey(name: 'org_id') String orgId,@JsonKey(name: 'org_name') String orgName, num hours, String status, String method,@JsonKey(name: 'check_in_at') DateTime checkInAt,@JsonKey(name: 'certified_at') DateTime? certifiedAt,@JsonKey(name: 'certificate_code') String? certificateCode
});




}
/// @nodoc
class __$PassportRowCopyWithImpl<$Res>
    implements _$PassportRowCopyWith<$Res> {
  __$PassportRowCopyWithImpl(this._self, this._then);

  final _PassportRow _self;
  final $Res Function(_PassportRow) _then;

/// Create a copy of PassportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attendanceId = null,Object? driveId = null,Object? driveTitle = null,Object? startsAt = null,Object? driveStatus = null,Object? orgId = null,Object? orgName = null,Object? hours = null,Object? status = null,Object? method = null,Object? checkInAt = null,Object? certifiedAt = freezed,Object? certificateCode = freezed,}) {
  return _then(_PassportRow(
attendanceId: null == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String,driveId: null == driveId ? _self.driveId : driveId // ignore: cast_nullable_to_non_nullable
as String,driveTitle: null == driveTitle ? _self.driveTitle : driveTitle // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,driveStatus: null == driveStatus ? _self.driveStatus : driveStatus // ignore: cast_nullable_to_non_nullable
as String,orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,checkInAt: null == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime,certifiedAt: freezed == certifiedAt ? _self.certifiedAt : certifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,certificateCode: freezed == certificateCode ? _self.certificateCode : certificateCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PassportPledge {

@JsonKey(name: 'pledge_id') String get pledgeId; String get title; String? get campaign;@JsonKey(name: 'share_code') String get shareCode;@JsonKey(name: 'org_name') String get orgName;@JsonKey(name: 'signature_no') int get signatureNo;@JsonKey(name: 'signed_at') DateTime get signedAt;@JsonKey(name: 'certificate_code') String? get certificateCode;
/// Create a copy of PassportPledge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PassportPledgeCopyWith<PassportPledge> get copyWith => _$PassportPledgeCopyWithImpl<PassportPledge>(this as PassportPledge, _$identity);

  /// Serializes this PassportPledge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PassportPledge;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PassportPledge&&(identical(other.pledgeId, _this.pledgeId) || other.pledgeId == _this.pledgeId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.campaign, _this.campaign) || other.campaign == _this.campaign)&&(identical(other.shareCode, _this.shareCode) || other.shareCode == _this.shareCode)&&(identical(other.orgName, _this.orgName) || other.orgName == _this.orgName)&&(identical(other.signatureNo, _this.signatureNo) || other.signatureNo == _this.signatureNo)&&(identical(other.signedAt, _this.signedAt) || other.signedAt == _this.signedAt)&&(identical(other.certificateCode, _this.certificateCode) || other.certificateCode == _this.certificateCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PassportPledge;
  return Object.hash(runtimeType,_this.pledgeId,_this.title,_this.campaign,_this.shareCode,_this.orgName,_this.signatureNo,_this.signedAt,_this.certificateCode);
}

@override
String toString() {
  final _this = this as PassportPledge;
  return 'PassportPledge(pledgeId: ${_this.pledgeId}, title: ${_this.title}, campaign: ${_this.campaign}, shareCode: ${_this.shareCode}, orgName: ${_this.orgName}, signatureNo: ${_this.signatureNo}, signedAt: ${_this.signedAt}, certificateCode: ${_this.certificateCode})';
}


}

/// @nodoc
abstract mixin class $PassportPledgeCopyWith<$Res>  {
  factory $PassportPledgeCopyWith(PassportPledge value, $Res Function(PassportPledge) _then) = _$PassportPledgeCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'pledge_id') String pledgeId, String title, String? campaign,@JsonKey(name: 'share_code') String shareCode,@JsonKey(name: 'org_name') String orgName,@JsonKey(name: 'signature_no') int signatureNo,@JsonKey(name: 'signed_at') DateTime signedAt,@JsonKey(name: 'certificate_code') String? certificateCode
});




}
/// @nodoc
class _$PassportPledgeCopyWithImpl<$Res>
    implements $PassportPledgeCopyWith<$Res> {
  _$PassportPledgeCopyWithImpl(this._self, this._then);

  final PassportPledge _self;
  final $Res Function(PassportPledge) _then;

/// Create a copy of PassportPledge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pledgeId = null,Object? title = null,Object? campaign = freezed,Object? shareCode = null,Object? orgName = null,Object? signatureNo = null,Object? signedAt = null,Object? certificateCode = freezed,}) {
  return _then(PassportPledge(
pledgeId: null == pledgeId ? _self.pledgeId : pledgeId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as String?,shareCode: null == shareCode ? _self.shareCode : shareCode // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,signatureNo: null == signatureNo ? _self.signatureNo : signatureNo // ignore: cast_nullable_to_non_nullable
as int,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,certificateCode: freezed == certificateCode ? _self.certificateCode : certificateCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PassportPledge].
extension PassportPledgePatterns on PassportPledge {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PassportPledge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PassportPledge() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PassportPledge value)  $default,){
final _that = this;
switch (_that) {
case _PassportPledge():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PassportPledge value)?  $default,){
final _that = this;
switch (_that) {
case _PassportPledge() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'pledge_id')  String pledgeId,  String title,  String? campaign, @JsonKey(name: 'share_code')  String shareCode, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt, @JsonKey(name: 'certificate_code')  String? certificateCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PassportPledge() when $default != null:
return $default(_that.pledgeId,_that.title,_that.campaign,_that.shareCode,_that.orgName,_that.signatureNo,_that.signedAt,_that.certificateCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'pledge_id')  String pledgeId,  String title,  String? campaign, @JsonKey(name: 'share_code')  String shareCode, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt, @JsonKey(name: 'certificate_code')  String? certificateCode)  $default,) {final _that = this;
switch (_that) {
case _PassportPledge():
return $default(_that.pledgeId,_that.title,_that.campaign,_that.shareCode,_that.orgName,_that.signatureNo,_that.signedAt,_that.certificateCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'pledge_id')  String pledgeId,  String title,  String? campaign, @JsonKey(name: 'share_code')  String shareCode, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt, @JsonKey(name: 'certificate_code')  String? certificateCode)?  $default,) {final _that = this;
switch (_that) {
case _PassportPledge() when $default != null:
return $default(_that.pledgeId,_that.title,_that.campaign,_that.shareCode,_that.orgName,_that.signatureNo,_that.signedAt,_that.certificateCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PassportPledge implements PassportPledge {
  const _PassportPledge({@JsonKey(name: 'pledge_id') required this.pledgeId, required this.title, this.campaign, @JsonKey(name: 'share_code') required this.shareCode, @JsonKey(name: 'org_name') required this.orgName, @JsonKey(name: 'signature_no') required this.signatureNo, @JsonKey(name: 'signed_at') required this.signedAt, @JsonKey(name: 'certificate_code') this.certificateCode});
  factory _PassportPledge.fromJson(Map<String, dynamic> json) => _$PassportPledgeFromJson(json);

@override@JsonKey(name: 'pledge_id') final  String pledgeId;
@override final  String title;
@override final  String? campaign;
@override@JsonKey(name: 'share_code') final  String shareCode;
@override@JsonKey(name: 'org_name') final  String orgName;
@override@JsonKey(name: 'signature_no') final  int signatureNo;
@override@JsonKey(name: 'signed_at') final  DateTime signedAt;
@override@JsonKey(name: 'certificate_code') final  String? certificateCode;

/// Create a copy of PassportPledge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PassportPledgeCopyWith<_PassportPledge> get copyWith => __$PassportPledgeCopyWithImpl<_PassportPledge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PassportPledgeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PassportPledge&&(identical(other.pledgeId, pledgeId) || other.pledgeId == pledgeId)&&(identical(other.title, title) || other.title == title)&&(identical(other.campaign, campaign) || other.campaign == campaign)&&(identical(other.shareCode, shareCode) || other.shareCode == shareCode)&&(identical(other.orgName, orgName) || other.orgName == orgName)&&(identical(other.signatureNo, signatureNo) || other.signatureNo == signatureNo)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt)&&(identical(other.certificateCode, certificateCode) || other.certificateCode == certificateCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,pledgeId,title,campaign,shareCode,orgName,signatureNo,signedAt,certificateCode);
}

@override
String toString() {
    return 'PassportPledge(pledgeId: $pledgeId, title: $title, campaign: $campaign, shareCode: $shareCode, orgName: $orgName, signatureNo: $signatureNo, signedAt: $signedAt, certificateCode: $certificateCode)';
}


}

/// @nodoc
abstract mixin class _$PassportPledgeCopyWith<$Res> implements $PassportPledgeCopyWith<$Res> {
  factory _$PassportPledgeCopyWith(_PassportPledge value, $Res Function(_PassportPledge) _then) = __$PassportPledgeCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'pledge_id') String pledgeId, String title, String? campaign,@JsonKey(name: 'share_code') String shareCode,@JsonKey(name: 'org_name') String orgName,@JsonKey(name: 'signature_no') int signatureNo,@JsonKey(name: 'signed_at') DateTime signedAt,@JsonKey(name: 'certificate_code') String? certificateCode
});




}
/// @nodoc
class __$PassportPledgeCopyWithImpl<$Res>
    implements _$PassportPledgeCopyWith<$Res> {
  __$PassportPledgeCopyWithImpl(this._self, this._then);

  final _PassportPledge _self;
  final $Res Function(_PassportPledge) _then;

/// Create a copy of PassportPledge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pledgeId = null,Object? title = null,Object? campaign = freezed,Object? shareCode = null,Object? orgName = null,Object? signatureNo = null,Object? signedAt = null,Object? certificateCode = freezed,}) {
  return _then(_PassportPledge(
pledgeId: null == pledgeId ? _self.pledgeId : pledgeId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as String?,shareCode: null == shareCode ? _self.shareCode : shareCode // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,signatureNo: null == signatureNo ? _self.signatureNo : signatureNo // ignore: cast_nullable_to_non_nullable
as int,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,certificateCode: freezed == certificateCode ? _self.certificateCode : certificateCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Passport {

@JsonKey(name: 'certified_hours') num get certifiedHours;@JsonKey(name: 'pending_hours') num get pendingHours;@JsonKey(name: 'certified_drives') int get certifiedDrives; List<PassportRow> get attendance; List<PassportPledge> get pledges;
/// Create a copy of Passport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PassportCopyWith<Passport> get copyWith => _$PassportCopyWithImpl<Passport>(this as Passport, _$identity);

  /// Serializes this Passport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Passport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Passport&&(identical(other.certifiedHours, _this.certifiedHours) || other.certifiedHours == _this.certifiedHours)&&(identical(other.pendingHours, _this.pendingHours) || other.pendingHours == _this.pendingHours)&&(identical(other.certifiedDrives, _this.certifiedDrives) || other.certifiedDrives == _this.certifiedDrives)&&const DeepCollectionEquality().equals(other.attendance, _this.attendance)&&const DeepCollectionEquality().equals(other.pledges, _this.pledges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Passport;
  return Object.hash(runtimeType,_this.certifiedHours,_this.pendingHours,_this.certifiedDrives,const DeepCollectionEquality().hash(_this.attendance),const DeepCollectionEquality().hash(_this.pledges));
}

@override
String toString() {
  final _this = this as Passport;
  return 'Passport(certifiedHours: ${_this.certifiedHours}, pendingHours: ${_this.pendingHours}, certifiedDrives: ${_this.certifiedDrives}, attendance: ${_this.attendance}, pledges: ${_this.pledges})';
}


}

/// @nodoc
abstract mixin class $PassportCopyWith<$Res>  {
  factory $PassportCopyWith(Passport value, $Res Function(Passport) _then) = _$PassportCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'certified_hours') num certifiedHours,@JsonKey(name: 'pending_hours') num pendingHours,@JsonKey(name: 'certified_drives') int certifiedDrives, List<PassportRow> attendance, List<PassportPledge> pledges
});




}
/// @nodoc
class _$PassportCopyWithImpl<$Res>
    implements $PassportCopyWith<$Res> {
  _$PassportCopyWithImpl(this._self, this._then);

  final Passport _self;
  final $Res Function(Passport) _then;

/// Create a copy of Passport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? certifiedHours = null,Object? pendingHours = null,Object? certifiedDrives = null,Object? attendance = null,Object? pledges = null,}) {
  return _then(Passport(
certifiedHours: null == certifiedHours ? _self.certifiedHours : certifiedHours // ignore: cast_nullable_to_non_nullable
as num,pendingHours: null == pendingHours ? _self.pendingHours : pendingHours // ignore: cast_nullable_to_non_nullable
as num,certifiedDrives: null == certifiedDrives ? _self.certifiedDrives : certifiedDrives // ignore: cast_nullable_to_non_nullable
as int,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as List<PassportRow>,pledges: null == pledges ? _self.pledges : pledges // ignore: cast_nullable_to_non_nullable
as List<PassportPledge>,
  ));
}

}


/// Adds pattern-matching-related methods to [Passport].
extension PassportPatterns on Passport {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Passport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Passport() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Passport value)  $default,){
final _that = this;
switch (_that) {
case _Passport():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Passport value)?  $default,){
final _that = this;
switch (_that) {
case _Passport() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'certified_hours')  num certifiedHours, @JsonKey(name: 'pending_hours')  num pendingHours, @JsonKey(name: 'certified_drives')  int certifiedDrives,  List<PassportRow> attendance,  List<PassportPledge> pledges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Passport() when $default != null:
return $default(_that.certifiedHours,_that.pendingHours,_that.certifiedDrives,_that.attendance,_that.pledges);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'certified_hours')  num certifiedHours, @JsonKey(name: 'pending_hours')  num pendingHours, @JsonKey(name: 'certified_drives')  int certifiedDrives,  List<PassportRow> attendance,  List<PassportPledge> pledges)  $default,) {final _that = this;
switch (_that) {
case _Passport():
return $default(_that.certifiedHours,_that.pendingHours,_that.certifiedDrives,_that.attendance,_that.pledges);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'certified_hours')  num certifiedHours, @JsonKey(name: 'pending_hours')  num pendingHours, @JsonKey(name: 'certified_drives')  int certifiedDrives,  List<PassportRow> attendance,  List<PassportPledge> pledges)?  $default,) {final _that = this;
switch (_that) {
case _Passport() when $default != null:
return $default(_that.certifiedHours,_that.pendingHours,_that.certifiedDrives,_that.attendance,_that.pledges);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Passport implements Passport {
  const _Passport({@JsonKey(name: 'certified_hours') this.certifiedHours = 0, @JsonKey(name: 'pending_hours') this.pendingHours = 0, @JsonKey(name: 'certified_drives') this.certifiedDrives = 0,  List<PassportRow> attendance = const [],  List<PassportPledge> pledges = const []}): _attendance = attendance,_pledges = pledges;
  factory _Passport.fromJson(Map<String, dynamic> json) => _$PassportFromJson(json);

@override@JsonKey(name: 'certified_hours') final  num certifiedHours;
@override@JsonKey(name: 'pending_hours') final  num pendingHours;
@override@JsonKey(name: 'certified_drives') final  int certifiedDrives;
 final  List<PassportRow> _attendance;
@override@JsonKey() List<PassportRow> get attendance {
  if (_attendance is EqualUnmodifiableListView) return _attendance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attendance);
}

 final  List<PassportPledge> _pledges;
@override@JsonKey() List<PassportPledge> get pledges {
  if (_pledges is EqualUnmodifiableListView) return _pledges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pledges);
}


/// Create a copy of Passport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PassportCopyWith<_Passport> get copyWith => __$PassportCopyWithImpl<_Passport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PassportToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Passport&&(identical(other.certifiedHours, certifiedHours) || other.certifiedHours == certifiedHours)&&(identical(other.pendingHours, pendingHours) || other.pendingHours == pendingHours)&&(identical(other.certifiedDrives, certifiedDrives) || other.certifiedDrives == certifiedDrives)&&const DeepCollectionEquality().equals(other.attendance, _attendance)&&const DeepCollectionEquality().equals(other.pledges, _pledges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,certifiedHours,pendingHours,certifiedDrives,const DeepCollectionEquality().hash(_attendance),const DeepCollectionEquality().hash(_pledges));
}

@override
String toString() {
    return 'Passport(certifiedHours: $certifiedHours, pendingHours: $pendingHours, certifiedDrives: $certifiedDrives, attendance: $attendance, pledges: $pledges)';
}


}

/// @nodoc
abstract mixin class _$PassportCopyWith<$Res> implements $PassportCopyWith<$Res> {
  factory _$PassportCopyWith(_Passport value, $Res Function(_Passport) _then) = __$PassportCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'certified_hours') num certifiedHours,@JsonKey(name: 'pending_hours') num pendingHours,@JsonKey(name: 'certified_drives') int certifiedDrives, List<PassportRow> attendance, List<PassportPledge> pledges
});




}
/// @nodoc
class __$PassportCopyWithImpl<$Res>
    implements _$PassportCopyWith<$Res> {
  __$PassportCopyWithImpl(this._self, this._then);

  final _Passport _self;
  final $Res Function(_Passport) _then;

/// Create a copy of Passport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? certifiedHours = null,Object? pendingHours = null,Object? certifiedDrives = null,Object? attendance = null,Object? pledges = null,}) {
  return _then(_Passport(
certifiedHours: null == certifiedHours ? _self.certifiedHours : certifiedHours // ignore: cast_nullable_to_non_nullable
as num,pendingHours: null == pendingHours ? _self.pendingHours : pendingHours // ignore: cast_nullable_to_non_nullable
as num,certifiedDrives: null == certifiedDrives ? _self.certifiedDrives : certifiedDrives // ignore: cast_nullable_to_non_nullable
as int,attendance: null == attendance ? _self._attendance : attendance // ignore: cast_nullable_to_non_nullable
as List<PassportRow>,pledges: null == pledges ? _self._pledges : pledges // ignore: cast_nullable_to_non_nullable
as List<PassportPledge>,
  ));
}


}


/// @nodoc
mixin _$UpcomingDrive {

 String get id; String get title;@JsonKey(name: 'starts_at') DateTime get startsAt;@JsonKey(name: 'ends_at') DateTime get endsAt; String? get venue; String? get city;@JsonKey(name: 'org_name') String get orgName;@JsonKey(name: 'default_hours') num get defaultHours; String get status;
/// Create a copy of UpcomingDrive
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingDriveCopyWith<UpcomingDrive> get copyWith => _$UpcomingDriveCopyWithImpl<UpcomingDrive>(this as UpcomingDrive, _$identity);

  /// Serializes this UpcomingDrive to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UpcomingDrive;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingDrive&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.venue, _this.venue) || other.venue == _this.venue)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.orgName, _this.orgName) || other.orgName == _this.orgName)&&(identical(other.defaultHours, _this.defaultHours) || other.defaultHours == _this.defaultHours)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UpcomingDrive;
  return Object.hash(runtimeType,_this.id,_this.title,_this.startsAt,_this.endsAt,_this.venue,_this.city,_this.orgName,_this.defaultHours,_this.status);
}

@override
String toString() {
  final _this = this as UpcomingDrive;
  return 'UpcomingDrive(id: ${_this.id}, title: ${_this.title}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, venue: ${_this.venue}, city: ${_this.city}, orgName: ${_this.orgName}, defaultHours: ${_this.defaultHours}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $UpcomingDriveCopyWith<$Res>  {
  factory $UpcomingDriveCopyWith(UpcomingDrive value, $Res Function(UpcomingDrive) _then) = _$UpcomingDriveCopyWithImpl;
@useResult
$Res call({
 String id, String title,@JsonKey(name: 'starts_at') DateTime startsAt,@JsonKey(name: 'ends_at') DateTime endsAt, String? venue, String? city,@JsonKey(name: 'org_name') String orgName,@JsonKey(name: 'default_hours') num defaultHours, String status
});




}
/// @nodoc
class _$UpcomingDriveCopyWithImpl<$Res>
    implements $UpcomingDriveCopyWith<$Res> {
  _$UpcomingDriveCopyWithImpl(this._self, this._then);

  final UpcomingDrive _self;
  final $Res Function(UpcomingDrive) _then;

/// Create a copy of UpcomingDrive
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? venue = freezed,Object? city = freezed,Object? orgName = null,Object? defaultHours = null,Object? status = null,}) {
  return _then(UpcomingDrive(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,defaultHours: null == defaultHours ? _self.defaultHours : defaultHours // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpcomingDrive].
extension UpcomingDrivePatterns on UpcomingDrive {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpcomingDrive value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpcomingDrive() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpcomingDrive value)  $default,){
final _that = this;
switch (_that) {
case _UpcomingDrive():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpcomingDrive value)?  $default,){
final _that = this;
switch (_that) {
case _UpcomingDrive() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt,  String? venue,  String? city, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'default_hours')  num defaultHours,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingDrive() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.venue,_that.city,_that.orgName,_that.defaultHours,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt,  String? venue,  String? city, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'default_hours')  num defaultHours,  String status)  $default,) {final _that = this;
switch (_that) {
case _UpcomingDrive():
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.venue,_that.city,_that.orgName,_that.defaultHours,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt,  String? venue,  String? city, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'default_hours')  num defaultHours,  String status)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingDrive() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.venue,_that.city,_that.orgName,_that.defaultHours,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpcomingDrive implements UpcomingDrive {
  const _UpcomingDrive({required this.id, required this.title, @JsonKey(name: 'starts_at') required this.startsAt, @JsonKey(name: 'ends_at') required this.endsAt, this.venue, this.city, @JsonKey(name: 'org_name') required this.orgName, @JsonKey(name: 'default_hours') required this.defaultHours, required this.status});
  factory _UpcomingDrive.fromJson(Map<String, dynamic> json) => _$UpcomingDriveFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey(name: 'starts_at') final  DateTime startsAt;
@override@JsonKey(name: 'ends_at') final  DateTime endsAt;
@override final  String? venue;
@override final  String? city;
@override@JsonKey(name: 'org_name') final  String orgName;
@override@JsonKey(name: 'default_hours') final  num defaultHours;
@override final  String status;

/// Create a copy of UpcomingDrive
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingDriveCopyWith<_UpcomingDrive> get copyWith => __$UpcomingDriveCopyWithImpl<_UpcomingDrive>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpcomingDriveToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingDrive&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.city, city) || other.city == city)&&(identical(other.orgName, orgName) || other.orgName == orgName)&&(identical(other.defaultHours, defaultHours) || other.defaultHours == defaultHours)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,startsAt,endsAt,venue,city,orgName,defaultHours,status);
}

@override
String toString() {
    return 'UpcomingDrive(id: $id, title: $title, startsAt: $startsAt, endsAt: $endsAt, venue: $venue, city: $city, orgName: $orgName, defaultHours: $defaultHours, status: $status)';
}


}

/// @nodoc
abstract mixin class _$UpcomingDriveCopyWith<$Res> implements $UpcomingDriveCopyWith<$Res> {
  factory _$UpcomingDriveCopyWith(_UpcomingDrive value, $Res Function(_UpcomingDrive) _then) = __$UpcomingDriveCopyWithImpl;
@override @useResult
$Res call({
 String id, String title,@JsonKey(name: 'starts_at') DateTime startsAt,@JsonKey(name: 'ends_at') DateTime endsAt, String? venue, String? city,@JsonKey(name: 'org_name') String orgName,@JsonKey(name: 'default_hours') num defaultHours, String status
});




}
/// @nodoc
class __$UpcomingDriveCopyWithImpl<$Res>
    implements _$UpcomingDriveCopyWith<$Res> {
  __$UpcomingDriveCopyWithImpl(this._self, this._then);

  final _UpcomingDrive _self;
  final $Res Function(_UpcomingDrive) _then;

/// Create a copy of UpcomingDrive
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? venue = freezed,Object? city = freezed,Object? orgName = null,Object? defaultHours = null,Object? status = null,}) {
  return _then(_UpcomingDrive(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,defaultHours: null == defaultHours ? _self.defaultHours : defaultHours // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Certificate {

 bool get found; bool get valid; String? get code; String? get kind;@JsonKey(name: 'subject_name') String? get subjectName;@JsonKey(name: 'org_name') String? get orgName; String? get title; num? get hours;@JsonKey(name: 'issued_at') DateTime? get issuedAt;@JsonKey(name: 'revoked_reason') String? get revokedReason;
/// Create a copy of Certificate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CertificateCopyWith<Certificate> get copyWith => _$CertificateCopyWithImpl<Certificate>(this as Certificate, _$identity);

  /// Serializes this Certificate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Certificate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Certificate&&(identical(other.found, _this.found) || other.found == _this.found)&&(identical(other.valid, _this.valid) || other.valid == _this.valid)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.orgName, _this.orgName) || other.orgName == _this.orgName)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.hours, _this.hours) || other.hours == _this.hours)&&(identical(other.issuedAt, _this.issuedAt) || other.issuedAt == _this.issuedAt)&&(identical(other.revokedReason, _this.revokedReason) || other.revokedReason == _this.revokedReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Certificate;
  return Object.hash(runtimeType,_this.found,_this.valid,_this.code,_this.kind,_this.subjectName,_this.orgName,_this.title,_this.hours,_this.issuedAt,_this.revokedReason);
}

@override
String toString() {
  final _this = this as Certificate;
  return 'Certificate(found: ${_this.found}, valid: ${_this.valid}, code: ${_this.code}, kind: ${_this.kind}, subjectName: ${_this.subjectName}, orgName: ${_this.orgName}, title: ${_this.title}, hours: ${_this.hours}, issuedAt: ${_this.issuedAt}, revokedReason: ${_this.revokedReason})';
}


}

/// @nodoc
abstract mixin class $CertificateCopyWith<$Res>  {
  factory $CertificateCopyWith(Certificate value, $Res Function(Certificate) _then) = _$CertificateCopyWithImpl;
@useResult
$Res call({
 bool found, bool valid, String? code, String? kind,@JsonKey(name: 'subject_name') String? subjectName,@JsonKey(name: 'org_name') String? orgName, String? title, num? hours,@JsonKey(name: 'issued_at') DateTime? issuedAt,@JsonKey(name: 'revoked_reason') String? revokedReason
});




}
/// @nodoc
class _$CertificateCopyWithImpl<$Res>
    implements $CertificateCopyWith<$Res> {
  _$CertificateCopyWithImpl(this._self, this._then);

  final Certificate _self;
  final $Res Function(Certificate) _then;

/// Create a copy of Certificate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? found = null,Object? valid = null,Object? code = freezed,Object? kind = freezed,Object? subjectName = freezed,Object? orgName = freezed,Object? title = freezed,Object? hours = freezed,Object? issuedAt = freezed,Object? revokedReason = freezed,}) {
  return _then(Certificate(
found: null == found ? _self.found : found // ignore: cast_nullable_to_non_nullable
as bool,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,orgName: freezed == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,hours: freezed == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as num?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedReason: freezed == revokedReason ? _self.revokedReason : revokedReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Certificate].
extension CertificatePatterns on Certificate {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Certificate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Certificate() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Certificate value)  $default,){
final _that = this;
switch (_that) {
case _Certificate():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Certificate value)?  $default,){
final _that = this;
switch (_that) {
case _Certificate() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool found,  bool valid,  String? code,  String? kind, @JsonKey(name: 'subject_name')  String? subjectName, @JsonKey(name: 'org_name')  String? orgName,  String? title,  num? hours, @JsonKey(name: 'issued_at')  DateTime? issuedAt, @JsonKey(name: 'revoked_reason')  String? revokedReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Certificate() when $default != null:
return $default(_that.found,_that.valid,_that.code,_that.kind,_that.subjectName,_that.orgName,_that.title,_that.hours,_that.issuedAt,_that.revokedReason);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool found,  bool valid,  String? code,  String? kind, @JsonKey(name: 'subject_name')  String? subjectName, @JsonKey(name: 'org_name')  String? orgName,  String? title,  num? hours, @JsonKey(name: 'issued_at')  DateTime? issuedAt, @JsonKey(name: 'revoked_reason')  String? revokedReason)  $default,) {final _that = this;
switch (_that) {
case _Certificate():
return $default(_that.found,_that.valid,_that.code,_that.kind,_that.subjectName,_that.orgName,_that.title,_that.hours,_that.issuedAt,_that.revokedReason);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool found,  bool valid,  String? code,  String? kind, @JsonKey(name: 'subject_name')  String? subjectName, @JsonKey(name: 'org_name')  String? orgName,  String? title,  num? hours, @JsonKey(name: 'issued_at')  DateTime? issuedAt, @JsonKey(name: 'revoked_reason')  String? revokedReason)?  $default,) {final _that = this;
switch (_that) {
case _Certificate() when $default != null:
return $default(_that.found,_that.valid,_that.code,_that.kind,_that.subjectName,_that.orgName,_that.title,_that.hours,_that.issuedAt,_that.revokedReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Certificate extends Certificate {
  const _Certificate({this.found = false, this.valid = false, this.code, this.kind, @JsonKey(name: 'subject_name') this.subjectName, @JsonKey(name: 'org_name') this.orgName, this.title, this.hours, @JsonKey(name: 'issued_at') this.issuedAt, @JsonKey(name: 'revoked_reason') this.revokedReason}): super._();
  factory _Certificate.fromJson(Map<String, dynamic> json) => _$CertificateFromJson(json);

@override@JsonKey() final  bool found;
@override@JsonKey() final  bool valid;
@override final  String? code;
@override final  String? kind;
@override@JsonKey(name: 'subject_name') final  String? subjectName;
@override@JsonKey(name: 'org_name') final  String? orgName;
@override final  String? title;
@override final  num? hours;
@override@JsonKey(name: 'issued_at') final  DateTime? issuedAt;
@override@JsonKey(name: 'revoked_reason') final  String? revokedReason;

/// Create a copy of Certificate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CertificateCopyWith<_Certificate> get copyWith => __$CertificateCopyWithImpl<_Certificate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CertificateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Certificate&&(identical(other.found, found) || other.found == found)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.code, code) || other.code == code)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.orgName, orgName) || other.orgName == orgName)&&(identical(other.title, title) || other.title == title)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.revokedReason, revokedReason) || other.revokedReason == revokedReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,found,valid,code,kind,subjectName,orgName,title,hours,issuedAt,revokedReason);
}

@override
String toString() {
    return 'Certificate(found: $found, valid: $valid, code: $code, kind: $kind, subjectName: $subjectName, orgName: $orgName, title: $title, hours: $hours, issuedAt: $issuedAt, revokedReason: $revokedReason)';
}


}

/// @nodoc
abstract mixin class _$CertificateCopyWith<$Res> implements $CertificateCopyWith<$Res> {
  factory _$CertificateCopyWith(_Certificate value, $Res Function(_Certificate) _then) = __$CertificateCopyWithImpl;
@override @useResult
$Res call({
 bool found, bool valid, String? code, String? kind,@JsonKey(name: 'subject_name') String? subjectName,@JsonKey(name: 'org_name') String? orgName, String? title, num? hours,@JsonKey(name: 'issued_at') DateTime? issuedAt,@JsonKey(name: 'revoked_reason') String? revokedReason
});




}
/// @nodoc
class __$CertificateCopyWithImpl<$Res>
    implements _$CertificateCopyWith<$Res> {
  __$CertificateCopyWithImpl(this._self, this._then);

  final _Certificate _self;
  final $Res Function(_Certificate) _then;

/// Create a copy of Certificate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? found = null,Object? valid = null,Object? code = freezed,Object? kind = freezed,Object? subjectName = freezed,Object? orgName = freezed,Object? title = freezed,Object? hours = freezed,Object? issuedAt = freezed,Object? revokedReason = freezed,}) {
  return _then(_Certificate(
found: null == found ? _self.found : found // ignore: cast_nullable_to_non_nullable
as bool,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,orgName: freezed == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,hours: freezed == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as num?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedReason: freezed == revokedReason ? _self.revokedReason : revokedReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RosterRow {

@JsonKey(name: 'attendance_id') String get attendanceId;@JsonKey(name: 'subject_kind') String get subjectKind;@JsonKey(name: 'display_name') String get displayName;@JsonKey(name: 'class_section') String? get classSection;@JsonKey(name: 'roll_no') String? get rollNo;@JsonKey(name: 'school_name') String? get schoolName; String get method; String get status;@JsonKey(name: 'check_in_at') DateTime get checkInAt; num get hours;@JsonKey(name: 'certified_at') DateTime? get certifiedAt;
/// Create a copy of RosterRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RosterRowCopyWith<RosterRow> get copyWith => _$RosterRowCopyWithImpl<RosterRow>(this as RosterRow, _$identity);

  /// Serializes this RosterRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RosterRow;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RosterRow&&(identical(other.attendanceId, _this.attendanceId) || other.attendanceId == _this.attendanceId)&&(identical(other.subjectKind, _this.subjectKind) || other.subjectKind == _this.subjectKind)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.classSection, _this.classSection) || other.classSection == _this.classSection)&&(identical(other.rollNo, _this.rollNo) || other.rollNo == _this.rollNo)&&(identical(other.schoolName, _this.schoolName) || other.schoolName == _this.schoolName)&&(identical(other.method, _this.method) || other.method == _this.method)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.checkInAt, _this.checkInAt) || other.checkInAt == _this.checkInAt)&&(identical(other.hours, _this.hours) || other.hours == _this.hours)&&(identical(other.certifiedAt, _this.certifiedAt) || other.certifiedAt == _this.certifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RosterRow;
  return Object.hash(runtimeType,_this.attendanceId,_this.subjectKind,_this.displayName,_this.classSection,_this.rollNo,_this.schoolName,_this.method,_this.status,_this.checkInAt,_this.hours,_this.certifiedAt);
}

@override
String toString() {
  final _this = this as RosterRow;
  return 'RosterRow(attendanceId: ${_this.attendanceId}, subjectKind: ${_this.subjectKind}, displayName: ${_this.displayName}, classSection: ${_this.classSection}, rollNo: ${_this.rollNo}, schoolName: ${_this.schoolName}, method: ${_this.method}, status: ${_this.status}, checkInAt: ${_this.checkInAt}, hours: ${_this.hours}, certifiedAt: ${_this.certifiedAt})';
}


}

/// @nodoc
abstract mixin class $RosterRowCopyWith<$Res>  {
  factory $RosterRowCopyWith(RosterRow value, $Res Function(RosterRow) _then) = _$RosterRowCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'attendance_id') String attendanceId,@JsonKey(name: 'subject_kind') String subjectKind,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'class_section') String? classSection,@JsonKey(name: 'roll_no') String? rollNo,@JsonKey(name: 'school_name') String? schoolName, String method, String status,@JsonKey(name: 'check_in_at') DateTime checkInAt, num hours,@JsonKey(name: 'certified_at') DateTime? certifiedAt
});




}
/// @nodoc
class _$RosterRowCopyWithImpl<$Res>
    implements $RosterRowCopyWith<$Res> {
  _$RosterRowCopyWithImpl(this._self, this._then);

  final RosterRow _self;
  final $Res Function(RosterRow) _then;

/// Create a copy of RosterRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attendanceId = null,Object? subjectKind = null,Object? displayName = null,Object? classSection = freezed,Object? rollNo = freezed,Object? schoolName = freezed,Object? method = null,Object? status = null,Object? checkInAt = null,Object? hours = null,Object? certifiedAt = freezed,}) {
  return _then(RosterRow(
attendanceId: null == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String,subjectKind: null == subjectKind ? _self.subjectKind : subjectKind // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,classSection: freezed == classSection ? _self.classSection : classSection // ignore: cast_nullable_to_non_nullable
as String?,rollNo: freezed == rollNo ? _self.rollNo : rollNo // ignore: cast_nullable_to_non_nullable
as String?,schoolName: freezed == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String?,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,checkInAt: null == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as num,certifiedAt: freezed == certifiedAt ? _self.certifiedAt : certifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RosterRow].
extension RosterRowPatterns on RosterRow {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RosterRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RosterRow() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RosterRow value)  $default,){
final _that = this;
switch (_that) {
case _RosterRow():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RosterRow value)?  $default,){
final _that = this;
switch (_that) {
case _RosterRow() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'subject_kind')  String subjectKind, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'class_section')  String? classSection, @JsonKey(name: 'roll_no')  String? rollNo, @JsonKey(name: 'school_name')  String? schoolName,  String method,  String status, @JsonKey(name: 'check_in_at')  DateTime checkInAt,  num hours, @JsonKey(name: 'certified_at')  DateTime? certifiedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RosterRow() when $default != null:
return $default(_that.attendanceId,_that.subjectKind,_that.displayName,_that.classSection,_that.rollNo,_that.schoolName,_that.method,_that.status,_that.checkInAt,_that.hours,_that.certifiedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'subject_kind')  String subjectKind, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'class_section')  String? classSection, @JsonKey(name: 'roll_no')  String? rollNo, @JsonKey(name: 'school_name')  String? schoolName,  String method,  String status, @JsonKey(name: 'check_in_at')  DateTime checkInAt,  num hours, @JsonKey(name: 'certified_at')  DateTime? certifiedAt)  $default,) {final _that = this;
switch (_that) {
case _RosterRow():
return $default(_that.attendanceId,_that.subjectKind,_that.displayName,_that.classSection,_that.rollNo,_that.schoolName,_that.method,_that.status,_that.checkInAt,_that.hours,_that.certifiedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'attendance_id')  String attendanceId, @JsonKey(name: 'subject_kind')  String subjectKind, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'class_section')  String? classSection, @JsonKey(name: 'roll_no')  String? rollNo, @JsonKey(name: 'school_name')  String? schoolName,  String method,  String status, @JsonKey(name: 'check_in_at')  DateTime checkInAt,  num hours, @JsonKey(name: 'certified_at')  DateTime? certifiedAt)?  $default,) {final _that = this;
switch (_that) {
case _RosterRow() when $default != null:
return $default(_that.attendanceId,_that.subjectKind,_that.displayName,_that.classSection,_that.rollNo,_that.schoolName,_that.method,_that.status,_that.checkInAt,_that.hours,_that.certifiedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RosterRow extends RosterRow {
  const _RosterRow({@JsonKey(name: 'attendance_id') required this.attendanceId, @JsonKey(name: 'subject_kind') required this.subjectKind, @JsonKey(name: 'display_name') required this.displayName, @JsonKey(name: 'class_section') this.classSection, @JsonKey(name: 'roll_no') this.rollNo, @JsonKey(name: 'school_name') this.schoolName, required this.method, required this.status, @JsonKey(name: 'check_in_at') required this.checkInAt, required this.hours, @JsonKey(name: 'certified_at') this.certifiedAt}): super._();
  factory _RosterRow.fromJson(Map<String, dynamic> json) => _$RosterRowFromJson(json);

@override@JsonKey(name: 'attendance_id') final  String attendanceId;
@override@JsonKey(name: 'subject_kind') final  String subjectKind;
@override@JsonKey(name: 'display_name') final  String displayName;
@override@JsonKey(name: 'class_section') final  String? classSection;
@override@JsonKey(name: 'roll_no') final  String? rollNo;
@override@JsonKey(name: 'school_name') final  String? schoolName;
@override final  String method;
@override final  String status;
@override@JsonKey(name: 'check_in_at') final  DateTime checkInAt;
@override final  num hours;
@override@JsonKey(name: 'certified_at') final  DateTime? certifiedAt;

/// Create a copy of RosterRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RosterRowCopyWith<_RosterRow> get copyWith => __$RosterRowCopyWithImpl<_RosterRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RosterRowToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RosterRow&&(identical(other.attendanceId, attendanceId) || other.attendanceId == attendanceId)&&(identical(other.subjectKind, subjectKind) || other.subjectKind == subjectKind)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.classSection, classSection) || other.classSection == classSection)&&(identical(other.rollNo, rollNo) || other.rollNo == rollNo)&&(identical(other.schoolName, schoolName) || other.schoolName == schoolName)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.certifiedAt, certifiedAt) || other.certifiedAt == certifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,attendanceId,subjectKind,displayName,classSection,rollNo,schoolName,method,status,checkInAt,hours,certifiedAt);
}

@override
String toString() {
    return 'RosterRow(attendanceId: $attendanceId, subjectKind: $subjectKind, displayName: $displayName, classSection: $classSection, rollNo: $rollNo, schoolName: $schoolName, method: $method, status: $status, checkInAt: $checkInAt, hours: $hours, certifiedAt: $certifiedAt)';
}


}

/// @nodoc
abstract mixin class _$RosterRowCopyWith<$Res> implements $RosterRowCopyWith<$Res> {
  factory _$RosterRowCopyWith(_RosterRow value, $Res Function(_RosterRow) _then) = __$RosterRowCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'attendance_id') String attendanceId,@JsonKey(name: 'subject_kind') String subjectKind,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'class_section') String? classSection,@JsonKey(name: 'roll_no') String? rollNo,@JsonKey(name: 'school_name') String? schoolName, String method, String status,@JsonKey(name: 'check_in_at') DateTime checkInAt, num hours,@JsonKey(name: 'certified_at') DateTime? certifiedAt
});




}
/// @nodoc
class __$RosterRowCopyWithImpl<$Res>
    implements _$RosterRowCopyWith<$Res> {
  __$RosterRowCopyWithImpl(this._self, this._then);

  final _RosterRow _self;
  final $Res Function(_RosterRow) _then;

/// Create a copy of RosterRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attendanceId = null,Object? subjectKind = null,Object? displayName = null,Object? classSection = freezed,Object? rollNo = freezed,Object? schoolName = freezed,Object? method = null,Object? status = null,Object? checkInAt = null,Object? hours = null,Object? certifiedAt = freezed,}) {
  return _then(_RosterRow(
attendanceId: null == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String,subjectKind: null == subjectKind ? _self.subjectKind : subjectKind // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,classSection: freezed == classSection ? _self.classSection : classSection // ignore: cast_nullable_to_non_nullable
as String?,rollNo: freezed == rollNo ? _self.rollNo : rollNo // ignore: cast_nullable_to_non_nullable
as String?,schoolName: freezed == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String?,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,checkInAt: null == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as num,certifiedAt: freezed == certifiedAt ? _self.certifiedAt : certifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$OrgDrive {

 String get id; String get title;@JsonKey(name: 'starts_at') DateTime get startsAt;@JsonKey(name: 'ends_at') DateTime get endsAt; String get status; String? get city; String? get venue; String? get cause;@JsonKey(name: 'default_hours') num get defaultHours; int get capacity; int get registrations;@JsonKey(name: 'checked_in') int get checkedIn; int get pending; int get certified;
/// Create a copy of OrgDrive
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrgDriveCopyWith<OrgDrive> get copyWith => _$OrgDriveCopyWithImpl<OrgDrive>(this as OrgDrive, _$identity);

  /// Serializes this OrgDrive to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrgDrive;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrgDrive&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.venue, _this.venue) || other.venue == _this.venue)&&(identical(other.cause, _this.cause) || other.cause == _this.cause)&&(identical(other.defaultHours, _this.defaultHours) || other.defaultHours == _this.defaultHours)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&(identical(other.registrations, _this.registrations) || other.registrations == _this.registrations)&&(identical(other.checkedIn, _this.checkedIn) || other.checkedIn == _this.checkedIn)&&(identical(other.pending, _this.pending) || other.pending == _this.pending)&&(identical(other.certified, _this.certified) || other.certified == _this.certified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrgDrive;
  return Object.hash(runtimeType,_this.id,_this.title,_this.startsAt,_this.endsAt,_this.status,_this.city,_this.venue,_this.cause,_this.defaultHours,_this.capacity,_this.registrations,_this.checkedIn,_this.pending,_this.certified);
}

@override
String toString() {
  final _this = this as OrgDrive;
  return 'OrgDrive(id: ${_this.id}, title: ${_this.title}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, status: ${_this.status}, city: ${_this.city}, venue: ${_this.venue}, cause: ${_this.cause}, defaultHours: ${_this.defaultHours}, capacity: ${_this.capacity}, registrations: ${_this.registrations}, checkedIn: ${_this.checkedIn}, pending: ${_this.pending}, certified: ${_this.certified})';
}


}

/// @nodoc
abstract mixin class $OrgDriveCopyWith<$Res>  {
  factory $OrgDriveCopyWith(OrgDrive value, $Res Function(OrgDrive) _then) = _$OrgDriveCopyWithImpl;
@useResult
$Res call({
 String id, String title,@JsonKey(name: 'starts_at') DateTime startsAt,@JsonKey(name: 'ends_at') DateTime endsAt, String status, String? city, String? venue, String? cause,@JsonKey(name: 'default_hours') num defaultHours, int capacity, int registrations,@JsonKey(name: 'checked_in') int checkedIn, int pending, int certified
});




}
/// @nodoc
class _$OrgDriveCopyWithImpl<$Res>
    implements $OrgDriveCopyWith<$Res> {
  _$OrgDriveCopyWithImpl(this._self, this._then);

  final OrgDrive _self;
  final $Res Function(OrgDrive) _then;

/// Create a copy of OrgDrive
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,Object? city = freezed,Object? venue = freezed,Object? cause = freezed,Object? defaultHours = null,Object? capacity = null,Object? registrations = null,Object? checkedIn = null,Object? pending = null,Object? certified = null,}) {
  return _then(OrgDrive(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,cause: freezed == cause ? _self.cause : cause // ignore: cast_nullable_to_non_nullable
as String?,defaultHours: null == defaultHours ? _self.defaultHours : defaultHours // ignore: cast_nullable_to_non_nullable
as num,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,registrations: null == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as int,checkedIn: null == checkedIn ? _self.checkedIn : checkedIn // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,certified: null == certified ? _self.certified : certified // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrgDrive].
extension OrgDrivePatterns on OrgDrive {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrgDrive value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrgDrive() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrgDrive value)  $default,){
final _that = this;
switch (_that) {
case _OrgDrive():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrgDrive value)?  $default,){
final _that = this;
switch (_that) {
case _OrgDrive() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt,  String status,  String? city,  String? venue,  String? cause, @JsonKey(name: 'default_hours')  num defaultHours,  int capacity,  int registrations, @JsonKey(name: 'checked_in')  int checkedIn,  int pending,  int certified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrgDrive() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.status,_that.city,_that.venue,_that.cause,_that.defaultHours,_that.capacity,_that.registrations,_that.checkedIn,_that.pending,_that.certified);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt,  String status,  String? city,  String? venue,  String? cause, @JsonKey(name: 'default_hours')  num defaultHours,  int capacity,  int registrations, @JsonKey(name: 'checked_in')  int checkedIn,  int pending,  int certified)  $default,) {final _that = this;
switch (_that) {
case _OrgDrive():
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.status,_that.city,_that.venue,_that.cause,_that.defaultHours,_that.capacity,_that.registrations,_that.checkedIn,_that.pending,_that.certified);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title, @JsonKey(name: 'starts_at')  DateTime startsAt, @JsonKey(name: 'ends_at')  DateTime endsAt,  String status,  String? city,  String? venue,  String? cause, @JsonKey(name: 'default_hours')  num defaultHours,  int capacity,  int registrations, @JsonKey(name: 'checked_in')  int checkedIn,  int pending,  int certified)?  $default,) {final _that = this;
switch (_that) {
case _OrgDrive() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.status,_that.city,_that.venue,_that.cause,_that.defaultHours,_that.capacity,_that.registrations,_that.checkedIn,_that.pending,_that.certified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrgDrive extends OrgDrive {
  const _OrgDrive({required this.id, required this.title, @JsonKey(name: 'starts_at') required this.startsAt, @JsonKey(name: 'ends_at') required this.endsAt, required this.status, this.city, this.venue, this.cause, @JsonKey(name: 'default_hours') required this.defaultHours, required this.capacity, this.registrations = 0, @JsonKey(name: 'checked_in') this.checkedIn = 0, this.pending = 0, this.certified = 0}): super._();
  factory _OrgDrive.fromJson(Map<String, dynamic> json) => _$OrgDriveFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey(name: 'starts_at') final  DateTime startsAt;
@override@JsonKey(name: 'ends_at') final  DateTime endsAt;
@override final  String status;
@override final  String? city;
@override final  String? venue;
@override final  String? cause;
@override@JsonKey(name: 'default_hours') final  num defaultHours;
@override final  int capacity;
@override@JsonKey() final  int registrations;
@override@JsonKey(name: 'checked_in') final  int checkedIn;
@override@JsonKey() final  int pending;
@override@JsonKey() final  int certified;

/// Create a copy of OrgDrive
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrgDriveCopyWith<_OrgDrive> get copyWith => __$OrgDriveCopyWithImpl<_OrgDrive>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrgDriveToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrgDrive&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.city, city) || other.city == city)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.cause, cause) || other.cause == cause)&&(identical(other.defaultHours, defaultHours) || other.defaultHours == defaultHours)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.registrations, registrations) || other.registrations == registrations)&&(identical(other.checkedIn, checkedIn) || other.checkedIn == checkedIn)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.certified, certified) || other.certified == certified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,startsAt,endsAt,status,city,venue,cause,defaultHours,capacity,registrations,checkedIn,pending,certified);
}

@override
String toString() {
    return 'OrgDrive(id: $id, title: $title, startsAt: $startsAt, endsAt: $endsAt, status: $status, city: $city, venue: $venue, cause: $cause, defaultHours: $defaultHours, capacity: $capacity, registrations: $registrations, checkedIn: $checkedIn, pending: $pending, certified: $certified)';
}


}

/// @nodoc
abstract mixin class _$OrgDriveCopyWith<$Res> implements $OrgDriveCopyWith<$Res> {
  factory _$OrgDriveCopyWith(_OrgDrive value, $Res Function(_OrgDrive) _then) = __$OrgDriveCopyWithImpl;
@override @useResult
$Res call({
 String id, String title,@JsonKey(name: 'starts_at') DateTime startsAt,@JsonKey(name: 'ends_at') DateTime endsAt, String status, String? city, String? venue, String? cause,@JsonKey(name: 'default_hours') num defaultHours, int capacity, int registrations,@JsonKey(name: 'checked_in') int checkedIn, int pending, int certified
});




}
/// @nodoc
class __$OrgDriveCopyWithImpl<$Res>
    implements _$OrgDriveCopyWith<$Res> {
  __$OrgDriveCopyWithImpl(this._self, this._then);

  final _OrgDrive _self;
  final $Res Function(_OrgDrive) _then;

/// Create a copy of OrgDrive
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,Object? city = freezed,Object? venue = freezed,Object? cause = freezed,Object? defaultHours = null,Object? capacity = null,Object? registrations = null,Object? checkedIn = null,Object? pending = null,Object? certified = null,}) {
  return _then(_OrgDrive(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,cause: freezed == cause ? _self.cause : cause // ignore: cast_nullable_to_non_nullable
as String?,defaultHours: null == defaultHours ? _self.defaultHours : defaultHours // ignore: cast_nullable_to_non_nullable
as num,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,registrations: null == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as int,checkedIn: null == checkedIn ? _self.checkedIn : checkedIn // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,certified: null == certified ? _self.certified : certified // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Student {

@JsonKey(name: 'student_id') String get studentId;@JsonKey(name: 'full_name') String get fullName; String get kind;@JsonKey(name: 'class_section') String? get classSection;@JsonKey(name: 'roll_no') String? get rollNo; String? get email; String? get phone;@JsonKey(name: 'claim_code') String get claimCode; bool get claimed;@JsonKey(name: 'certified_hours') num get certifiedHours;@JsonKey(name: 'pending_hours') num get pendingHours;
/// Create a copy of Student
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentCopyWith<Student> get copyWith => _$StudentCopyWithImpl<Student>(this as Student, _$identity);

  /// Serializes this Student to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Student;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Student&&(identical(other.studentId, _this.studentId) || other.studentId == _this.studentId)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.classSection, _this.classSection) || other.classSection == _this.classSection)&&(identical(other.rollNo, _this.rollNo) || other.rollNo == _this.rollNo)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.claimCode, _this.claimCode) || other.claimCode == _this.claimCode)&&(identical(other.claimed, _this.claimed) || other.claimed == _this.claimed)&&(identical(other.certifiedHours, _this.certifiedHours) || other.certifiedHours == _this.certifiedHours)&&(identical(other.pendingHours, _this.pendingHours) || other.pendingHours == _this.pendingHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Student;
  return Object.hash(runtimeType,_this.studentId,_this.fullName,_this.kind,_this.classSection,_this.rollNo,_this.email,_this.phone,_this.claimCode,_this.claimed,_this.certifiedHours,_this.pendingHours);
}

@override
String toString() {
  final _this = this as Student;
  return 'Student(studentId: ${_this.studentId}, fullName: ${_this.fullName}, kind: ${_this.kind}, classSection: ${_this.classSection}, rollNo: ${_this.rollNo}, email: ${_this.email}, phone: ${_this.phone}, claimCode: ${_this.claimCode}, claimed: ${_this.claimed}, certifiedHours: ${_this.certifiedHours}, pendingHours: ${_this.pendingHours})';
}


}

/// @nodoc
abstract mixin class $StudentCopyWith<$Res>  {
  factory $StudentCopyWith(Student value, $Res Function(Student) _then) = _$StudentCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'student_id') String studentId,@JsonKey(name: 'full_name') String fullName, String kind,@JsonKey(name: 'class_section') String? classSection,@JsonKey(name: 'roll_no') String? rollNo, String? email, String? phone,@JsonKey(name: 'claim_code') String claimCode, bool claimed,@JsonKey(name: 'certified_hours') num certifiedHours,@JsonKey(name: 'pending_hours') num pendingHours
});




}
/// @nodoc
class _$StudentCopyWithImpl<$Res>
    implements $StudentCopyWith<$Res> {
  _$StudentCopyWithImpl(this._self, this._then);

  final Student _self;
  final $Res Function(Student) _then;

/// Create a copy of Student
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentId = null,Object? fullName = null,Object? kind = null,Object? classSection = freezed,Object? rollNo = freezed,Object? email = freezed,Object? phone = freezed,Object? claimCode = null,Object? claimed = null,Object? certifiedHours = null,Object? pendingHours = null,}) {
  return _then(Student(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,classSection: freezed == classSection ? _self.classSection : classSection // ignore: cast_nullable_to_non_nullable
as String?,rollNo: freezed == rollNo ? _self.rollNo : rollNo // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,claimCode: null == claimCode ? _self.claimCode : claimCode // ignore: cast_nullable_to_non_nullable
as String,claimed: null == claimed ? _self.claimed : claimed // ignore: cast_nullable_to_non_nullable
as bool,certifiedHours: null == certifiedHours ? _self.certifiedHours : certifiedHours // ignore: cast_nullable_to_non_nullable
as num,pendingHours: null == pendingHours ? _self.pendingHours : pendingHours // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [Student].
extension StudentPatterns on Student {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Student value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Student() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Student value)  $default,){
final _that = this;
switch (_that) {
case _Student():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Student value)?  $default,){
final _that = this;
switch (_that) {
case _Student() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'student_id')  String studentId, @JsonKey(name: 'full_name')  String fullName,  String kind, @JsonKey(name: 'class_section')  String? classSection, @JsonKey(name: 'roll_no')  String? rollNo,  String? email,  String? phone, @JsonKey(name: 'claim_code')  String claimCode,  bool claimed, @JsonKey(name: 'certified_hours')  num certifiedHours, @JsonKey(name: 'pending_hours')  num pendingHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Student() when $default != null:
return $default(_that.studentId,_that.fullName,_that.kind,_that.classSection,_that.rollNo,_that.email,_that.phone,_that.claimCode,_that.claimed,_that.certifiedHours,_that.pendingHours);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'student_id')  String studentId, @JsonKey(name: 'full_name')  String fullName,  String kind, @JsonKey(name: 'class_section')  String? classSection, @JsonKey(name: 'roll_no')  String? rollNo,  String? email,  String? phone, @JsonKey(name: 'claim_code')  String claimCode,  bool claimed, @JsonKey(name: 'certified_hours')  num certifiedHours, @JsonKey(name: 'pending_hours')  num pendingHours)  $default,) {final _that = this;
switch (_that) {
case _Student():
return $default(_that.studentId,_that.fullName,_that.kind,_that.classSection,_that.rollNo,_that.email,_that.phone,_that.claimCode,_that.claimed,_that.certifiedHours,_that.pendingHours);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'student_id')  String studentId, @JsonKey(name: 'full_name')  String fullName,  String kind, @JsonKey(name: 'class_section')  String? classSection, @JsonKey(name: 'roll_no')  String? rollNo,  String? email,  String? phone, @JsonKey(name: 'claim_code')  String claimCode,  bool claimed, @JsonKey(name: 'certified_hours')  num certifiedHours, @JsonKey(name: 'pending_hours')  num pendingHours)?  $default,) {final _that = this;
switch (_that) {
case _Student() when $default != null:
return $default(_that.studentId,_that.fullName,_that.kind,_that.classSection,_that.rollNo,_that.email,_that.phone,_that.claimCode,_that.claimed,_that.certifiedHours,_that.pendingHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Student implements Student {
  const _Student({@JsonKey(name: 'student_id') required this.studentId, @JsonKey(name: 'full_name') required this.fullName, required this.kind, @JsonKey(name: 'class_section') this.classSection, @JsonKey(name: 'roll_no') this.rollNo, this.email, this.phone, @JsonKey(name: 'claim_code') required this.claimCode, this.claimed = false, @JsonKey(name: 'certified_hours') this.certifiedHours = 0, @JsonKey(name: 'pending_hours') this.pendingHours = 0});
  factory _Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

@override@JsonKey(name: 'student_id') final  String studentId;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String kind;
@override@JsonKey(name: 'class_section') final  String? classSection;
@override@JsonKey(name: 'roll_no') final  String? rollNo;
@override final  String? email;
@override final  String? phone;
@override@JsonKey(name: 'claim_code') final  String claimCode;
@override@JsonKey() final  bool claimed;
@override@JsonKey(name: 'certified_hours') final  num certifiedHours;
@override@JsonKey(name: 'pending_hours') final  num pendingHours;

/// Create a copy of Student
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentCopyWith<_Student> get copyWith => __$StudentCopyWithImpl<_Student>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Student&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.classSection, classSection) || other.classSection == classSection)&&(identical(other.rollNo, rollNo) || other.rollNo == rollNo)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.claimCode, claimCode) || other.claimCode == claimCode)&&(identical(other.claimed, claimed) || other.claimed == claimed)&&(identical(other.certifiedHours, certifiedHours) || other.certifiedHours == certifiedHours)&&(identical(other.pendingHours, pendingHours) || other.pendingHours == pendingHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,studentId,fullName,kind,classSection,rollNo,email,phone,claimCode,claimed,certifiedHours,pendingHours);
}

@override
String toString() {
    return 'Student(studentId: $studentId, fullName: $fullName, kind: $kind, classSection: $classSection, rollNo: $rollNo, email: $email, phone: $phone, claimCode: $claimCode, claimed: $claimed, certifiedHours: $certifiedHours, pendingHours: $pendingHours)';
}


}

/// @nodoc
abstract mixin class _$StudentCopyWith<$Res> implements $StudentCopyWith<$Res> {
  factory _$StudentCopyWith(_Student value, $Res Function(_Student) _then) = __$StudentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'student_id') String studentId,@JsonKey(name: 'full_name') String fullName, String kind,@JsonKey(name: 'class_section') String? classSection,@JsonKey(name: 'roll_no') String? rollNo, String? email, String? phone,@JsonKey(name: 'claim_code') String claimCode, bool claimed,@JsonKey(name: 'certified_hours') num certifiedHours,@JsonKey(name: 'pending_hours') num pendingHours
});




}
/// @nodoc
class __$StudentCopyWithImpl<$Res>
    implements _$StudentCopyWith<$Res> {
  __$StudentCopyWithImpl(this._self, this._then);

  final _Student _self;
  final $Res Function(_Student) _then;

/// Create a copy of Student
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentId = null,Object? fullName = null,Object? kind = null,Object? classSection = freezed,Object? rollNo = freezed,Object? email = freezed,Object? phone = freezed,Object? claimCode = null,Object? claimed = null,Object? certifiedHours = null,Object? pendingHours = null,}) {
  return _then(_Student(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,classSection: freezed == classSection ? _self.classSection : classSection // ignore: cast_nullable_to_non_nullable
as String?,rollNo: freezed == rollNo ? _self.rollNo : rollNo // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,claimCode: null == claimCode ? _self.claimCode : claimCode // ignore: cast_nullable_to_non_nullable
as String,claimed: null == claimed ? _self.claimed : claimed // ignore: cast_nullable_to_non_nullable
as bool,certifiedHours: null == certifiedHours ? _self.certifiedHours : certifiedHours // ignore: cast_nullable_to_non_nullable
as num,pendingHours: null == pendingHours ? _self.pendingHours : pendingHours // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$EnrolResult {

@JsonKey(name: 'student_id') String get studentId;@JsonKey(name: 'claim_code') String get claimCode; String get kind; bool get linked;
/// Create a copy of EnrolResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnrolResultCopyWith<EnrolResult> get copyWith => _$EnrolResultCopyWithImpl<EnrolResult>(this as EnrolResult, _$identity);

  /// Serializes this EnrolResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EnrolResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnrolResult&&(identical(other.studentId, _this.studentId) || other.studentId == _this.studentId)&&(identical(other.claimCode, _this.claimCode) || other.claimCode == _this.claimCode)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.linked, _this.linked) || other.linked == _this.linked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EnrolResult;
  return Object.hash(runtimeType,_this.studentId,_this.claimCode,_this.kind,_this.linked);
}

@override
String toString() {
  final _this = this as EnrolResult;
  return 'EnrolResult(studentId: ${_this.studentId}, claimCode: ${_this.claimCode}, kind: ${_this.kind}, linked: ${_this.linked})';
}


}

/// @nodoc
abstract mixin class $EnrolResultCopyWith<$Res>  {
  factory $EnrolResultCopyWith(EnrolResult value, $Res Function(EnrolResult) _then) = _$EnrolResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'student_id') String studentId,@JsonKey(name: 'claim_code') String claimCode, String kind, bool linked
});




}
/// @nodoc
class _$EnrolResultCopyWithImpl<$Res>
    implements $EnrolResultCopyWith<$Res> {
  _$EnrolResultCopyWithImpl(this._self, this._then);

  final EnrolResult _self;
  final $Res Function(EnrolResult) _then;

/// Create a copy of EnrolResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentId = null,Object? claimCode = null,Object? kind = null,Object? linked = null,}) {
  return _then(EnrolResult(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,claimCode: null == claimCode ? _self.claimCode : claimCode // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,linked: null == linked ? _self.linked : linked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EnrolResult].
extension EnrolResultPatterns on EnrolResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnrolResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnrolResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnrolResult value)  $default,){
final _that = this;
switch (_that) {
case _EnrolResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnrolResult value)?  $default,){
final _that = this;
switch (_that) {
case _EnrolResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'student_id')  String studentId, @JsonKey(name: 'claim_code')  String claimCode,  String kind,  bool linked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnrolResult() when $default != null:
return $default(_that.studentId,_that.claimCode,_that.kind,_that.linked);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'student_id')  String studentId, @JsonKey(name: 'claim_code')  String claimCode,  String kind,  bool linked)  $default,) {final _that = this;
switch (_that) {
case _EnrolResult():
return $default(_that.studentId,_that.claimCode,_that.kind,_that.linked);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'student_id')  String studentId, @JsonKey(name: 'claim_code')  String claimCode,  String kind,  bool linked)?  $default,) {final _that = this;
switch (_that) {
case _EnrolResult() when $default != null:
return $default(_that.studentId,_that.claimCode,_that.kind,_that.linked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EnrolResult implements EnrolResult {
  const _EnrolResult({@JsonKey(name: 'student_id') required this.studentId, @JsonKey(name: 'claim_code') required this.claimCode, required this.kind, this.linked = false});
  factory _EnrolResult.fromJson(Map<String, dynamic> json) => _$EnrolResultFromJson(json);

@override@JsonKey(name: 'student_id') final  String studentId;
@override@JsonKey(name: 'claim_code') final  String claimCode;
@override final  String kind;
@override@JsonKey() final  bool linked;

/// Create a copy of EnrolResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnrolResultCopyWith<_EnrolResult> get copyWith => __$EnrolResultCopyWithImpl<_EnrolResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EnrolResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnrolResult&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.claimCode, claimCode) || other.claimCode == claimCode)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.linked, linked) || other.linked == linked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,studentId,claimCode,kind,linked);
}

@override
String toString() {
    return 'EnrolResult(studentId: $studentId, claimCode: $claimCode, kind: $kind, linked: $linked)';
}


}

/// @nodoc
abstract mixin class _$EnrolResultCopyWith<$Res> implements $EnrolResultCopyWith<$Res> {
  factory _$EnrolResultCopyWith(_EnrolResult value, $Res Function(_EnrolResult) _then) = __$EnrolResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'student_id') String studentId,@JsonKey(name: 'claim_code') String claimCode, String kind, bool linked
});




}
/// @nodoc
class __$EnrolResultCopyWithImpl<$Res>
    implements _$EnrolResultCopyWith<$Res> {
  __$EnrolResultCopyWithImpl(this._self, this._then);

  final _EnrolResult _self;
  final $Res Function(_EnrolResult) _then;

/// Create a copy of EnrolResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentId = null,Object? claimCode = null,Object? kind = null,Object? linked = null,}) {
  return _then(_EnrolResult(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,claimCode: null == claimCode ? _self.claimCode : claimCode // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,linked: null == linked ? _self.linked : linked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$OrgPublic {

 String get id; String get name; String get type; String? get city; String? get about;@JsonKey(name: 'verification_tier') int get verificationTier;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'drives_run') int get drivesRun;@JsonKey(name: 'certified_hours') num get certifiedHours; List<UpcomingDrive> get upcoming;
/// Create a copy of OrgPublic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrgPublicCopyWith<OrgPublic> get copyWith => _$OrgPublicCopyWithImpl<OrgPublic>(this as OrgPublic, _$identity);

  /// Serializes this OrgPublic to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrgPublic;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrgPublic&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.about, _this.about) || other.about == _this.about)&&(identical(other.verificationTier, _this.verificationTier) || other.verificationTier == _this.verificationTier)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.drivesRun, _this.drivesRun) || other.drivesRun == _this.drivesRun)&&(identical(other.certifiedHours, _this.certifiedHours) || other.certifiedHours == _this.certifiedHours)&&const DeepCollectionEquality().equals(other.upcoming, _this.upcoming));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrgPublic;
  return Object.hash(runtimeType,_this.id,_this.name,_this.type,_this.city,_this.about,_this.verificationTier,_this.createdAt,_this.drivesRun,_this.certifiedHours,const DeepCollectionEquality().hash(_this.upcoming));
}

@override
String toString() {
  final _this = this as OrgPublic;
  return 'OrgPublic(id: ${_this.id}, name: ${_this.name}, type: ${_this.type}, city: ${_this.city}, about: ${_this.about}, verificationTier: ${_this.verificationTier}, createdAt: ${_this.createdAt}, drivesRun: ${_this.drivesRun}, certifiedHours: ${_this.certifiedHours}, upcoming: ${_this.upcoming})';
}


}

/// @nodoc
abstract mixin class $OrgPublicCopyWith<$Res>  {
  factory $OrgPublicCopyWith(OrgPublic value, $Res Function(OrgPublic) _then) = _$OrgPublicCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, String? city, String? about,@JsonKey(name: 'verification_tier') int verificationTier,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'drives_run') int drivesRun,@JsonKey(name: 'certified_hours') num certifiedHours, List<UpcomingDrive> upcoming
});




}
/// @nodoc
class _$OrgPublicCopyWithImpl<$Res>
    implements $OrgPublicCopyWith<$Res> {
  _$OrgPublicCopyWithImpl(this._self, this._then);

  final OrgPublic _self;
  final $Res Function(OrgPublic) _then;

/// Create a copy of OrgPublic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? city = freezed,Object? about = freezed,Object? verificationTier = null,Object? createdAt = null,Object? drivesRun = null,Object? certifiedHours = null,Object? upcoming = null,}) {
  return _then(OrgPublic(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,about: freezed == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String?,verificationTier: null == verificationTier ? _self.verificationTier : verificationTier // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,drivesRun: null == drivesRun ? _self.drivesRun : drivesRun // ignore: cast_nullable_to_non_nullable
as int,certifiedHours: null == certifiedHours ? _self.certifiedHours : certifiedHours // ignore: cast_nullable_to_non_nullable
as num,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<UpcomingDrive>,
  ));
}

}


/// Adds pattern-matching-related methods to [OrgPublic].
extension OrgPublicPatterns on OrgPublic {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrgPublic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrgPublic() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrgPublic value)  $default,){
final _that = this;
switch (_that) {
case _OrgPublic():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrgPublic value)?  $default,){
final _that = this;
switch (_that) {
case _OrgPublic() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String? city,  String? about, @JsonKey(name: 'verification_tier')  int verificationTier, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'drives_run')  int drivesRun, @JsonKey(name: 'certified_hours')  num certifiedHours,  List<UpcomingDrive> upcoming)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrgPublic() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.city,_that.about,_that.verificationTier,_that.createdAt,_that.drivesRun,_that.certifiedHours,_that.upcoming);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String? city,  String? about, @JsonKey(name: 'verification_tier')  int verificationTier, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'drives_run')  int drivesRun, @JsonKey(name: 'certified_hours')  num certifiedHours,  List<UpcomingDrive> upcoming)  $default,) {final _that = this;
switch (_that) {
case _OrgPublic():
return $default(_that.id,_that.name,_that.type,_that.city,_that.about,_that.verificationTier,_that.createdAt,_that.drivesRun,_that.certifiedHours,_that.upcoming);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  String? city,  String? about, @JsonKey(name: 'verification_tier')  int verificationTier, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'drives_run')  int drivesRun, @JsonKey(name: 'certified_hours')  num certifiedHours,  List<UpcomingDrive> upcoming)?  $default,) {final _that = this;
switch (_that) {
case _OrgPublic() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.city,_that.about,_that.verificationTier,_that.createdAt,_that.drivesRun,_that.certifiedHours,_that.upcoming);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrgPublic extends OrgPublic {
  const _OrgPublic({required this.id, required this.name, required this.type, this.city, this.about, @JsonKey(name: 'verification_tier') this.verificationTier = 0, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'drives_run') this.drivesRun = 0, @JsonKey(name: 'certified_hours') this.certifiedHours = 0,  List<UpcomingDrive> upcoming = const []}): _upcoming = upcoming,super._();
  factory _OrgPublic.fromJson(Map<String, dynamic> json) => _$OrgPublicFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
@override final  String? city;
@override final  String? about;
@override@JsonKey(name: 'verification_tier') final  int verificationTier;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'drives_run') final  int drivesRun;
@override@JsonKey(name: 'certified_hours') final  num certifiedHours;
 final  List<UpcomingDrive> _upcoming;
@override@JsonKey() List<UpcomingDrive> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}


/// Create a copy of OrgPublic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrgPublicCopyWith<_OrgPublic> get copyWith => __$OrgPublicCopyWithImpl<_OrgPublic>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrgPublicToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrgPublic&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.city, city) || other.city == city)&&(identical(other.about, about) || other.about == about)&&(identical(other.verificationTier, verificationTier) || other.verificationTier == verificationTier)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.drivesRun, drivesRun) || other.drivesRun == drivesRun)&&(identical(other.certifiedHours, certifiedHours) || other.certifiedHours == certifiedHours)&&const DeepCollectionEquality().equals(other.upcoming, _upcoming));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,type,city,about,verificationTier,createdAt,drivesRun,certifiedHours,const DeepCollectionEquality().hash(_upcoming));
}

@override
String toString() {
    return 'OrgPublic(id: $id, name: $name, type: $type, city: $city, about: $about, verificationTier: $verificationTier, createdAt: $createdAt, drivesRun: $drivesRun, certifiedHours: $certifiedHours, upcoming: $upcoming)';
}


}

/// @nodoc
abstract mixin class _$OrgPublicCopyWith<$Res> implements $OrgPublicCopyWith<$Res> {
  factory _$OrgPublicCopyWith(_OrgPublic value, $Res Function(_OrgPublic) _then) = __$OrgPublicCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, String? city, String? about,@JsonKey(name: 'verification_tier') int verificationTier,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'drives_run') int drivesRun,@JsonKey(name: 'certified_hours') num certifiedHours, List<UpcomingDrive> upcoming
});




}
/// @nodoc
class __$OrgPublicCopyWithImpl<$Res>
    implements _$OrgPublicCopyWith<$Res> {
  __$OrgPublicCopyWithImpl(this._self, this._then);

  final _OrgPublic _self;
  final $Res Function(_OrgPublic) _then;

/// Create a copy of OrgPublic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? city = freezed,Object? about = freezed,Object? verificationTier = null,Object? createdAt = null,Object? drivesRun = null,Object? certifiedHours = null,Object? upcoming = null,}) {
  return _then(_OrgPublic(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,about: freezed == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String?,verificationTier: null == verificationTier ? _self.verificationTier : verificationTier // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,drivesRun: null == drivesRun ? _self.drivesRun : drivesRun // ignore: cast_nullable_to_non_nullable
as int,certifiedHours: null == certifiedHours ? _self.certifiedHours : certifiedHours // ignore: cast_nullable_to_non_nullable
as num,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<UpcomingDrive>,
  ));
}


}


/// @nodoc
mixin _$OrgMember {

@JsonKey(name: 'user_id') String get userId; String? get name; String? get email; String get role;@JsonKey(name: 'joined_at') DateTime get joinedAt;
/// Create a copy of OrgMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrgMemberCopyWith<OrgMember> get copyWith => _$OrgMemberCopyWithImpl<OrgMember>(this as OrgMember, _$identity);

  /// Serializes this OrgMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrgMember;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrgMember&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.joinedAt, _this.joinedAt) || other.joinedAt == _this.joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrgMember;
  return Object.hash(runtimeType,_this.userId,_this.name,_this.email,_this.role,_this.joinedAt);
}

@override
String toString() {
  final _this = this as OrgMember;
  return 'OrgMember(userId: ${_this.userId}, name: ${_this.name}, email: ${_this.email}, role: ${_this.role}, joinedAt: ${_this.joinedAt})';
}


}

/// @nodoc
abstract mixin class $OrgMemberCopyWith<$Res>  {
  factory $OrgMemberCopyWith(OrgMember value, $Res Function(OrgMember) _then) = _$OrgMemberCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId, String? name, String? email, String role,@JsonKey(name: 'joined_at') DateTime joinedAt
});




}
/// @nodoc
class _$OrgMemberCopyWithImpl<$Res>
    implements $OrgMemberCopyWith<$Res> {
  _$OrgMemberCopyWithImpl(this._self, this._then);

  final OrgMember _self;
  final $Res Function(OrgMember) _then;

/// Create a copy of OrgMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? name = freezed,Object? email = freezed,Object? role = null,Object? joinedAt = null,}) {
  return _then(OrgMember(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [OrgMember].
extension OrgMemberPatterns on OrgMember {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrgMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrgMember() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrgMember value)  $default,){
final _that = this;
switch (_that) {
case _OrgMember():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrgMember value)?  $default,){
final _that = this;
switch (_that) {
case _OrgMember() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId,  String? name,  String? email,  String role, @JsonKey(name: 'joined_at')  DateTime joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrgMember() when $default != null:
return $default(_that.userId,_that.name,_that.email,_that.role,_that.joinedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId,  String? name,  String? email,  String role, @JsonKey(name: 'joined_at')  DateTime joinedAt)  $default,) {final _that = this;
switch (_that) {
case _OrgMember():
return $default(_that.userId,_that.name,_that.email,_that.role,_that.joinedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId,  String? name,  String? email,  String role, @JsonKey(name: 'joined_at')  DateTime joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _OrgMember() when $default != null:
return $default(_that.userId,_that.name,_that.email,_that.role,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrgMember implements OrgMember {
  const _OrgMember({@JsonKey(name: 'user_id') required this.userId, this.name, this.email, required this.role, @JsonKey(name: 'joined_at') required this.joinedAt});
  factory _OrgMember.fromJson(Map<String, dynamic> json) => _$OrgMemberFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override final  String? name;
@override final  String? email;
@override final  String role;
@override@JsonKey(name: 'joined_at') final  DateTime joinedAt;

/// Create a copy of OrgMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrgMemberCopyWith<_OrgMember> get copyWith => __$OrgMemberCopyWithImpl<_OrgMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrgMemberToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrgMember&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,name,email,role,joinedAt);
}

@override
String toString() {
    return 'OrgMember(userId: $userId, name: $name, email: $email, role: $role, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$OrgMemberCopyWith<$Res> implements $OrgMemberCopyWith<$Res> {
  factory _$OrgMemberCopyWith(_OrgMember value, $Res Function(_OrgMember) _then) = __$OrgMemberCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId, String? name, String? email, String role,@JsonKey(name: 'joined_at') DateTime joinedAt
});




}
/// @nodoc
class __$OrgMemberCopyWithImpl<$Res>
    implements _$OrgMemberCopyWith<$Res> {
  __$OrgMemberCopyWithImpl(this._self, this._then);

  final _OrgMember _self;
  final $Res Function(_OrgMember) _then;

/// Create a copy of OrgMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = freezed,Object? email = freezed,Object? role = null,Object? joinedAt = null,}) {
  return _then(_OrgMember(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$OrgInvite {

 String get email; String get role;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of OrgInvite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrgInviteCopyWith<OrgInvite> get copyWith => _$OrgInviteCopyWithImpl<OrgInvite>(this as OrgInvite, _$identity);

  /// Serializes this OrgInvite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrgInvite;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrgInvite&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrgInvite;
  return Object.hash(runtimeType,_this.email,_this.role,_this.createdAt);
}

@override
String toString() {
  final _this = this as OrgInvite;
  return 'OrgInvite(email: ${_this.email}, role: ${_this.role}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $OrgInviteCopyWith<$Res>  {
  factory $OrgInviteCopyWith(OrgInvite value, $Res Function(OrgInvite) _then) = _$OrgInviteCopyWithImpl;
@useResult
$Res call({
 String email, String role,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$OrgInviteCopyWithImpl<$Res>
    implements $OrgInviteCopyWith<$Res> {
  _$OrgInviteCopyWithImpl(this._self, this._then);

  final OrgInvite _self;
  final $Res Function(OrgInvite) _then;

/// Create a copy of OrgInvite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? role = null,Object? createdAt = null,}) {
  return _then(OrgInvite(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [OrgInvite].
extension OrgInvitePatterns on OrgInvite {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrgInvite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrgInvite() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrgInvite value)  $default,){
final _that = this;
switch (_that) {
case _OrgInvite():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrgInvite value)?  $default,){
final _that = this;
switch (_that) {
case _OrgInvite() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String role, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrgInvite() when $default != null:
return $default(_that.email,_that.role,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String role, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _OrgInvite():
return $default(_that.email,_that.role,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String role, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _OrgInvite() when $default != null:
return $default(_that.email,_that.role,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrgInvite implements OrgInvite {
  const _OrgInvite({required this.email, required this.role, @JsonKey(name: 'created_at') required this.createdAt});
  factory _OrgInvite.fromJson(Map<String, dynamic> json) => _$OrgInviteFromJson(json);

@override final  String email;
@override final  String role;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of OrgInvite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrgInviteCopyWith<_OrgInvite> get copyWith => __$OrgInviteCopyWithImpl<_OrgInvite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrgInviteToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrgInvite&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,email,role,createdAt);
}

@override
String toString() {
    return 'OrgInvite(email: $email, role: $role, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$OrgInviteCopyWith<$Res> implements $OrgInviteCopyWith<$Res> {
  factory _$OrgInviteCopyWith(_OrgInvite value, $Res Function(_OrgInvite) _then) = __$OrgInviteCopyWithImpl;
@override @useResult
$Res call({
 String email, String role,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$OrgInviteCopyWithImpl<$Res>
    implements _$OrgInviteCopyWith<$Res> {
  __$OrgInviteCopyWithImpl(this._self, this._then);

  final _OrgInvite _self;
  final $Res Function(_OrgInvite) _then;

/// Create a copy of OrgInvite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? role = null,Object? createdAt = null,}) {
  return _then(_OrgInvite(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$MySignature {

@JsonKey(name: 'signature_no') int get signatureNo;@JsonKey(name: 'signed_at') DateTime get signedAt;@JsonKey(name: 'certificate_code') String? get certificateCode;
/// Create a copy of MySignature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MySignatureCopyWith<MySignature> get copyWith => _$MySignatureCopyWithImpl<MySignature>(this as MySignature, _$identity);

  /// Serializes this MySignature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MySignature;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MySignature&&(identical(other.signatureNo, _this.signatureNo) || other.signatureNo == _this.signatureNo)&&(identical(other.signedAt, _this.signedAt) || other.signedAt == _this.signedAt)&&(identical(other.certificateCode, _this.certificateCode) || other.certificateCode == _this.certificateCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MySignature;
  return Object.hash(runtimeType,_this.signatureNo,_this.signedAt,_this.certificateCode);
}

@override
String toString() {
  final _this = this as MySignature;
  return 'MySignature(signatureNo: ${_this.signatureNo}, signedAt: ${_this.signedAt}, certificateCode: ${_this.certificateCode})';
}


}

/// @nodoc
abstract mixin class $MySignatureCopyWith<$Res>  {
  factory $MySignatureCopyWith(MySignature value, $Res Function(MySignature) _then) = _$MySignatureCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'signature_no') int signatureNo,@JsonKey(name: 'signed_at') DateTime signedAt,@JsonKey(name: 'certificate_code') String? certificateCode
});




}
/// @nodoc
class _$MySignatureCopyWithImpl<$Res>
    implements $MySignatureCopyWith<$Res> {
  _$MySignatureCopyWithImpl(this._self, this._then);

  final MySignature _self;
  final $Res Function(MySignature) _then;

/// Create a copy of MySignature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signatureNo = null,Object? signedAt = null,Object? certificateCode = freezed,}) {
  return _then(MySignature(
signatureNo: null == signatureNo ? _self.signatureNo : signatureNo // ignore: cast_nullable_to_non_nullable
as int,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,certificateCode: freezed == certificateCode ? _self.certificateCode : certificateCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MySignature].
extension MySignaturePatterns on MySignature {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MySignature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MySignature() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MySignature value)  $default,){
final _that = this;
switch (_that) {
case _MySignature():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MySignature value)?  $default,){
final _that = this;
switch (_that) {
case _MySignature() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt, @JsonKey(name: 'certificate_code')  String? certificateCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MySignature() when $default != null:
return $default(_that.signatureNo,_that.signedAt,_that.certificateCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt, @JsonKey(name: 'certificate_code')  String? certificateCode)  $default,) {final _that = this;
switch (_that) {
case _MySignature():
return $default(_that.signatureNo,_that.signedAt,_that.certificateCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt, @JsonKey(name: 'certificate_code')  String? certificateCode)?  $default,) {final _that = this;
switch (_that) {
case _MySignature() when $default != null:
return $default(_that.signatureNo,_that.signedAt,_that.certificateCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MySignature implements MySignature {
  const _MySignature({@JsonKey(name: 'signature_no') required this.signatureNo, @JsonKey(name: 'signed_at') required this.signedAt, @JsonKey(name: 'certificate_code') this.certificateCode});
  factory _MySignature.fromJson(Map<String, dynamic> json) => _$MySignatureFromJson(json);

@override@JsonKey(name: 'signature_no') final  int signatureNo;
@override@JsonKey(name: 'signed_at') final  DateTime signedAt;
@override@JsonKey(name: 'certificate_code') final  String? certificateCode;

/// Create a copy of MySignature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MySignatureCopyWith<_MySignature> get copyWith => __$MySignatureCopyWithImpl<_MySignature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MySignatureToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MySignature&&(identical(other.signatureNo, signatureNo) || other.signatureNo == signatureNo)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt)&&(identical(other.certificateCode, certificateCode) || other.certificateCode == certificateCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,signatureNo,signedAt,certificateCode);
}

@override
String toString() {
    return 'MySignature(signatureNo: $signatureNo, signedAt: $signedAt, certificateCode: $certificateCode)';
}


}

/// @nodoc
abstract mixin class _$MySignatureCopyWith<$Res> implements $MySignatureCopyWith<$Res> {
  factory _$MySignatureCopyWith(_MySignature value, $Res Function(_MySignature) _then) = __$MySignatureCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'signature_no') int signatureNo,@JsonKey(name: 'signed_at') DateTime signedAt,@JsonKey(name: 'certificate_code') String? certificateCode
});




}
/// @nodoc
class __$MySignatureCopyWithImpl<$Res>
    implements _$MySignatureCopyWith<$Res> {
  __$MySignatureCopyWithImpl(this._self, this._then);

  final _MySignature _self;
  final $Res Function(_MySignature) _then;

/// Create a copy of MySignature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signatureNo = null,Object? signedAt = null,Object? certificateCode = freezed,}) {
  return _then(_MySignature(
signatureNo: null == signatureNo ? _self.signatureNo : signatureNo // ignore: cast_nullable_to_non_nullable
as int,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,certificateCode: freezed == certificateCode ? _self.certificateCode : certificateCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PledgeDetail {

 String get id;@JsonKey(name: 'org_id') String get orgId;@JsonKey(name: 'org_name') String get orgName;@JsonKey(name: 'org_verified') bool get orgVerified; String get title; String? get campaign; String get body; String get status;@JsonKey(name: 'share_code') String get shareCode;@JsonKey(name: 'created_at') DateTime get createdAt; int get signatures;@JsonKey(name: 'can_manage') bool get canManage;@JsonKey(name: 'my_signature') MySignature? get mySignature;
/// Create a copy of PledgeDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PledgeDetailCopyWith<PledgeDetail> get copyWith => _$PledgeDetailCopyWithImpl<PledgeDetail>(this as PledgeDetail, _$identity);

  /// Serializes this PledgeDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PledgeDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PledgeDetail&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.orgId, _this.orgId) || other.orgId == _this.orgId)&&(identical(other.orgName, _this.orgName) || other.orgName == _this.orgName)&&(identical(other.orgVerified, _this.orgVerified) || other.orgVerified == _this.orgVerified)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.campaign, _this.campaign) || other.campaign == _this.campaign)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.shareCode, _this.shareCode) || other.shareCode == _this.shareCode)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.signatures, _this.signatures) || other.signatures == _this.signatures)&&(identical(other.canManage, _this.canManage) || other.canManage == _this.canManage)&&(identical(other.mySignature, _this.mySignature) || other.mySignature == _this.mySignature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PledgeDetail;
  return Object.hash(runtimeType,_this.id,_this.orgId,_this.orgName,_this.orgVerified,_this.title,_this.campaign,_this.body,_this.status,_this.shareCode,_this.createdAt,_this.signatures,_this.canManage,_this.mySignature);
}

@override
String toString() {
  final _this = this as PledgeDetail;
  return 'PledgeDetail(id: ${_this.id}, orgId: ${_this.orgId}, orgName: ${_this.orgName}, orgVerified: ${_this.orgVerified}, title: ${_this.title}, campaign: ${_this.campaign}, body: ${_this.body}, status: ${_this.status}, shareCode: ${_this.shareCode}, createdAt: ${_this.createdAt}, signatures: ${_this.signatures}, canManage: ${_this.canManage}, mySignature: ${_this.mySignature})';
}


}

/// @nodoc
abstract mixin class $PledgeDetailCopyWith<$Res>  {
  factory $PledgeDetailCopyWith(PledgeDetail value, $Res Function(PledgeDetail) _then) = _$PledgeDetailCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'org_id') String orgId,@JsonKey(name: 'org_name') String orgName,@JsonKey(name: 'org_verified') bool orgVerified, String title, String? campaign, String body, String status,@JsonKey(name: 'share_code') String shareCode,@JsonKey(name: 'created_at') DateTime createdAt, int signatures,@JsonKey(name: 'can_manage') bool canManage,@JsonKey(name: 'my_signature') MySignature? mySignature
});


$MySignatureCopyWith<$Res>? get mySignature;

}
/// @nodoc
class _$PledgeDetailCopyWithImpl<$Res>
    implements $PledgeDetailCopyWith<$Res> {
  _$PledgeDetailCopyWithImpl(this._self, this._then);

  final PledgeDetail _self;
  final $Res Function(PledgeDetail) _then;

/// Create a copy of PledgeDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orgId = null,Object? orgName = null,Object? orgVerified = null,Object? title = null,Object? campaign = freezed,Object? body = null,Object? status = null,Object? shareCode = null,Object? createdAt = null,Object? signatures = null,Object? canManage = null,Object? mySignature = freezed,}) {
  return _then(PledgeDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,orgVerified: null == orgVerified ? _self.orgVerified : orgVerified // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,shareCode: null == shareCode ? _self.shareCode : shareCode // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as int,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,mySignature: freezed == mySignature ? _self.mySignature : mySignature // ignore: cast_nullable_to_non_nullable
as MySignature?,
  ));
}
/// Create a copy of PledgeDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MySignatureCopyWith<$Res>? get mySignature {
    if (_self.mySignature == null) {
    return null;
  }

  return $MySignatureCopyWith<$Res>(_self.mySignature!, (value) {
    return _then(_self.copyWith(mySignature: value));
  });
}
}


/// Adds pattern-matching-related methods to [PledgeDetail].
extension PledgeDetailPatterns on PledgeDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PledgeDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PledgeDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PledgeDetail value)  $default,){
final _that = this;
switch (_that) {
case _PledgeDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PledgeDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PledgeDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'org_verified')  bool orgVerified,  String title,  String? campaign,  String body,  String status, @JsonKey(name: 'share_code')  String shareCode, @JsonKey(name: 'created_at')  DateTime createdAt,  int signatures, @JsonKey(name: 'can_manage')  bool canManage, @JsonKey(name: 'my_signature')  MySignature? mySignature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PledgeDetail() when $default != null:
return $default(_that.id,_that.orgId,_that.orgName,_that.orgVerified,_that.title,_that.campaign,_that.body,_that.status,_that.shareCode,_that.createdAt,_that.signatures,_that.canManage,_that.mySignature);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'org_verified')  bool orgVerified,  String title,  String? campaign,  String body,  String status, @JsonKey(name: 'share_code')  String shareCode, @JsonKey(name: 'created_at')  DateTime createdAt,  int signatures, @JsonKey(name: 'can_manage')  bool canManage, @JsonKey(name: 'my_signature')  MySignature? mySignature)  $default,) {final _that = this;
switch (_that) {
case _PledgeDetail():
return $default(_that.id,_that.orgId,_that.orgName,_that.orgVerified,_that.title,_that.campaign,_that.body,_that.status,_that.shareCode,_that.createdAt,_that.signatures,_that.canManage,_that.mySignature);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'org_id')  String orgId, @JsonKey(name: 'org_name')  String orgName, @JsonKey(name: 'org_verified')  bool orgVerified,  String title,  String? campaign,  String body,  String status, @JsonKey(name: 'share_code')  String shareCode, @JsonKey(name: 'created_at')  DateTime createdAt,  int signatures, @JsonKey(name: 'can_manage')  bool canManage, @JsonKey(name: 'my_signature')  MySignature? mySignature)?  $default,) {final _that = this;
switch (_that) {
case _PledgeDetail() when $default != null:
return $default(_that.id,_that.orgId,_that.orgName,_that.orgVerified,_that.title,_that.campaign,_that.body,_that.status,_that.shareCode,_that.createdAt,_that.signatures,_that.canManage,_that.mySignature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PledgeDetail extends PledgeDetail {
  const _PledgeDetail({required this.id, @JsonKey(name: 'org_id') required this.orgId, @JsonKey(name: 'org_name') required this.orgName, @JsonKey(name: 'org_verified') this.orgVerified = false, required this.title, this.campaign, required this.body, required this.status, @JsonKey(name: 'share_code') required this.shareCode, @JsonKey(name: 'created_at') required this.createdAt, this.signatures = 0, @JsonKey(name: 'can_manage') this.canManage = false, @JsonKey(name: 'my_signature') this.mySignature}): super._();
  factory _PledgeDetail.fromJson(Map<String, dynamic> json) => _$PledgeDetailFromJson(json);

@override final  String id;
@override@JsonKey(name: 'org_id') final  String orgId;
@override@JsonKey(name: 'org_name') final  String orgName;
@override@JsonKey(name: 'org_verified') final  bool orgVerified;
@override final  String title;
@override final  String? campaign;
@override final  String body;
@override final  String status;
@override@JsonKey(name: 'share_code') final  String shareCode;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey() final  int signatures;
@override@JsonKey(name: 'can_manage') final  bool canManage;
@override@JsonKey(name: 'my_signature') final  MySignature? mySignature;

/// Create a copy of PledgeDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PledgeDetailCopyWith<_PledgeDetail> get copyWith => __$PledgeDetailCopyWithImpl<_PledgeDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PledgeDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PledgeDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.orgName, orgName) || other.orgName == orgName)&&(identical(other.orgVerified, orgVerified) || other.orgVerified == orgVerified)&&(identical(other.title, title) || other.title == title)&&(identical(other.campaign, campaign) || other.campaign == campaign)&&(identical(other.body, body) || other.body == body)&&(identical(other.status, status) || other.status == status)&&(identical(other.shareCode, shareCode) || other.shareCode == shareCode)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.signatures, signatures) || other.signatures == signatures)&&(identical(other.canManage, canManage) || other.canManage == canManage)&&(identical(other.mySignature, mySignature) || other.mySignature == mySignature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,orgId,orgName,orgVerified,title,campaign,body,status,shareCode,createdAt,signatures,canManage,mySignature);
}

@override
String toString() {
    return 'PledgeDetail(id: $id, orgId: $orgId, orgName: $orgName, orgVerified: $orgVerified, title: $title, campaign: $campaign, body: $body, status: $status, shareCode: $shareCode, createdAt: $createdAt, signatures: $signatures, canManage: $canManage, mySignature: $mySignature)';
}


}

/// @nodoc
abstract mixin class _$PledgeDetailCopyWith<$Res> implements $PledgeDetailCopyWith<$Res> {
  factory _$PledgeDetailCopyWith(_PledgeDetail value, $Res Function(_PledgeDetail) _then) = __$PledgeDetailCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'org_id') String orgId,@JsonKey(name: 'org_name') String orgName,@JsonKey(name: 'org_verified') bool orgVerified, String title, String? campaign, String body, String status,@JsonKey(name: 'share_code') String shareCode,@JsonKey(name: 'created_at') DateTime createdAt, int signatures,@JsonKey(name: 'can_manage') bool canManage,@JsonKey(name: 'my_signature') MySignature? mySignature
});


@override $MySignatureCopyWith<$Res>? get mySignature;

}
/// @nodoc
class __$PledgeDetailCopyWithImpl<$Res>
    implements _$PledgeDetailCopyWith<$Res> {
  __$PledgeDetailCopyWithImpl(this._self, this._then);

  final _PledgeDetail _self;
  final $Res Function(_PledgeDetail) _then;

/// Create a copy of PledgeDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orgId = null,Object? orgName = null,Object? orgVerified = null,Object? title = null,Object? campaign = freezed,Object? body = null,Object? status = null,Object? shareCode = null,Object? createdAt = null,Object? signatures = null,Object? canManage = null,Object? mySignature = freezed,}) {
  return _then(_PledgeDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,orgVerified: null == orgVerified ? _self.orgVerified : orgVerified // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,shareCode: null == shareCode ? _self.shareCode : shareCode // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as int,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,mySignature: freezed == mySignature ? _self.mySignature : mySignature // ignore: cast_nullable_to_non_nullable
as MySignature?,
  ));
}

/// Create a copy of PledgeDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MySignatureCopyWith<$Res>? get mySignature {
    if (_self.mySignature == null) {
    return null;
  }

  return $MySignatureCopyWith<$Res>(_self.mySignature!, (value) {
    return _then(_self.copyWith(mySignature: value));
  });
}
}


/// @nodoc
mixin _$SignResult {

@JsonKey(name: 'pledge_id') String get pledgeId;@JsonKey(name: 'pledge_title') String get pledgeTitle;@JsonKey(name: 'signature_no') int get signatureNo;@JsonKey(name: 'signed_at') DateTime get signedAt;@JsonKey(name: 'certificate_code') String? get certificateCode; bool get already;
/// Create a copy of SignResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignResultCopyWith<SignResult> get copyWith => _$SignResultCopyWithImpl<SignResult>(this as SignResult, _$identity);

  /// Serializes this SignResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SignResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignResult&&(identical(other.pledgeId, _this.pledgeId) || other.pledgeId == _this.pledgeId)&&(identical(other.pledgeTitle, _this.pledgeTitle) || other.pledgeTitle == _this.pledgeTitle)&&(identical(other.signatureNo, _this.signatureNo) || other.signatureNo == _this.signatureNo)&&(identical(other.signedAt, _this.signedAt) || other.signedAt == _this.signedAt)&&(identical(other.certificateCode, _this.certificateCode) || other.certificateCode == _this.certificateCode)&&(identical(other.already, _this.already) || other.already == _this.already));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SignResult;
  return Object.hash(runtimeType,_this.pledgeId,_this.pledgeTitle,_this.signatureNo,_this.signedAt,_this.certificateCode,_this.already);
}

@override
String toString() {
  final _this = this as SignResult;
  return 'SignResult(pledgeId: ${_this.pledgeId}, pledgeTitle: ${_this.pledgeTitle}, signatureNo: ${_this.signatureNo}, signedAt: ${_this.signedAt}, certificateCode: ${_this.certificateCode}, already: ${_this.already})';
}


}

/// @nodoc
abstract mixin class $SignResultCopyWith<$Res>  {
  factory $SignResultCopyWith(SignResult value, $Res Function(SignResult) _then) = _$SignResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'pledge_id') String pledgeId,@JsonKey(name: 'pledge_title') String pledgeTitle,@JsonKey(name: 'signature_no') int signatureNo,@JsonKey(name: 'signed_at') DateTime signedAt,@JsonKey(name: 'certificate_code') String? certificateCode, bool already
});




}
/// @nodoc
class _$SignResultCopyWithImpl<$Res>
    implements $SignResultCopyWith<$Res> {
  _$SignResultCopyWithImpl(this._self, this._then);

  final SignResult _self;
  final $Res Function(SignResult) _then;

/// Create a copy of SignResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pledgeId = null,Object? pledgeTitle = null,Object? signatureNo = null,Object? signedAt = null,Object? certificateCode = freezed,Object? already = null,}) {
  return _then(SignResult(
pledgeId: null == pledgeId ? _self.pledgeId : pledgeId // ignore: cast_nullable_to_non_nullable
as String,pledgeTitle: null == pledgeTitle ? _self.pledgeTitle : pledgeTitle // ignore: cast_nullable_to_non_nullable
as String,signatureNo: null == signatureNo ? _self.signatureNo : signatureNo // ignore: cast_nullable_to_non_nullable
as int,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,certificateCode: freezed == certificateCode ? _self.certificateCode : certificateCode // ignore: cast_nullable_to_non_nullable
as String?,already: null == already ? _self.already : already // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SignResult].
extension SignResultPatterns on SignResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignResult value)  $default,){
final _that = this;
switch (_that) {
case _SignResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignResult value)?  $default,){
final _that = this;
switch (_that) {
case _SignResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'pledge_id')  String pledgeId, @JsonKey(name: 'pledge_title')  String pledgeTitle, @JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt, @JsonKey(name: 'certificate_code')  String? certificateCode,  bool already)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignResult() when $default != null:
return $default(_that.pledgeId,_that.pledgeTitle,_that.signatureNo,_that.signedAt,_that.certificateCode,_that.already);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'pledge_id')  String pledgeId, @JsonKey(name: 'pledge_title')  String pledgeTitle, @JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt, @JsonKey(name: 'certificate_code')  String? certificateCode,  bool already)  $default,) {final _that = this;
switch (_that) {
case _SignResult():
return $default(_that.pledgeId,_that.pledgeTitle,_that.signatureNo,_that.signedAt,_that.certificateCode,_that.already);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'pledge_id')  String pledgeId, @JsonKey(name: 'pledge_title')  String pledgeTitle, @JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt, @JsonKey(name: 'certificate_code')  String? certificateCode,  bool already)?  $default,) {final _that = this;
switch (_that) {
case _SignResult() when $default != null:
return $default(_that.pledgeId,_that.pledgeTitle,_that.signatureNo,_that.signedAt,_that.certificateCode,_that.already);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignResult implements SignResult {
  const _SignResult({@JsonKey(name: 'pledge_id') required this.pledgeId, @JsonKey(name: 'pledge_title') required this.pledgeTitle, @JsonKey(name: 'signature_no') required this.signatureNo, @JsonKey(name: 'signed_at') required this.signedAt, @JsonKey(name: 'certificate_code') this.certificateCode, this.already = false});
  factory _SignResult.fromJson(Map<String, dynamic> json) => _$SignResultFromJson(json);

@override@JsonKey(name: 'pledge_id') final  String pledgeId;
@override@JsonKey(name: 'pledge_title') final  String pledgeTitle;
@override@JsonKey(name: 'signature_no') final  int signatureNo;
@override@JsonKey(name: 'signed_at') final  DateTime signedAt;
@override@JsonKey(name: 'certificate_code') final  String? certificateCode;
@override@JsonKey() final  bool already;

/// Create a copy of SignResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignResultCopyWith<_SignResult> get copyWith => __$SignResultCopyWithImpl<_SignResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignResult&&(identical(other.pledgeId, pledgeId) || other.pledgeId == pledgeId)&&(identical(other.pledgeTitle, pledgeTitle) || other.pledgeTitle == pledgeTitle)&&(identical(other.signatureNo, signatureNo) || other.signatureNo == signatureNo)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt)&&(identical(other.certificateCode, certificateCode) || other.certificateCode == certificateCode)&&(identical(other.already, already) || other.already == already));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,pledgeId,pledgeTitle,signatureNo,signedAt,certificateCode,already);
}

@override
String toString() {
    return 'SignResult(pledgeId: $pledgeId, pledgeTitle: $pledgeTitle, signatureNo: $signatureNo, signedAt: $signedAt, certificateCode: $certificateCode, already: $already)';
}


}

/// @nodoc
abstract mixin class _$SignResultCopyWith<$Res> implements $SignResultCopyWith<$Res> {
  factory _$SignResultCopyWith(_SignResult value, $Res Function(_SignResult) _then) = __$SignResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'pledge_id') String pledgeId,@JsonKey(name: 'pledge_title') String pledgeTitle,@JsonKey(name: 'signature_no') int signatureNo,@JsonKey(name: 'signed_at') DateTime signedAt,@JsonKey(name: 'certificate_code') String? certificateCode, bool already
});




}
/// @nodoc
class __$SignResultCopyWithImpl<$Res>
    implements _$SignResultCopyWith<$Res> {
  __$SignResultCopyWithImpl(this._self, this._then);

  final _SignResult _self;
  final $Res Function(_SignResult) _then;

/// Create a copy of SignResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pledgeId = null,Object? pledgeTitle = null,Object? signatureNo = null,Object? signedAt = null,Object? certificateCode = freezed,Object? already = null,}) {
  return _then(_SignResult(
pledgeId: null == pledgeId ? _self.pledgeId : pledgeId // ignore: cast_nullable_to_non_nullable
as String,pledgeTitle: null == pledgeTitle ? _self.pledgeTitle : pledgeTitle // ignore: cast_nullable_to_non_nullable
as String,signatureNo: null == signatureNo ? _self.signatureNo : signatureNo // ignore: cast_nullable_to_non_nullable
as int,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,certificateCode: freezed == certificateCode ? _self.certificateCode : certificateCode // ignore: cast_nullable_to_non_nullable
as String?,already: null == already ? _self.already : already // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$OrgPledge {

 String get id; String get title; String? get campaign; String get body;@JsonKey(name: 'share_code') String get shareCode; String get status;@JsonKey(name: 'created_at') DateTime get createdAt; int get signatures;
/// Create a copy of OrgPledge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrgPledgeCopyWith<OrgPledge> get copyWith => _$OrgPledgeCopyWithImpl<OrgPledge>(this as OrgPledge, _$identity);

  /// Serializes this OrgPledge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrgPledge;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrgPledge&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.campaign, _this.campaign) || other.campaign == _this.campaign)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.shareCode, _this.shareCode) || other.shareCode == _this.shareCode)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.signatures, _this.signatures) || other.signatures == _this.signatures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrgPledge;
  return Object.hash(runtimeType,_this.id,_this.title,_this.campaign,_this.body,_this.shareCode,_this.status,_this.createdAt,_this.signatures);
}

@override
String toString() {
  final _this = this as OrgPledge;
  return 'OrgPledge(id: ${_this.id}, title: ${_this.title}, campaign: ${_this.campaign}, body: ${_this.body}, shareCode: ${_this.shareCode}, status: ${_this.status}, createdAt: ${_this.createdAt}, signatures: ${_this.signatures})';
}


}

/// @nodoc
abstract mixin class $OrgPledgeCopyWith<$Res>  {
  factory $OrgPledgeCopyWith(OrgPledge value, $Res Function(OrgPledge) _then) = _$OrgPledgeCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? campaign, String body,@JsonKey(name: 'share_code') String shareCode, String status,@JsonKey(name: 'created_at') DateTime createdAt, int signatures
});




}
/// @nodoc
class _$OrgPledgeCopyWithImpl<$Res>
    implements $OrgPledgeCopyWith<$Res> {
  _$OrgPledgeCopyWithImpl(this._self, this._then);

  final OrgPledge _self;
  final $Res Function(OrgPledge) _then;

/// Create a copy of OrgPledge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? campaign = freezed,Object? body = null,Object? shareCode = null,Object? status = null,Object? createdAt = null,Object? signatures = null,}) {
  return _then(OrgPledge(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,shareCode: null == shareCode ? _self.shareCode : shareCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrgPledge].
extension OrgPledgePatterns on OrgPledge {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrgPledge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrgPledge() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrgPledge value)  $default,){
final _that = this;
switch (_that) {
case _OrgPledge():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrgPledge value)?  $default,){
final _that = this;
switch (_that) {
case _OrgPledge() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? campaign,  String body, @JsonKey(name: 'share_code')  String shareCode,  String status, @JsonKey(name: 'created_at')  DateTime createdAt,  int signatures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrgPledge() when $default != null:
return $default(_that.id,_that.title,_that.campaign,_that.body,_that.shareCode,_that.status,_that.createdAt,_that.signatures);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? campaign,  String body, @JsonKey(name: 'share_code')  String shareCode,  String status, @JsonKey(name: 'created_at')  DateTime createdAt,  int signatures)  $default,) {final _that = this;
switch (_that) {
case _OrgPledge():
return $default(_that.id,_that.title,_that.campaign,_that.body,_that.shareCode,_that.status,_that.createdAt,_that.signatures);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? campaign,  String body, @JsonKey(name: 'share_code')  String shareCode,  String status, @JsonKey(name: 'created_at')  DateTime createdAt,  int signatures)?  $default,) {final _that = this;
switch (_that) {
case _OrgPledge() when $default != null:
return $default(_that.id,_that.title,_that.campaign,_that.body,_that.shareCode,_that.status,_that.createdAt,_that.signatures);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrgPledge extends OrgPledge {
  const _OrgPledge({required this.id, required this.title, this.campaign, required this.body, @JsonKey(name: 'share_code') required this.shareCode, required this.status, @JsonKey(name: 'created_at') required this.createdAt, this.signatures = 0}): super._();
  factory _OrgPledge.fromJson(Map<String, dynamic> json) => _$OrgPledgeFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? campaign;
@override final  String body;
@override@JsonKey(name: 'share_code') final  String shareCode;
@override final  String status;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey() final  int signatures;

/// Create a copy of OrgPledge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrgPledgeCopyWith<_OrgPledge> get copyWith => __$OrgPledgeCopyWithImpl<_OrgPledge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrgPledgeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrgPledge&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.campaign, campaign) || other.campaign == campaign)&&(identical(other.body, body) || other.body == body)&&(identical(other.shareCode, shareCode) || other.shareCode == shareCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.signatures, signatures) || other.signatures == signatures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,campaign,body,shareCode,status,createdAt,signatures);
}

@override
String toString() {
    return 'OrgPledge(id: $id, title: $title, campaign: $campaign, body: $body, shareCode: $shareCode, status: $status, createdAt: $createdAt, signatures: $signatures)';
}


}

/// @nodoc
abstract mixin class _$OrgPledgeCopyWith<$Res> implements $OrgPledgeCopyWith<$Res> {
  factory _$OrgPledgeCopyWith(_OrgPledge value, $Res Function(_OrgPledge) _then) = __$OrgPledgeCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? campaign, String body,@JsonKey(name: 'share_code') String shareCode, String status,@JsonKey(name: 'created_at') DateTime createdAt, int signatures
});




}
/// @nodoc
class __$OrgPledgeCopyWithImpl<$Res>
    implements _$OrgPledgeCopyWith<$Res> {
  __$OrgPledgeCopyWithImpl(this._self, this._then);

  final _OrgPledge _self;
  final $Res Function(_OrgPledge) _then;

/// Create a copy of OrgPledge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? campaign = freezed,Object? body = null,Object? shareCode = null,Object? status = null,Object? createdAt = null,Object? signatures = null,}) {
  return _then(_OrgPledge(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,shareCode: null == shareCode ? _self.shareCode : shareCode // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Signer {

 String get name;@JsonKey(name: 'signature_no') int get signatureNo;@JsonKey(name: 'signed_at') DateTime get signedAt;
/// Create a copy of Signer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignerCopyWith<Signer> get copyWith => _$SignerCopyWithImpl<Signer>(this as Signer, _$identity);

  /// Serializes this Signer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Signer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Signer&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.signatureNo, _this.signatureNo) || other.signatureNo == _this.signatureNo)&&(identical(other.signedAt, _this.signedAt) || other.signedAt == _this.signedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Signer;
  return Object.hash(runtimeType,_this.name,_this.signatureNo,_this.signedAt);
}

@override
String toString() {
  final _this = this as Signer;
  return 'Signer(name: ${_this.name}, signatureNo: ${_this.signatureNo}, signedAt: ${_this.signedAt})';
}


}

/// @nodoc
abstract mixin class $SignerCopyWith<$Res>  {
  factory $SignerCopyWith(Signer value, $Res Function(Signer) _then) = _$SignerCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'signature_no') int signatureNo,@JsonKey(name: 'signed_at') DateTime signedAt
});




}
/// @nodoc
class _$SignerCopyWithImpl<$Res>
    implements $SignerCopyWith<$Res> {
  _$SignerCopyWithImpl(this._self, this._then);

  final Signer _self;
  final $Res Function(Signer) _then;

/// Create a copy of Signer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? signatureNo = null,Object? signedAt = null,}) {
  return _then(Signer(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,signatureNo: null == signatureNo ? _self.signatureNo : signatureNo // ignore: cast_nullable_to_non_nullable
as int,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Signer].
extension SignerPatterns on Signer {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Signer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Signer() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Signer value)  $default,){
final _that = this;
switch (_that) {
case _Signer():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Signer value)?  $default,){
final _that = this;
switch (_that) {
case _Signer() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Signer() when $default != null:
return $default(_that.name,_that.signatureNo,_that.signedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt)  $default,) {final _that = this;
switch (_that) {
case _Signer():
return $default(_that.name,_that.signatureNo,_that.signedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'signature_no')  int signatureNo, @JsonKey(name: 'signed_at')  DateTime signedAt)?  $default,) {final _that = this;
switch (_that) {
case _Signer() when $default != null:
return $default(_that.name,_that.signatureNo,_that.signedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Signer implements Signer {
  const _Signer({required this.name, @JsonKey(name: 'signature_no') required this.signatureNo, @JsonKey(name: 'signed_at') required this.signedAt});
  factory _Signer.fromJson(Map<String, dynamic> json) => _$SignerFromJson(json);

@override final  String name;
@override@JsonKey(name: 'signature_no') final  int signatureNo;
@override@JsonKey(name: 'signed_at') final  DateTime signedAt;

/// Create a copy of Signer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignerCopyWith<_Signer> get copyWith => __$SignerCopyWithImpl<_Signer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Signer&&(identical(other.name, name) || other.name == name)&&(identical(other.signatureNo, signatureNo) || other.signatureNo == signatureNo)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,signatureNo,signedAt);
}

@override
String toString() {
    return 'Signer(name: $name, signatureNo: $signatureNo, signedAt: $signedAt)';
}


}

/// @nodoc
abstract mixin class _$SignerCopyWith<$Res> implements $SignerCopyWith<$Res> {
  factory _$SignerCopyWith(_Signer value, $Res Function(_Signer) _then) = __$SignerCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'signature_no') int signatureNo,@JsonKey(name: 'signed_at') DateTime signedAt
});




}
/// @nodoc
class __$SignerCopyWithImpl<$Res>
    implements _$SignerCopyWith<$Res> {
  __$SignerCopyWithImpl(this._self, this._then);

  final _Signer _self;
  final $Res Function(_Signer) _then;

/// Create a copy of Signer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? signatureNo = null,Object? signedAt = null,}) {
  return _then(_Signer(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,signatureNo: null == signatureNo ? _self.signatureNo : signatureNo // ignore: cast_nullable_to_non_nullable
as int,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ClaimResult {

@JsonKey(name: 'student_name') String get studentName;@JsonKey(name: 'records_claimed') int get recordsClaimed;
/// Create a copy of ClaimResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimResultCopyWith<ClaimResult> get copyWith => _$ClaimResultCopyWithImpl<ClaimResult>(this as ClaimResult, _$identity);

  /// Serializes this ClaimResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ClaimResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimResult&&(identical(other.studentName, _this.studentName) || other.studentName == _this.studentName)&&(identical(other.recordsClaimed, _this.recordsClaimed) || other.recordsClaimed == _this.recordsClaimed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ClaimResult;
  return Object.hash(runtimeType,_this.studentName,_this.recordsClaimed);
}

@override
String toString() {
  final _this = this as ClaimResult;
  return 'ClaimResult(studentName: ${_this.studentName}, recordsClaimed: ${_this.recordsClaimed})';
}


}

/// @nodoc
abstract mixin class $ClaimResultCopyWith<$Res>  {
  factory $ClaimResultCopyWith(ClaimResult value, $Res Function(ClaimResult) _then) = _$ClaimResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'student_name') String studentName,@JsonKey(name: 'records_claimed') int recordsClaimed
});




}
/// @nodoc
class _$ClaimResultCopyWithImpl<$Res>
    implements $ClaimResultCopyWith<$Res> {
  _$ClaimResultCopyWithImpl(this._self, this._then);

  final ClaimResult _self;
  final $Res Function(ClaimResult) _then;

/// Create a copy of ClaimResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentName = null,Object? recordsClaimed = null,}) {
  return _then(ClaimResult(
studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,recordsClaimed: null == recordsClaimed ? _self.recordsClaimed : recordsClaimed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimResult].
extension ClaimResultPatterns on ClaimResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimResult value)  $default,){
final _that = this;
switch (_that) {
case _ClaimResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimResult value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'student_name')  String studentName, @JsonKey(name: 'records_claimed')  int recordsClaimed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimResult() when $default != null:
return $default(_that.studentName,_that.recordsClaimed);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'student_name')  String studentName, @JsonKey(name: 'records_claimed')  int recordsClaimed)  $default,) {final _that = this;
switch (_that) {
case _ClaimResult():
return $default(_that.studentName,_that.recordsClaimed);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'student_name')  String studentName, @JsonKey(name: 'records_claimed')  int recordsClaimed)?  $default,) {final _that = this;
switch (_that) {
case _ClaimResult() when $default != null:
return $default(_that.studentName,_that.recordsClaimed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimResult implements ClaimResult {
  const _ClaimResult({@JsonKey(name: 'student_name') required this.studentName, @JsonKey(name: 'records_claimed') this.recordsClaimed = 0});
  factory _ClaimResult.fromJson(Map<String, dynamic> json) => _$ClaimResultFromJson(json);

@override@JsonKey(name: 'student_name') final  String studentName;
@override@JsonKey(name: 'records_claimed') final  int recordsClaimed;

/// Create a copy of ClaimResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimResultCopyWith<_ClaimResult> get copyWith => __$ClaimResultCopyWithImpl<_ClaimResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimResult&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.recordsClaimed, recordsClaimed) || other.recordsClaimed == recordsClaimed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,studentName,recordsClaimed);
}

@override
String toString() {
    return 'ClaimResult(studentName: $studentName, recordsClaimed: $recordsClaimed)';
}


}

/// @nodoc
abstract mixin class _$ClaimResultCopyWith<$Res> implements $ClaimResultCopyWith<$Res> {
  factory _$ClaimResultCopyWith(_ClaimResult value, $Res Function(_ClaimResult) _then) = __$ClaimResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'student_name') String studentName,@JsonKey(name: 'records_claimed') int recordsClaimed
});




}
/// @nodoc
class __$ClaimResultCopyWithImpl<$Res>
    implements _$ClaimResultCopyWith<$Res> {
  __$ClaimResultCopyWithImpl(this._self, this._then);

  final _ClaimResult _self;
  final $Res Function(_ClaimResult) _then;

/// Create a copy of ClaimResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentName = null,Object? recordsClaimed = null,}) {
  return _then(_ClaimResult(
studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,recordsClaimed: null == recordsClaimed ? _self.recordsClaimed : recordsClaimed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
