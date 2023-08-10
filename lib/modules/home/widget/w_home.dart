import 'package:admin/common/model/model_status.dart';
import 'package:admin/core/route/bloc_route.dart';
import 'package:admin/core/route/route_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import 'package:admin/config/colors.dart';
import 'package:admin/config/text_style.dart';
import 'package:admin/modules/pond/bloc/bloc_pond.dart';
import 'package:admin/modules/pond/model/model_pond.dart';

class WHome extends StatelessWidget {
  const WHome({
    Key? key,
    required this.pondModel,
  }) : super(key: key);

  final PondModel pondModel;

  @override
  Widget build(BuildContext context) {
    final pondBloc = context.read<PondBloc>();
    return InkWell(
      onTap: () {
        if (pondModel.status == StatusSubmission.submission) {
          pondBloc.updatePondReviewed(pondModel.id);
        }
        RouteBloc().push(RoutePond(pondModel));
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
              child: FadeInImage(
                height: 60,
                width: 100,
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/load_img.png'),
                image: CachedNetworkImageProvider(pondModel.image),
                imageErrorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 60,
                    width: 100,
                    child: Icon(
                      IconlyBold.info_square,
                      color: CustomColors.red,
                      size: 60,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  pondModel.status.toUpperCase(),
                  style: CustomTextStyle.body2Regular
                      .copyWith(color: CustomColors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  pondModel.name,
                  style: CustomTextStyle.body1Medium,
                ),
              ],
            ),
            const Spacer(),
            if (pondModel.status == StatusSubmission.submission)
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.primary,
                ),
              )
          ],
        ),
      ),
    );
  }
}
