import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _urlEmail = 'mailto:prasetyobagus27@gmail.com';
    final _urlGithub = 'https://github.com/mbp27';
    final _urlLinkedIn =
        'https://www.linkedin.com/in/muhamad-bagus-prasetyo-512b3517b/';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          ListTile(
            onTap: () async {
              await canLaunch(_urlEmail)
                  ? await launch(_urlEmail)
                  : throw 'Could not launch $_urlEmail';
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: Icon(MdiIcons.email),
            title: Text('Email'),
          ),
          ListTile(
            onTap: () async {
              await canLaunch(_urlGithub)
                  ? await launch(_urlGithub)
                  : throw 'Could not launch $_urlGithub';
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: Icon(MdiIcons.github),
            title: Text('Github'),
          ),
          ListTile(
            onTap: () async {
              await canLaunch(_urlLinkedIn)
                  ? await launch(_urlLinkedIn)
                  : throw 'Could not launch $_urlLinkedIn';
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: Icon(MdiIcons.linkedin),
            title: Text('LinkedIn'),
          ),
        ],
      ),
    );
  }
}
