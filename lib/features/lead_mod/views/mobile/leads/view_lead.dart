import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../dbobj/dbobjs.dart';
import '../../../lead_app.dart';
import '../../../providers/providers.dart';
import '../../../services/services.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ViewLeadForMobile extends StatefulWidget {
  const ViewLeadForMobile({Key? key}) : super(key: key);

  @override
  State<ViewLeadForMobile> createState() => _ViewLeadForMobileState();
}

class _ViewLeadForMobileState extends State<ViewLeadForMobile> {
  final GlobalKey<FormState> _followupFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> _dealFormState = GlobalKey<FormState>();
  String? discussion, status;
  List<Followup>? followups;
  List<Deal>? deals;
  Lead? lead;
  bool isForm = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  PageController pageController = PageController(initialPage: 0);
  double formHeight = 430;
  Deal ideal = Deal();
  int pageOffset = 0;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    var dlead = (ModalRoute.of(context)!.settings.arguments == null)
        ? Lead()
        : ModalRoute.of(context)!.settings.arguments! as Lead;

    ServiceProvider sp = context.read<ServiceProvider>();
    setState(() {
      lead = dlead;
      followups = lead!.followups ?? [];
      deals = lead!.deals ?? [];
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Nav.to(context, LeadApp.listLeads);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('View Lead'),
        actions: actionsMenu(context),
      ),
      bottomNavigationBar: LeadAppBottomBar(),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Stack(
              children: [
                leadInformation(context, lead!),
                Positioned(
                  right: 0,
                  child: ElevatedButton(
                    onPressed: () {
                      Nav.to(context, LeadApp.editLead, arguments: lead);
                    },
                    child: const Icon(
                      Icons.touch_app_sharp,
                    ),
                  ),
                ),
              ],
            ),
            pageTab(),
            tabViews(sp)
          ],
        ),
      ),
      floatingActionButton: floatingButton(context),
    );
  }

  Container pageTab() {
    return Container(
      color: Colors.teal.withOpacity(0.4),
      padding: const EdgeInsets.all(10),
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                child: Text(
                  'Activities',
                  style: TextStyle(
                    color: pageOffset == 0 ? Colors.green : null,
                  ),
                ),
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  setState(() {
                    pageOffset = 0;
                  });
                }),
          ),
          Expanded(
            child: ElevatedButton(
                child: Text(
                  'Deals',
                  style: TextStyle(
                    color: pageOffset == 1 ? Colors.green : null,
                  ),
                ),
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  setState(() {
                    pageOffset = 1;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Expanded tabViews(ServiceProvider sp) {
    return Expanded(
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: [
          (lead!.followups != null && lead!.followups!.isNotEmpty)
              ? followupTasks(lead!.followups ?? [])
              : const Center(
                  child: Text('No Followup / Task listed.'),
                ),
          (lead!.deals != null && lead!.deals!.isNotEmpty)
              ? allDeals(lead!.deals ?? [], sp)
              : const Center(
                  child: Text('No Deal / Proposal listed.'),
                ),
        ],
      ),
    );
  }

  SpeedDial floatingButton(BuildContext context) {
    return SpeedDial(icon: Icons.add_circle_outline, children: [
      SpeedDialChild(
          label: 'Add Followup',
          child: const Icon(Icons.task_alt),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => followupForm(),
            );
          }),
      SpeedDialChild(
          label: 'Add Deal',
          child: const Icon(Icons.note_add),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => dealForm(),
            );
          }),
    ]);
  }

  ListView followupTasks(List<Followup> followups) {
    return ListView.builder(
      itemCount: followups.length,
      itemBuilder: (context, index) {
        var dateTime =
            '${followups[index].schedule!.day}/${followups[index].schedule!.month}/${followups[index].schedule!.year} ${followups[index].schedule!.hour}:${followups[index].schedule!.minute}';

        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: ListTile(
            shape: Border.all(),
            title: Text(followups[index].status ?? 'none'),
            subtitle: Text(
              followups[index].discuss! + ' | ' + dateTime,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            leading: (followups[index].isDone == true)
                ? const Icon(
                    Icons.task_alt_sharp,
                    size: 36,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.not_interested_sharp,
                    size: 36,
                    color: Colors.orange,
                  ),
          ),
        );
      },
    );
  }

  ListView allDeals(List<Deal> deals, ServiceProvider sp) {
    return ListView.builder(
      itemCount: deals.length,
      itemBuilder: (context, index) {
        var dateTime =
            '${deals[index].createdAt!.day}/${deals[index].createdAt!.month}/${deals[index].createdAt!.year} ${deals[index].createdAt!.hour}:${deals[index].createdAt!.minute}';

        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: ListTile(
            shape: Border.all(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(deals[index].name!),
                Text(deals[index].price!.toString()),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deals[index].details!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dateTime),
                    StatusText(label: deals[index].status!),
                  ],
                )
              ],
            ),
            leading: const Icon(
              Icons.note_alt_outlined,
              size: 30,
            ),
          ),
        );
      },
    );
  }

  Form followupForm() {
    return Form(
      key: _followupFormState,
      child: SizedBox(
        height: isForm ? 370 : 300,
        width: double.infinity,
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Discuss Details',
              onTap: () {
                setState(() {
                  isForm = true;
                });
              },
              onSaved: (val) {
                setState(() {
                  isForm = false;
                });
              },
              onFieldSubmitted: (val) {
                setState(() {
                  isForm = false;
                });
              },
              validator: (val) {
                if (val!.isNotEmpty) {
                  discussion = val;
                  return null;
                }
                return 'Input Discussion Details';
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: SelectOptionField(
                    prefixIcon: Icons.water_drop_outlined,
                    labelTextStr: 'Lead Status',
                    options: const [
                      'Pending',
                      'Interested',
                      'Success',
                      'Rejected',
                      'Expired',
                    ],
                    selected: 'Pending',
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        status = val;
                        return null;
                      }
                      return 'Input Discussion Status';
                    },
                  ),
                ),
                Expanded(
                  child: SelectOptionField(
                    prefixIcon: Icons.water_drop_outlined,
                    labelTextStr: 'Task Status',
                    options: const [
                      'Done',
                      'Not Done',
                    ],
                    selected: 'Not Done',
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        isDone = (val == 'Done');
                        return null;
                      }
                      return 'Input Discussion Status';
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: DateInputField(
                    onDateChange: (date) => selectedDate = date,
                  ),
                ),
                Expanded(
                  child: TimeInputField(
                    onTimeChange: (time) => selectedTime = time,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Save Now',
                  onPressed: onFollowupSubmit,
                  stretch: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onFollowupSubmit() async {
    if (_followupFormState.currentState!.validate()) {
      setState(() {});
      // Leads Assign
      Lead ilead = lead!;
      ilead.status = status;

      // New Followup create
      Followup ifollowup = Followup();
      ifollowup.uid = uuid();
      ifollowup.discuss = discussion;
      ifollowup.status = status;
      ifollowup.leadUid = lead!.uid;

      ifollowup.schedule = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      ifollowup.isDone = isDone;

      // Box Initial
      FollowupService fs = FollowupService();
      fs.add(ifollowup);

      if (ilead.followups == null) {
        ilead.followups = HiveList(fs.box!);
        ilead.followups!.add(ifollowup);
      } else {
        ilead.followups!.add(ifollowup);
      }

      // Service Provider Initilized
      final sp = context.read<ServiceProvider>();
      // sp.updateLead(ilead);
      ilead.save();

      sp.getFollowupByLead(lead!.uid!);

      showMessage(context, 'New Taks is Added');

      Nav.close(context);
    }
  }

  Form dealForm() {
    return Form(
      key: _dealFormState,
      child: SizedBox(
        height: formHeight,
        width: double.infinity,
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Deal Name',
              validator: (val) {
                if (val!.isNotEmpty) {
                  ideal.name = val;
                  return null;
                }
                return 'Input Discussion Details';
              },
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Deal Deatils',
              maxLines: 3,
              textInputAction: TextInputAction.done,
              contentPadding: const EdgeInsets.all(9),
              onTap: () {
                setState(() {
                  formHeight = 450;
                });
              },
              onSaved: (val) {
                setState(() {
                  formHeight = formHeight;
                });
              },
              onFieldSubmitted: (val) {
                setState(() {
                  formHeight = formHeight;
                });
              },
              validator: (val) {
                if (val!.isNotEmpty) {
                  ideal.details = val;
                  return null;
                }
                return 'Input Deal Details';
              },
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Deal Amount',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              contentPadding: const EdgeInsets.all(9),
              onTap: () {
                setState(() {
                  formHeight = 650;
                });
              },
              onSaved: (val) {
                setState(() {
                  formHeight = formHeight;
                });
              },
              onFieldSubmitted: (val) {
                setState(() {
                  formHeight = formHeight;
                });
              },
              validator: (val) {
                if (val!.isNotEmpty) {
                  ideal.price = double.parse(val);
                  return null;
                }
                return 'Input Deal Amount';
              },
            ),
            SelectOptionField(
              prefixIcon: Icons.water_drop_outlined,
              labelTextStr: 'Status',
              options: const [
                'Pending',
                'Paid',
              ],
              selected: 'Pending',
              validator: (val) {
                if (val!.isNotEmpty) {
                  ideal.status = val;
                  return null;
                }
                return 'Input Discussion Status';
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: DateInputField(
                    onDateChange: (date) => selectedDate = date,
                  ),
                ),
                Expanded(
                  child: TimeInputField(
                    onTimeChange: (time) => selectedTime = time,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Save Now',
                  onPressed: onDealSubmit,
                  stretch: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onDealSubmit() {
    if (_dealFormState.currentState!.validate()) {
      setState(() {});

      // Init
      Lead ilead = lead!;
      Deal ndeal = ideal;
      DateTime createAt = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      ndeal.createdAt = createAt;
      ndeal.leadUid = lead!.uid;
      ndeal.uid = uuid();

      // Add Data in Box
      DealService ds = DealService();
      ds.add(ndeal);

      if (ilead.deals == null) {
        ilead.deals = HiveList(ds.box!);
        ilead.deals!.add(ndeal);
      } else {
        ilead.deals!.add(ndeal);
      }

      // Service Provider Initilized
      final sp = context.read<ServiceProvider>();
      // sp.updateLead(ilead);
      ilead.save();

      sp.getFollowupByLead(lead!.uid!);

      showMessage(context, 'New Deal is Added');

      Nav.close(context);
    }
  }

  Container leadInformation(BuildContext context, Lead lead) {
    var tp = Provider.of<ThemeProvider>(context);
    return Container(
      color: tp.isDarkMode == false
          ? Theme.of(context).primaryColorLight
          : Colors.black26,
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      height: 180,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                const Icon(
                  Icons.account_box_outlined,
                  size: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  lead.name ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                StatusText(
                  label: lead.status!,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                const Icon(
                  Icons.email,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  child: Text(
                    lead.email ?? 'no email',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    if (lead.email!.isNotEmpty) {
                      mailTo(lead.email!);
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                const Icon(
                  Icons.phone_android_outlined,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  child: Text(
                    lead.mobile ?? 'no number',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    if (lead.mobile!.isNotEmpty) {
                      makePhoneCall(lead.mobile!);
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Icon(
                  Icons.task_alt,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      lead.purpose ?? 'No Purpose',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Icon(
                  Icons.source_outlined,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      lead.source ?? 'Unknown Source',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
