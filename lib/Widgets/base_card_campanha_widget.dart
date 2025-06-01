import 'package:cached_network_image/cached_network_image.dart';
import 'package:cfc_vitoria_app/Dto/Response/Campanha/campanha_rdto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseCardCampanha extends StatelessWidget {
  const BaseCardCampanha({super.key, required this.campanha});

  final CampanhaRDTO campanha;

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Get.toNamed("/campanha", arguments: campanha);
      },
      child: Container(
        width: larguraTela,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.black12),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: campanha.pathImage,
              placeholder: (context, url) => Center(
                child: SizedBox(
                  width: 30, // ou o tamanho que preferir
                  height: 30,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2, // opcional: afina a linha
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}
