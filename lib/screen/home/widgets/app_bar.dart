import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Notes"),
      actions: const [
        Icon(
          CupertinoIcons.search,
          size: 30,
        ),
        SizedBox(
          width: 16,
        ),
        Icon(
          Icons.settings,
          size: 30,
        ),
        SizedBox(
          width: 16,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
