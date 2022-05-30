import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/app_theme.dart';
import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../lead_app.dart';
import '../../../models/enquery_get_models.dart';
import '../../../services/services.dart';
import '../../../utils/utils.dart';
import '../../../widgets/button_bar.dart';

class ViewEnqueryForMobile extends StatefulWidget {
  const ViewEnqueryForMobile({Key? key}) : super(key: key);

  @override
  State<ViewEnqueryForMobile> createState() => _ViewEnqueryForMobileState();
}

class _ViewEnqueryForMobileState extends State<ViewEnqueryForMobile> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String? discussion, status;
  List<Followup>? followups;
  List<Map<String, dynamic>>? addFollowups;
  EnqueryData? ed;
  Lead? lead;

  @override
  Widget build(BuildContext context) {
    ed = (ModalRoute.of(context)!.settings.arguments == null)
        ? EnqueryData()
        : ModalRoute.of(context)!.settings.arguments! as EnqueryData;

    setState(() {
      lead = ed!.attributes!;
      followups = lead!.followup;
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Nav.to(context, LeadApp.home);
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
                    Nav.to(context, LeadApp.editEnquery, arguments: ed);
                  },
                  child: const Icon(
                    Icons.touch_app_sharp,
                  ),
                ),
              ),
            ],
          ),
          followupTasks(lead!.followup!),
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
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListTile(
          shape: Border.all(),
          title: Text(followups[index].status ?? 'none'),
          subtitle: Text(
            followups[index].discuss_details ?? 'No Details',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          leading: const Icon(
            Icons.task_alt,
            size: 30,
          ),
        ),
      ),
    ));
  }

  Form followupForm() {
    return Form(
      key: _formState,
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextInputField(
              prefixIcon: Icons.edit_note,
              labelTextStr: 'Discuss Details',
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
              children: [
                AppButton(
                  label: 'Save Now',
                  onPressed: () async {
                    if (_formState.currentState!.validate()) {
                      setState(() {
                        followups!.add(Followup(
                          discuss_details: discussion,
                          status: status,
                        ));
                        addFollowups = followups!
                            .map((e) => {
                                  'discuss_details': e.discuss_details ?? '',
                                  'status': e.status ?? 'pending',
                                })
                            .toList();
                      });
                      EnqueryService es = EnqueryService();
                      var res = await es.addFollowup(
                        ed!.id!.toInt(),
                        lead!,
                        addFollowups!,
                      );
                      if (res != null) {
                        showMessage(context, 'New Taks is Added');
                        Nav.close(context);
                      }
                    }
                  },
                  stretch: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
                  lead.customer_name ?? 'No Name',
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
                    lead.customer_email ?? 'no email',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    if (lead.customer_email!.isNotEmpty) {
                      mailTo(lead.customer_email!);
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
                    lead.customer_mobile ?? 'no number',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    if (lead.customer_mobile!.isNotEmpty) {
                      makePhoneCall(lead.customer_mobile!);
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
