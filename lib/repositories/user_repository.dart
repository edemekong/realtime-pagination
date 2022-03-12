import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserRepository {
  final List<StreamSubscription> _userSubscriptions = [];

  UserRepository() {
    clearListeners();
  }
  final _firestoreUser = FirebaseFirestore.instance.collection('users');
  List<User> users = [];

  QuerySnapshot<User>? userQuerysnapshot;

  Future<List<User>> fetchUsers([int limitTo = 10]) async {
    try {
      final query = _firestoreUser.limit(limitTo).orderBy('name', descending: false).withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromMap(snapshot.data() ?? {}),
            toFirestore: (a, _) => a.toMap(),
          );

      if (userQuerysnapshot == null) {
        final userSubscription = query.snapshots().listen((event) {
          userQuerysnapshot = event;
          addToUsers(event);
        });
        debugPrint('null running');
        _userSubscriptions.add(userSubscription);
      } else {
        final userSubscription =
            query.startAfterDocument(userQuerysnapshot?.docs.last as DocumentSnapshot).snapshots().listen((event) {
          userQuerysnapshot = event;
          addToUsers(event);
        });
        _userSubscriptions.add(userSubscription);
        debugPrint('non null running');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return users;
  }

  void addToUsers(QuerySnapshot<User> event) {
    for (final userDoc in event.docs) {
      final user = userDoc.data();
      final index = users.indexWhere((element) => user.id == element.id);
      if (index != -1) {
        users.removeAt(index);
        users.insert(index, user);
      } else {
        users.add(user);
      }
    }
  }

  void clearListeners() {
    for (final element in _userSubscriptions) {
      element.cancel();
    }
    _userSubscriptions.clear();
  }
}
