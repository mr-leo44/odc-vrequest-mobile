import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_async_autocomplete/flutter_async_autocomplete.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

import '../../api/api_autocomplete_open_map_street.dart';
import '../../business/model/Site.dart';

class MyListTile extends StatefulWidget {
  Demande demande;

  MyListTile({Key? key, required this.demande}) : super(key: key);

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    var demande = widget.demande;
    return SizedBox(
      height: 100,
      child: Card(
        shadowColor: Colors.black,
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.assignment_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              demande.motif,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(_getStatus(demande.status),
                                style: TextStyle(
                                    color: _getStatusColor(demande.status))),
                            Text(
                               "Date et heure  du déplacement : ${ DateFormat('dd/MM/yyyy - HH:mm')
                                   .format(demande.dateDeplacement)}",
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 30,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          onTap: () {
            context.pushNamed(Urls.detailsDemande.name,
                extra: demande.id,
                pathParameters: {"id": demande.id.toString()});
          },
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    print(status.toLowerCase());
    switch (status.toLowerCase()) {
      case ' en attente':
        return Colors.orange;
      case 'achevé':
        return Colors.green;
      case 'raté':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatus(String status) {
    switch (status.toLowerCase()) {
      case '0':
        return "En attente";
      case '1':
        return "Traitée";
      default:
        return 'En attente';
    }
  }
}
