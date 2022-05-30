import 'package:flutter/material.dart';
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
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String? discussion, status;
  List<Followup>? followups = [];
  Lead? lead;
  bool isForm = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    var dlead = (ModalRoute.of(context)!.settings.arguments == null)
        ? Lead()
        : ModalRoute.of(context)!.settings.arguments! as Lead;

    ServiceProvider sp = context.read<ServiceProvider>();
    setState(() {
      lead = sp.leads!.firstWhere((element) => element.uid == dlead.uid);
      followups = lead!.followups ?? [];
    });

    // print(lead!.followups);

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
      body: Column(
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
          followupTasks(lead!.followups ?? []),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => followupForm(),
          );
        },
        child: const Icon(Icons.add_task_sharp),
      ),
    );
  }

  Expanded followupTasks(List<Followup> followups) {
    return Expanded(
      child: ListView.builder(
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
              leading: const Icon(
                Icons.task_alt,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }

  Form followupForm() {
    return Form(
      key: _formState,
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
            SelectOptionField(
              prefixIcon: Icons.water_drop_outlined,
              labelTextStr: 'Status',
              options: const [
                'pending',
                'processing',
                'success',
                'rejected',
                'expired',
              ],
              selected: 'pending',
              validator: (val) {
                if (val!.isNotEmpty) {
                  status = val;
                  return null;
                }
                return 'Input Discussion Status';
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final datePicked = await selectDate(context);
                      if (datePicked.toString() != selectedDate.toString()) {
                        setState(() {
                          selectedDate = datePicked;
                        });
                      }
                    },
                    child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final timePicked = await selectTime(context);
                      if (timePicked.toString() != selectedDate.toString()) {
                        setState(() {
                          selectedTime = timePicked;
                        });
                      }
                    },
                    child: Text('${selectedTime.hour}:${selectedTime.minute}'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  label: 'Save Now',
                  onPressed: onSubmit,
                  stretch: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onSubmit() async {
    if (_formState.currentState!.validate()) {
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
      ServiceProvider sp = ServiceProvider();
      sp.updateLead(ilead);

      sp.getFollowupByLead(lead!.uid!);

      showMessage(context, 'New Taks is Added');

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
      height: 200,
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
