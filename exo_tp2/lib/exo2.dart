import 'dart:async';
import 'package:flutter/material.dart';

class Exo2 extends StatefulWidget {
  const Exo2({super.key});

  @override
  State<Exo2> createState() => _Exo2State();
}

class _Exo2State extends State<Exo2> {
  double _scale = 1.0;
  double _rotationX = 0.0;
  double _rotationZ = 0.0;
  double _mirror = 1.0;
  bool _animate = false;
  Timer? _timer;
  bool animstateX = false;
  bool animstateZ = false;
  bool animstateSCALE = false;

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (animstateX == false) {
          _rotationX += 0.05;
          if (_rotationX >= 6.15) {
            animstateX = true;
          }
        } else {
          _rotationX -= 0.05;
          if (_rotationX <= 0.2) {
            animstateX = false;
          }
        }

        if (animstateZ == false) {
          _rotationZ += 0.12;
          if (_rotationZ >= 6.15) {
            animstateZ = true;
          }
        } else {
          _rotationZ -= 0.12;
          if (_rotationZ <= 0.2) {
            animstateZ = false;
          }
        }

        if (animstateSCALE == false) {
          _scale += 0.04;
          if (_scale >= 1.9) {
            animstateSCALE = true;
          }
        } else {
          _scale -= 0.04;
          if (_scale <= 0.6) {
            animstateSCALE = false;
          }
        }
      });
    });
  }

  void _stopAnimation() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transformer une image")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..scale(_scale * _mirror, _scale)
                  ..rotateX(_rotationX)
                  ..rotateZ(_rotationZ),
                child: Image.network('https://picsum.photos/1080/1920'
                    // width: 200,
                    // height: 200,
                    // fit: BoxFit.cover,
                    ),
              ),
            ),
          ),
          // Sliders
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Échelle : ${_scale.toStringAsFixed(2)}"),
                  Slider(
                    value: _scale,
                    min: 0.5,
                    max: 2.0,
                    onChanged: (value) {
                      setState(() {
                        _scale = value;
                      });
                    },
                  ),
                  Text("RotateX : ${_rotationX.toStringAsFixed(2)} rad"),
                  Slider(
                    value: _rotationX,
                    min: 0.0,
                    max: 6.28, // 2*PI pour une rotation complète
                    onChanged: (value) {
                      setState(() {
                        _rotationX = value;
                      });
                    },
                  ),
                  Text("RotateZ : ${_rotationZ.toStringAsFixed(2)} rad"),
                  Slider(
                    value: _rotationZ,
                    min: 0.0,
                    max: 6.28, // 2*PI pour une rotation complète
                    onChanged: (value) {
                      setState(() {
                        _rotationZ = value;
                      });
                    },
                  ),
                  Text("Effet miroir"),
                  Switch(
                    value: _mirror == -1,
                    onChanged: (value) {
                      setState(() {
                        _mirror = value ? -1.0 : 1.0;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_animate) {
                            _stopAnimation();
                          } else {
                            _startAnimation();
                          }
                          setState(() {
                            _animate = !_animate;
                          });
                        },
                        child: Text(
                            _animate ? "Stop Animation" : "Démarrer Animation"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
