import 'package:amrita_events_flutter/screens/admin/event_rsvp_management.dart';
import 'package:amrita_events_flutter/screens/admin/manage_events.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import '../../widgets/admin_card.dart';
import '../../widgets/custom_sliver_widget.dart';
import '../../widgets/top_bar_no_search_widget.dart';
import 'broadcast_notifications.dart';
import 'manage_users.dart';

class AdminConsole extends StatelessWidget {
  const AdminConsole({Key? key, required this.userRole}) : super(key: key);
  final String userRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWidgetNoSearch(
              icon: Icons.settings_outlined, title: "Admin"),
          Expanded(
            child: Column(
              children: [
                Expanded(
                    child: AdminCard(
                  title: 'Manage Users',
                  subTitle: 'Manage all users here',
                  iconData: Icons.manage_accounts,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ManageUsers(userRole: userRole)));
                  },
                )),
                Expanded(
                    child: AdminCard(
                  title: 'Manage Events',
                  subTitle: 'Manage all events here',
                  iconData: Icons.event_available,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ManageEvents()));
                  },
                )),
                Expanded(
                    child: AdminCard(
                  title: 'RSVP',
                  subTitle: 'View all RSVPd user and stats here',
                  iconData: Icons.rsvp_outlined,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                        const EventRSVPManagement()));
                  },
                )),
                Expanded(
                    child: AdminCard(
                  title: 'Broadcast Notifications',
                  subTitle: 'Broadcast announcements to all users',
                  iconData: Icons.notification_add,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const BroadcastNotifications()));
                  },
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
