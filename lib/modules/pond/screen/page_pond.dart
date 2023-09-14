import 'package:admin/common/snackbar/snackbar_popup.dart';
import 'package:admin/core/route/bloc_route.dart';
import 'package:admin/modules/home/screen/page_home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import 'package:admin/common/custom/launch_url.dart';
import 'package:admin/common/model/model_status.dart';
import 'package:admin/common/widgets/appbar.dart';
import 'package:admin/config/colors.dart';
import 'package:admin/config/text_style.dart';
import 'package:admin/modules/pond/bloc/bloc_pond.dart';
import 'package:admin/modules/pond/model/model_pond.dart';
import 'package:admin/modules/pool/model/model_pool.dart';

class PondPage extends StatelessWidget {
  const PondPage({
    Key? key,
    required this.pondModel,
  }) : super(key: key);

  final PondModel pondModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const CustomAppbar(appbarText: 'Detail Pengajuan'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _WImage(pondModel: pondModel),
            const SizedBox(height: 12),
            _WName(pondModel: pondModel),
            const SizedBox(height: 12),
            _WAddress(pondModel: pondModel),
            const SizedBox(height: 12),
            _WPool(listPool: pondModel.listPool ?? []),
            const SizedBox(height: 12),
            _WFile(fileUrl: pondModel.berkas?.first.file ?? '-'),
            const SizedBox(height: 16),
            if (pondModel.status == StatusSubmission.submission ||
                pondModel.status == StatusSubmission.reviewed)
              _WActionButton(pondModel: pondModel),
          ],
        ),
      ),
    );
  }
}

class _WFile extends StatelessWidget {
  const _WFile({
    Key? key,
    required this.fileUrl,
  }) : super(key: key);

  final String fileUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchInBrowser(fileUrl),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Berkas',
                    style: CustomTextStyle.body1Medium,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      'Berikut ini adalah berkas yang di unggah sebagai bagian dari persyaratan yang harus dipenuhi oleh pembudidaya.'),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: CustomColors.primary,
              ),
              child: Column(
                children: [
                  const Icon(
                    IconlyLight.document,
                    size: 26,
                    color: CustomColors.white,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lihat',
                    style: CustomTextStyle.body1Regular
                        .copyWith(color: CustomColors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WActionButton extends StatelessWidget {
  const _WActionButton({
    Key? key,
    required this.pondModel,
  }) : super(key: key);

  final PondModel pondModel;

  @override
  Widget build(BuildContext context) {
    final blocPond = context.read<PondBloc>();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: CustomColors.red),
                      ),
                    ),
                  ),
                  onPressed: () {
                    blocPond.updatePondDisabled(pondModel.id).then((value) =>
                        snacBarPopUp(
                            color: CustomColors.green,
                            icon: IconlyBold.tick_square,
                            message: 'Berhasil menolak budidaya'));
                    RouteBloc().pop();
                  },
                  child: Text(
                    'Tolak',
                    style: CustomTextStyle.body2Medium
                        .copyWith(color: CustomColors.red),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: CustomColors.primary),
                      ),
                    ),
                  ),
                  onPressed: () {
                    blocPond.updatePondActived(pondModel.id).then((value) =>
                        snacBarPopUp(
                            color: CustomColors.green,
                            icon: IconlyBold.tick_square,
                            message: 'Berhasil mengaktifkan budidaya'));
                    RouteBloc().pop();
                  },
                  child: Text(
                    'Terima',
                    style: CustomTextStyle.body2Medium
                        .copyWith(color: CustomColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _WPool extends StatelessWidget {
  const _WPool({
    Key? key,
    required this.listPool,
  }) : super(key: key);

  final List<PoolModel> listPool;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Kolam',
            style: CustomTextStyle.body1Medium,
          ),
          SizedBox(
            height: 224,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _WPoolCard(
                  pool: listPool[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: listPool.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _WAddress extends StatelessWidget {
  const _WAddress({
    Key? key,
    required this.pondModel,
  }) : super(key: key);

  final PondModel pondModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alamat',
                  style: CustomTextStyle.body1Medium,
                ),
                const SizedBox(height: 4),
                Text(
                  '${pondModel.noteAddress} || ${pondModel.detailAddress}, ${pondModel.district.name}, Kec.${pondModel.city.name}, ${pondModel.province.name} - ${pondModel.country.name} ',
                  style: CustomTextStyle.body2Regular,
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          TextButton.icon(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(
                  color: CustomColors.primary,
                ),
              ),
            )),
            onPressed: () => launchInBrowser(pondModel.url),
            // onPressed: () => context.read<PondBloc>().getPonds(),
            label: Text(
              'Lokasi',
              style: CustomTextStyle.body1Medium
                  .copyWith(color: CustomColors.primary),
            ),
            icon: const Icon(
              IconlyBold.location,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _WName extends StatelessWidget {
  const _WName({
    super.key,
    required this.pondModel,
  });

  final PondModel pondModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CustomColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              pondModel.name.toUpperCase(),
              style: CustomTextStyle.body1Medium,
            ),
          ),
          Text(
            pondModel.status.toUpperCase(),
            style: CustomTextStyle.body2Medium.copyWith(
              color: CustomColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _WImage extends StatelessWidget {
  const _WImage({
    super.key,
    required this.pondModel,
  });

  final PondModel pondModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage(
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
      ),
    );
  }
}

class _WPoolCard extends StatelessWidget {
  const _WPoolCard({
    Key? key,
    required this.pool,
  }) : super(key: key);

  final PoolModel pool;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      // height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: CustomColors.white,
        boxShadow: const [
          BoxShadow(
              blurRadius: 8,
              color: CustomColors.fadedGrey,
              offset: Offset(2, 2)),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: FadeInImage(
              height: 120,
              width: 200,
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/load_img.png'),
              image: CachedNetworkImageProvider(pool.image),
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  pool.name,
                  style: CustomTextStyle.body2SemiBold,
                ),
                const SizedBox(height: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${pool.long}m x ${pool.wide}m',
                    style: CustomTextStyle.body2Medium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
