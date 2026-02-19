import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Robot extends StatelessWidget {
  const Robot({super.key});

  @override
  Widget build(BuildContext context) {
    return  ModelViewer(
       src: 'elf_flutter/assets/mechdrone.glb',

      // ===== Visual Settings =====
      alt: "ROBO AI",
      ar: false,
      autoRotate: true,
      cameraControls: false,
      backgroundColor: Colors.transparent,

      // ===== Animation Settings =====
      autoPlay: true,
      animationName: "Animation", // change if your animation has name
      animationCrossfadeDuration: 500,

      // ===== Camera =====
      cameraOrbit: "0deg 75deg 2.5m",
      minCameraOrbit: "auto auto 2m",
      maxCameraOrbit: "auto auto 3m",

      // ===== Interaction disabled for onboarding =====
      disableZoom: true,
      disablePan: true,
    );
  }
}