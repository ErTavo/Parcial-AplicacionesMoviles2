import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget{
  final Widget child;

  const AuthBackground({
    Key? key,
    required this.child
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    //Box
    //Header
    return SizedBox(
      width:  double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurPleBox(),
          _HeaderIcon(),
          child
        ]
       
      )
    );
  }

}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      width: double.infinity,
      margin:  const EdgeInsets.only(top :30),
      child: const Icon(Icons.person_pin, color: Colors.white, size: 100),
    ));
  }
}

class _PurPleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      width:  double.infinity,
      height: size.height *.4,
      decoration: _pupleBackground(),
      child: Stack(
        children: [
          Positioned(top: 90, left:30, child: _Buble()),
          Positioned(top: -40, left:-30, child: _Buble()),
          Positioned(top: -50, left:-20, child: _Buble()),
          Positioned(top: -70, left:-25, child: _Buble()),
          Positioned(top: -80, left:20, child: _Buble()),
          Positioned(top: -10, left:10, child: _Buble())
        ],
      )
    );
  }
  BoxDecoration _pupleBackground() => const BoxDecoration(
    gradient:  LinearGradient(
      colors: [
        Color.fromRGBO(102, 51, 153, 1),
        Color.fromRGBO(90, 70, 178, 1),
      ])
  );
}

class _Buble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:100,
      height:100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255,255,255,0.05)
      ),
    );
  }

}

