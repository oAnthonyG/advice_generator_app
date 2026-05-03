import 'package:advice_generator_app/models/advice_controller.dart';
import 'package:advice_generator_app/services/advice_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdviceScree extends StatefulWidget {
  const AdviceScree({super.key});

  @override
  State<AdviceScree> createState() => _AdviceScreeState();
}

class _AdviceScreeState extends State<AdviceScree> {
  final AdviceService _service = AdviceService();

  AdviceController? _advice;
  bool _loading = false;

  void _getAdvice() async {
    setState(() => _loading = true);

    try {
      final newAdvice = await _service.searchNewAdvice();
      setState(() => _advice = newAdvice);
    } catch (e) {
      return;
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(31, 38, 50, 1),
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 375),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 300,
              decoration: BoxDecoration(
                color: Color.fromRGBO(50, 58, 73, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: _loading
                      ? const CircularProgressIndicator()
                      : _advice == null
                      ? const Text(
                          'Click to start!',
                          style: TextStyle(color: Colors.white),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ADVICE #${_advice!.id}',
                              style: TextStyle(
                                color: Color.fromRGBO(82, 255, 168, 1),
                                letterSpacing: 3,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '"${_advice!.advice}"',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromRGBO(206, 227, 233, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 15,
                              child: SvgPicture.asset(
                                'images/pattern-divider-mobile.svg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            Positioned(
              bottom: -30,
              child: Material(
                shape: CircleBorder(),
                child: InkWell(
                  onTap: _getAdvice,
                  customBorder: CircleBorder(),
                  child: Ink(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(82, 255, 168, 1),
                    ),
                    padding: EdgeInsets.all(18),
                    child: SvgPicture.asset('images/icon-dice.svg', width: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
