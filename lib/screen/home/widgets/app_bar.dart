import 'package:flutter/material.dart';

class CustomeAppBar extends StatefulWidget with PreferredSizeWidget {
  Function(String value)? onChange;
  CustomeAppBar({Key? key, required this.onChange}) : super(key: key);

  @override
  State<CustomeAppBar> createState() => _CustomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomeAppBarState extends State<CustomeAppBar> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        const SizedBox(
          width: 16,
        ),
        const Center(
          child: Text(
            "Note",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: TextField(
            textAlign: TextAlign.center,
            controller: searchController,
            onChanged: widget.onChange,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        const Icon(
          Icons.settings,
          size: 30,
        ),
        const SizedBox(
          width: 16,
        )
      ],
    );
  }
}
