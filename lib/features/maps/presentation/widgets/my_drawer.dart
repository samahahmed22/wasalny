import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../user/domain/entities/user.dart';
import '../../../user/presentaion/cubit/phone_auth/phone_auth_cubit.dart';
import '../../../user/presentaion/cubit/user/user_cubit.dart';
import 'my_divider.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  User? user;

  Widget buildDrawerHeader(context) {
    return Column(
      children: [
        Container(
          height: 150,
          padding: EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[100],
          ),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80.0,
              backgroundImage: user!.imageUrl == null
                  ? AssetImage('assets/images/default-profile-picture.png')
                      as ImageProvider
                  : NetworkImage(user!.imageUrl!)),
        ),
        Text(
          user!.firstName! + ' ' + user!.lastName!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Text(
        //   user!.phoneNumber,
        //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        // ),

        // const SizedBox(
        //   height: 5,
        // ),
      ],
    );
  }

  Widget buildDrawerListItem(
      {required IconData leadingIcon,
      required String title,
      Widget? trailing,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? AppColors.blue,
      ),
      title: Text(title),
      trailing: trailing ??= Icon(
        Icons.arrow_right,
        color: AppColors.blue,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  Widget buildLogoutBlocProvider(context) {
    return Container(
      child: buildDrawerListItem(
        leadingIcon: Icons.logout,
        title: 'Logout',
        onTap: () async {
          await PhoneAuthCubit.get(context).logOut();

          Navigator.of(context).pushReplacementNamed(Routes.loginScreenRoute);
        },
        color: Colors.red,
        trailing: SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = UserCubit.get(context).currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 280,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: buildDrawerHeader(context),
            ),
          ),
          buildDrawerListItem(
            leadingIcon: Icons.person,
            title: 'My Profile',
            onTap: () {
              Navigator.of(context)
                  .pushNamed(Routes.profileScreenRoute);
            },
          ),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {},
          ),
          MyDivider(),
          // buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.settings, title: 'Settings'),
          MyDivider(),
          // buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          MyDivider(),
          // buildDrawerListItemsDivider(),
          buildLogoutBlocProvider(context),
          const SizedBox(
            height: 180,
          ),
        ],
      ),
    );
  }
}
