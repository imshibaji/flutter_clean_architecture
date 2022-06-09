import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../dbobj/dbobjs.dart';
import '../../../lead_app.dart';
import '../../../providers/providers.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ListDealForMobile extends StatefulWidget {
  const ListDealForMobile({Key? key}) : super(key: key);

  @override
  State<ListDealForMobile> createState() => _ListDealForMobileState();
}

class _ListDealForMobileState extends State<ListDealForMobile> {
  bool check = false;
  String status = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppIcon(),
        title: const Text('Proposals'),
        actions: actionsMenu(context),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, sp, child) => listItems(sp),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
    );
  }

  Column listItems(ServiceProvider sp) {
    return Column(
      children: [
        // searchBar(),
        Container(
          color: Colors.teal.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          height: 50,
          child: Row(
            children: [
              Expanded(
                child:
                    ChipButton(label: 'All', onPressed: () => setStatus('All')),
              ),
              for (String status in dealStatuses)
                Expanded(
                  child: ChipButton(
                    label: status,
                    onPressed: () => setStatus(status),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: allDeals(sp.deals!, sp),
        ),
      ],
    );
  }

  void setStatus(String stat) {
    setState(() {
      status = stat;
    });
  }

  Widget allDeals(List<Deal> deals, ServiceProvider sp) {
    List<Deal> allDeals = getFilterDatas(deals, status) as List<Deal>;

    return allDeals.isNotEmpty
        ? ListView.builder(
            itemCount: allDeals.length,
            itemBuilder: (context, index) {
              Deal deal = allDeals[index];
              Lead lead = sp.leads!.firstWhere(
                (element) => element.uid == deal.leadUid,
              );

              var dateTime = '${deal.createdAt!.day}/'
                  '${deal.createdAt!.month}/'
                  '${deal.createdAt!.year} '
                  '${deal.createdAt!.hour}:'
                  '${deal.createdAt!.minute}';

              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: ListTile(
                  shape: Border.all(),
                  onLongPress: () {
                    Nav.to(context, LeadApp.viewLead, arguments: lead);
                  },
                  leading: InkWell(
                    child: (deal.status!.toLowerCase() == 'paid')
                        ? const Icon(
                            Icons.check_box_outlined,
                            size: 40,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank_outlined,
                            size: 40,
                            color: Colors.orange,
                          ),
                    onTap: () {
                      Nav.to(context, LeadApp.viewLead, arguments: lead);
                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          deal.name!,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Text(deal.price!.toString()),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deal.details!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(lead.name! + ' | ' + dateTime),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Status: '),
                          StatusText(label: deal.status!),
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    showDealBottomMenu(
                      context,
                      deal,
                      sp,
                      onDeal: (deal) {
                        setState(() {
                          check = (deal.status!.toLowerCase() == 'paid');
                        });
                      },
                    );
                  },
                  trailing: InkWell(
                    onTap: () {
                      Nav.to(context, LeadApp.printDeal, arguments: deal);
                    },
                    child: const Icon(
                      Icons.print_outlined,
                      size: 40,
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Text('No Proposuls listed.'),
          );
  }
}
