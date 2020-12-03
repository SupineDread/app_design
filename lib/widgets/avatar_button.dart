import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize;

  const AvatarButton({Key key, this.imageSize = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.black26,
              offset: Offset(0, 20),
            )
          ]),
          child: ClipOval(
            child: Image.network(
              'https://asadahorquetas.com/wp-content/uploads/2018/07/img_avatar.png',
              width: this.imageSize,
              height: this.imageSize,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
