// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_dto.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StateDto on _StateDto, Store {
  final _$idAtom = Atom(name: '_StateDto.id');

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

  final _$nameAtom = Atom(name: '_StateDto.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$acronymAtom = Atom(name: '_StateDto.acronym');

  @override
  String get acronym {
    _$acronymAtom.reportRead();
    return super.acronym;
  }

  @override
  set acronym(String value) {
    _$acronymAtom.reportWrite(value, super.acronym, () {
      super.acronym = value;
    });
  }

  final _$urlImageAtom = Atom(name: '_StateDto.urlImage');

  @override
  String get urlImage {
    _$urlImageAtom.reportRead();
    return super.urlImage;
  }

  @override
  set urlImage(String value) {
    _$urlImageAtom.reportWrite(value, super.urlImage, () {
      super.urlImage = value;
    });
  }

  @override
  String toString() {
    return '''
id: ${id},
name: ${name},
acronym: ${acronym},
urlImage: ${urlImage}
    ''';
  }
}
