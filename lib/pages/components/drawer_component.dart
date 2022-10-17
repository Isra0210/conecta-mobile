import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/login_presenter.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ILoginPresenter loginPresenter = Get.find<ILoginPresenter>();

    return Drawer(
      child: Container(
        margin: const EdgeInsets.only(top: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  onTap: () {
                    loginPresenter.signOut();
                  },
                  title: const Text('Sair'),
                  trailing: const Icon(
                    Icons.logout,
                    color: Color(0XFF1e224c),
                  ),
                ),
              ],
            ),
            Container(
              color: const Color(0XFF1e224c),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Row(
                  children: const [
                    Icon(Icons.copyright, color: Colors.white, size: 16),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Conect Mais PG, todos direitos reservados',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
