import 'package:admin/common/custom/empty_data.dart';
import 'package:admin/config/text_style.dart';
import 'package:admin/modules/home/widget/w_home.dart';
import 'package:admin/modules/pond/bloc/bloc_pond.dart';
import 'package:admin/modules/pond/model/model_pond.dart';
import 'package:admin/modules/pool/screen/page_list_pool.dart';
import 'package:admin/modules/profile/bloc/bloc_profile.dart';
import 'package:admin/modules/profile/model/model_profile.dart';
import 'package:flutter/material.dart';

import 'package:admin/config/colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocPond = context.read<PondBloc>();
    final blocProfile = context.read<ProfileBloc>();
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const _AppbarHome(),
      body: StreamBuilder<List<PondModel>>(
          stream: blocPond.listPond.stream,
          initialData: blocPond.listPond.value,
          builder: (context, snapshot) {
            final listData = snapshot.data;
            if (listData == null || listData.isEmpty) {
              return EmptyData(
                label: 'Belum ada pengajuan terbaru',
                onRefresh: () async {
                  blocPond.getPonds();
                  await blocProfile.getProfile();
                },
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                blocPond.getPonds();
                await blocProfile.getProfile();
              },
              color: CustomColors.primary,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 26, horizontal: 12),
                itemBuilder: (context, index) {
                  return WHome(
                    pondModel: listData[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
                itemCount: listData.length,
              ),
            );
          }),
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

  // void show(BuildContext context) {
  //   ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
  //     content: const Text('Error message text'),
  //     leading: const CircleAvatar(child: Icon(Icons.delete)),
  //     actions: [
  //       TextButton(
  //         child: const Text('ACTION 1'),
  //         onPressed: () {},
  //       ),
  //       TextButton(
  //         child: const Text('ACTION 2'),
  //         onPressed: () {},
  //       ),
  //     ],
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    final blocProfile = context.read<ProfileBloc>();
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
                  StreamBuilder<ProfileModel?>(
                      stream: blocProfile.profile.stream,
                      initialData: blocProfile.profile.value,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data?.name ?? '-',
                          style: CustomTextStyle.body1Medium
                              .copyWith(color: CustomColors.white),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
