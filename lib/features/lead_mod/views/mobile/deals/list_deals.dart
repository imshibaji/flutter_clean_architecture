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
  final PageController _controller = PageController();
  bool check = false;
  int pageIndex = 0;

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Nav.to(context, LeadApp.addDeal);
        },
        child: const Icon(Icons.insights_rounded),
      ),
    );
  }

  Column listItems(ServiceProvider sp) {
    return Column(
      children: [
        // searchBar(),
        Container(
          color: Colors.teal.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 3),
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: ChipButton(
                  label: 'All',
                  onPressed: () => _controller.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  ),
                  isHighlight: (pageIndex == 0),
                ),
              ),
              for (int i = 0; i < dealStatuses.length; i++)
                Expanded(
                  child: ChipButton(
                    label: dealStatuses[i],
                    onPressed: () => _controller.animateToPage(
                      (i + 1),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    ),
                    isHighlight: (pageIndex == (i + 1)),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: _controller,
            onPageChanged: (pIndex) {
              setState(() {
                pageIndex = pIndex;
              });
            },
            children: [
              allDeals(
                getFilterDatas(sp.deals ?? [], 'All') as List<Deal>,
                sp,
              ),
              for (String status in dealStatuses)
                allDeals(
                  getFilterDatas(sp.deals ?? [], status) as List<Deal>,
                  sp,
                  notFoundTxt: '$status deal list not found',
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget allDeals(
    List<Deal> deals,
    ServiceProvider sp, {
    String notFoundTxt = 'No Proposuls listed.',
  }) {
    List<Deal> allDeals = deals;

    return Container(
      child: allDeals.isNotEmpty
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
                      child: (deal.status != null &&
                              deal.status!.toLowerCase() == 'paid')
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invoice#' +
                                    (deal.key + 1).toString() +
                                    ' | At: ' +
                                    dateTime,
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 8),
                              ),
                              Text(
                                deal.name ?? 'No Name',
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          ((deal.price ?? 0) - (deal.discount ?? 0)).toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              (lead.name ?? 'No Name') + ' | ',
                              style: const TextStyle(fontSize: 10),
                            ),
                            const Text(
                              'Status: ',
                              style: TextStyle(fontSize: 10),
                            ),
                            StatusText(
                              label: deal.status ?? 'No Status',
                              size: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          (deal.details ?? 'No Details').substring(
                            0,
                            (deal.details!.length > 50)
                                ? 50
                                : deal.details!.length,
                          ),
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
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
          : Center(
              child: Text(notFoundTxt),
            ),
    );
  }
}
