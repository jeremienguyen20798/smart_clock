import 'package:flutter/material.dart';

class RingtoneBottomsheet extends StatelessWidget {
  const RingtoneBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Nhạc chuông',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.grey.shade300)),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                )),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 50,
              itemBuilder: (context, index) => ListTile(
                horizontalTitleGap: 16.0,
                leading: Text((index + 1).toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    )),
                title: Text(
                  'Nhạc chuông ${index + 1}',
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16.0),
                ),
                subtitle: const Text(
                  '01:34',
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notification_add,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
