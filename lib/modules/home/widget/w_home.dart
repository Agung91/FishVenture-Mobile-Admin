import 'package:admin/modules/pond/bloc/bloc_pond.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:admin/config/colors.dart';
import 'package:admin/config/text_style.dart';
import 'package:provider/provider.dart';

class WHome extends StatelessWidget {
  const WHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final blocPond = context.read<PondBloc>();
    return InkWell(
      onTap: () {
        blocPond.getPonds();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: CustomColors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const FadeInImage(
                height: 60,
                width: 100,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/load_img.png'),
                image: CachedNetworkImageProvider(
                    'https://picsum.photos/500/500?random=1'),
              ),
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pembudidaya 1',
                  style: CustomTextStyle.body2SemiBold,
                ),
                const SizedBox(height: 2),
                Text(
                  'Pengajuan',
                  style: CustomTextStyle.body2Medium,
                ),
              ],
            ),
            // const Spacer(),
            // InkWell(
            //   onTap: () {},
            //   child: const SizedBox(
            //     height: 40,
            //     width: 40,
            //     child: Icon(
            //       Iconsax.trash,
            //       color: CustomColors.red,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
