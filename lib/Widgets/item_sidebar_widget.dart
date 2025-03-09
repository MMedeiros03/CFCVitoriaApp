import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';

class ItemSideBarMenu extends StatefulWidget {
  const ItemSideBarMenu({
    super.key,
    required this.icon,
    required this.title,
    required this.path,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String path;
  final String title;
  final bool selected;
  final Function onTap;

  @override
  ItemSideBarMenuState createState() => ItemSideBarMenuState();
}

class ItemSideBarMenuState extends State<ItemSideBarMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.selected ? const Color(0x4AFF7700) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
          onTap: () {
            widget.onTap(widget.path);
          },
          title: Row(
            children: [
              Icon(
                widget.icon,
                color: widget.selected
                    ? Color.fromARGB(255, 209, 98, 0)
                    : Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              BaseText(
                text: widget.title,
                size: 13,
                color: widget.selected
                    ? Color.fromARGB(255, 209, 98, 0)
                    : Colors.black,
              )
            ],
          )),
    );
  }
}
