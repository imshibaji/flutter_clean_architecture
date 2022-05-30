import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../lead_mod.dart';

class ListEnqueryController extends StatelessController {
  const ListEnqueryController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    var ep = context.read<EnqueryProvider>();
    ep.setEnquery();
    return Display(
      title: 'Enqueries / Lead',
      mobile: const ListEnqueryForMobile(),
    );
  }
}
