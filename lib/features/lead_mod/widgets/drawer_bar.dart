import 'package:flutter/material.dart';

class LeadAppDrawer extends StatelessWidget {
  const LeadAppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          for (var i = 0; i < 6; i++)
            const ListTile(
              title: Text('Module Title'),
              subtitle: Text('Module Features'),
              // onTap: _closeDrawer,
            )
        ],
      ),
    );
  }
}
