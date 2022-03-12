import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_clean_code/pages/user_profile/user_profile_state.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class UserProfileUserWidget extends StatelessWidget {
  final String uid;
  const UserProfileUserWidget({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = UserProfileState(uid);
    return ChangeNotifierProvider.value(
      value: state,
      child: const UserProfileView(),
    );
  }
}
