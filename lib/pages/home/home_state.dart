import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider_clean_code/repositories/user_repository.dart';
import 'package:provider_clean_code/services/get_it.dart';

import '../../base_state.dart';
import '../../models/user.dart';

class HomeState extends BaseState {
  final UserRepository _userRepo = locate<UserRepository>();

  ScrollController? homeScrollController;
  List<User> users = [];

  bool isFetchingUsers = false;
  bool hasNextUser = true;

  bool hideFAB = false;

  int limitTo = 20;

  final List<Color> colors = const [Colors.blue, Colors.red, Colors.yellow, Colors.purple, Colors.orange, Colors.green];

  HomeState() {
    homeScrollController = ScrollController();
    _loadNextBatchUsers();

    homeScrollController?.addListener(_listenToHomeScroll);
  }

  void _listenToHomeScroll() {
    if (homeScrollController == null) return;

    final reachMaxExtent = homeScrollController!.offset >= homeScrollController!.position.maxScrollExtent / 2;
    final outOfRange = !homeScrollController!.position.outOfRange && homeScrollController!.position.pixels != 0;
    if (reachMaxExtent && outOfRange) {
      _loadNextBatchUsers();
    }

    _hideFAB();
  }

  void _loadNextBatchUsers() async {
    if (hasNextUser && !isFetchingUsers) {
      isFetchingUsers = true;
      int previousLength = _userRepo.users.length;

      await _userRepo.fetchUsers(limitTo);
      await Future.delayed(const Duration(milliseconds: 2000));
      int newLength = _userRepo.users.length;

      if (newLength == previousLength && hasNextUser) hasNextUser = false;
      isFetchingUsers = false;

      if (newLength > previousLength) {
        _userListeners();
      }
    }
  }

  void _userListeners() {
    users = _userRepo.users;
    notifyListeners();
  }

  void _hideFAB() {
    if (homeScrollController!.position.userScrollDirection == ScrollDirection.forward) {
      if (hideFAB) {
        hideFAB = false;
        notifyListeners();
      }
    } else {
      if (!hideFAB) {
        hideFAB = true;
        notifyListeners();
      }
    }
  }
}
