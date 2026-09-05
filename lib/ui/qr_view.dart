import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:soi/core/theme/tokens.dart';

/// QR code on a white tile. Always white with dark modules regardless of
/// theme: scanners need contrast, and the certificate palette is fixed.
class QrView extends StatelessWidget {
  const QrView(this.data, {super.key, this.size = 240, this.padding = 12, this.semanticsLabel});
  final String data;
  final double size;
  final double padding;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      image: true,
      child: Container(
        width: size + padding * 2,
        height: size + padding * 2,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Radii.md),
        ),
        child: QrImageView(
          data: data,
          size: size,
          backgroundColor: Colors.white,
          errorCorrectionLevel: QrErrorCorrectLevel.M,
          eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: SoiColors.certQrInk),
          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.square,
            color: SoiColors.certQrInk,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
