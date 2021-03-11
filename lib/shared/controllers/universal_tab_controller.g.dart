// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'universal_tab_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UniversalTabController on UniversalTabControllerBase, Store {
  final _$tabControllerAtom =
      Atom(name: 'UniversalTabControllerBase.tabController');

  @override
  TabController get tabController {
    _$tabControllerAtom.reportRead();
    return super.tabController;
  }

  @override
  set tabController(TabController value) {
    _$tabControllerAtom.reportWrite(value, super.tabController, () {
      super.tabController = value;
    });
  }

  @override
  String toString() {
    return '''
tabController: ${tabController}
    ''';
  }
}
