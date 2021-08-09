// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileDto on _ProfileDto, Store {
  final _$idAtom = Atom(name: '_ProfileDto.id');

  @override
  int get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$codProfileAtom = Atom(name: '_ProfileDto.codProfile');

  @override
  int get codProfile {
    _$codProfileAtom.reportRead();
    return super.codProfile;
  }

  @override
  set codProfile(int value) {
    _$codProfileAtom.reportWrite(value, super.codProfile, () {
      super.codProfile = value;
    });
  }

  final _$profileTypeAtom = Atom(name: '_ProfileDto.profileType');

  @override
  String get profileType {
    _$profileTypeAtom.reportRead();
    return super.profileType;
  }

  @override
  set profileType(String value) {
    _$profileTypeAtom.reportWrite(value, super.profileType, () {
      super.profileType = value;
    });
  }

  @override
  String toString() {
    return '''
id: ${id},
codProfile: ${codProfile},
profileType: ${profileType}
    ''';
  }
}
