import 'package:flutter/material.dart';

import 'package:admin/common/widgets/appbar.dart';
import 'package:admin/common/widgets/button.dart';
import 'package:admin/config/colors.dart';
import 'package:admin/modules/pool/widget/w_pool.dart';

class ListPoolPage extends StatelessWidget {
  const ListPoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const CustomAppbar(appbarText: 'Kolam'),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 12),
        itemBuilder: (context, index) {
          return const WPool();
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
