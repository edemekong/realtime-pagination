import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_clean_code/pages/home/home_state.dart';
import '../../components/user_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isHideFAB = context.select((HomeState value) => value.hideFAB);
    debugPrint('rebuild this many times');

    return Scaffold(
      appBar: AppBar(title: const Text('Realtime Pagination')),
      body: const UserList(),
      floatingActionButton: !isHideFAB
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {},
            )
          : null,
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final users = context.select((HomeState value) => value.users);
    final users = context.watch<HomeState>().users;

    final read = context.read<HomeState>();
    return ListView.builder(
      itemCount: users.length,
      controller: read.homeScrollController,
      itemBuilder: (_, index) {
        final color = read.colors[index % read.colors.length];
        return UserCard(
          user: users[index],
          color: color,
          onTap: () {},
        );
      },
    );
  }
}

class SomeWidget extends StatelessWidget {
  const SomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final read = context.read<HomeState>();

    return InkWell(
      onTap: () => read.setLoading(true),
      child: Text(read.users.length.toString()),
    );
  }
}
