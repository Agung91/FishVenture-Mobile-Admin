import 'package:admin/config/text_style.dart';
import 'package:admin/modules/home/widget/w_home.dart';
import 'package:flutter/material.dart';

import 'package:admin/config/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const _AppbarHome(),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 12),
        itemBuilder: (context, index) {
          return const WHome();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        itemCount: 12,
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      //   color: CustomColors.white,
      //   child: CustomButton(
      //     textButton: 'Tambah Kolam',
      //     onTap: () async {
      //       RouteBloc().push(RoutePool());
      //     },
      //   ),
      // ),
    );
  }
}

class _AppbarHome extends StatelessWidget implements PreferredSizeWidget {
  const _AppbarHome({
    super.key,
  });

  @override
  Size get preferredSize => const Size(double.infinity, 119);

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      content: const Text('Error message text'),
      leading: const CircleAvatar(child: Icon(Icons.delete)),
      actions: [
        TextButton(
          child: const Text('ACTION 1'),
          onPressed: () {},
        ),
        TextButton(
          child: const Text('ACTION 2'),
          onPressed: () {},
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    // final blocProfile = context.read<EditProfileBloc>();
    return Container(
      height: 101,
      color: CustomColors.primary,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              // Icon(IconlyLight.arrow_left),
              const CircleAvatar(
                radius: 20,
                backgroundColor: CustomColors.grey,
                backgroundImage: AssetImage('assets/default_profile.png'),
              ),
              const SizedBox(width: 12.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang,',
                    style: CustomTextStyle.body3Regular
                        .copyWith(color: CustomColors.white),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    '-',
                    style: CustomTextStyle.body1Medium
                        .copyWith(color: CustomColors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}