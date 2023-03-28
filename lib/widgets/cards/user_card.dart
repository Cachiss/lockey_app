import 'package:flutter/material.dart';

class CardUser extends StatelessWidget {
  final String email;
  final String? photo;
  const CardUser({super.key, required this.email, this.photo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: photo != null
                        ? NetworkImage(photo!)
                        : NetworkImage(
                            "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    email,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
/*                 const Text(
                  "Ver perfil",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ), */
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
