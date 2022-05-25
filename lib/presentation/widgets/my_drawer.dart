import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/data/models/user_model.dart';

import '../../business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import '../../business_logic/cubit/user/user_cubit.dart';
import '../../helpers/cache_helper.dart';
import '../../styles/colors.dart';
import '../../shared/constants.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  UserModel? user;

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
          child: user!.imageUrl == null 
          ?Image.asset(
            'assets/images/default-profile-picture.png',
            fit: BoxFit.cover,
          )
          :Image.network(user!.imageUrl!, fit: BoxFit.cover),
 
        ),
        Text(
          user!.firstName! + ' ' + user!.lastName!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          user!.phoneNumber,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        
        const SizedBox(
          height: 5,
        ),
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
        color: color ?? MyColors.blue,
      ),
      title: Text(title),
      trailing: trailing ??= Icon(
        Icons.arrow_right,
        color: MyColors.blue,
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
          await UserCubit.get(context).logOut();
          CacheHelper.removeData(key: 'userId').then((value) =>
              Navigator.of(context).pushReplacementNamed(loginScreen));
        },
        color: Colors.red,
        trailing: SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = UserCubit.get(context).user;
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
              Navigator.of(context).pushNamed(editAccountScreen);
            },
          ),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {},
          ),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.settings, title: 'Settings'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          buildDrawerListItemsDivider(),
          buildLogoutBlocProvider(context),
          const SizedBox(
            height: 180,
          ),
          
        ],
      ),
    );
  }
}
