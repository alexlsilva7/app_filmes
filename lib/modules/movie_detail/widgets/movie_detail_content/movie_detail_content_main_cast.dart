import 'package:app_filmes/application/ui/theme_extension.dart';
import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:app_filmes/modules/movie_detail/widgets/movie_detail_content/movie_cast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailContentMainCast extends StatelessWidget {
  final MovieDetailModel? movie;

  final showPanel = false.obs;

  MovieDetailContentMainCast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: context.colorGrey,
        ),
        Obx(() {
          return ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                showPanel.toggle();
              },
              elevation: 0,
              expandedHeaderPadding: EdgeInsets.zero,
              children: [
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: showPanel.value,
                  backgroundColor: Colors.white,
                  headerBuilder: (ctx, isExpanded) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Elenco',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                  body: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          movie?.cast.map((c) => MovieCast(cast: c)).toList() ??
                              [],
                    ),
                  ),
                ),
              ]);
        })
      ],
    );
  }
}
