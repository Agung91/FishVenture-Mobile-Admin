import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:admin/common/custom/launch_url.dart';
import 'package:admin/common/widgets/appbar.dart';
import 'package:admin/config/colors.dart';
import 'package:admin/config/text_style.dart';
import 'package:admin/modules/pond/model/model_pond.dart';

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
            _WPool(),
            const SizedBox(height: 12),
            _WFile(fileUrl: pondModel.berkas?.first.file ?? '-'),
            const SizedBox(height: 16),
            _WActionButton(),
            const SizedBox(height: 16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Berkas',
              style: CustomTextStyle.body1Medium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: Text(
                        'blabla blaaa blabla blaaa blabla blaaa blabla blaaa blabla blaaa')),
                const SizedBox(width: 24),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColors.primary,
                  ),
                  child: Text(
                    'Lihat',
                    style: CustomTextStyle.body1Medium
                        .copyWith(color: CustomColors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _WActionButton extends StatelessWidget {
  const _WActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onPressed: () {},
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
              onPressed: () {},
              child: Text(
                'Terima',
                style: CustomTextStyle.body2Medium
                    .copyWith(color: CustomColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WPool extends StatelessWidget {
  const _WPool({
    super.key,
  });

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
                    // pool: listPool[index],
                    );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: 12,
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
    // required this.pool,
  }) : super(key: key);

  // final PoolModel pool;

  @override
  Widget build(BuildContext context) {
    // final submissionBloc = context.read<SubmissionBloc>();
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: const FadeInImage(
              height: 120,
              width: 200,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/load_img.png'),
              image: CachedNetworkImageProvider(
                  'https://picsum.photos/500/500?random='),
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
                  // pool.name,
                  'pool.name',
                  style: CustomTextStyle.body2SemiBold,
                ),
                const SizedBox(height: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    // '${pool.long}m x ${pool.wide}m',
                    'https://picsum.photos/500/500?random=',
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
