import 'package:flutter/foundation.dart';

import '../dbobj/dbobjs.dart';
import '../services/services.dart';

class ServiceProvider extends ChangeNotifier {
  LeadService? ls;
  FollowupService? fs;
  DealService? ds;
  PaymentService? ps;
  ProfileService? pros;
  EnqueryService? es;
  BusinessService? bs;

  List<Lead>? leads;
  List<Followup>? followups;
  List<Deal>? deals;
  List<Payment>? payments;
  Profile? profile;
  Business? business;

  ServiceProvider() {
    Future.delayed(Duration.zero, () {
      init();
    });
  }

  init() {
    getAllLeads();
    getAllFollowups();
    getAllDeals();
    getAllPayments();
    getProfile();
    getBusiness();
  }

  getAllLeads() {
    Future.delayed(Duration.zero, () {
      ls = LeadService();
      leads = ls!.getAll();
      notifyListeners();
    });
  }

  getLead(int index) {
    ls = LeadService();
    return ls!.get(index);
  }

  addLead(Lead lead) {
    ls = LeadService();
    ls!.add(lead);
    getAllLeads();
  }

  updateLead(Lead lead) {
    ls = LeadService();
    ls!.update(lead);
    getAllLeads();
  }

  deleteLead(int index) {
    ls = LeadService();
    ls!.delete(index);
    getAllLeads();
  }

  getAllFollowups() {
    Future.microtask(() {
      fs = FollowupService();
      followups = fs!.getAll().reversed.toList();
      notifyListeners();
    });
  }

  getFollowupByLead(String uid) {
    Future.microtask(() {
      fs = FollowupService();
      followups = fs!.getAll().where((e) => e.leadUid! == uid).toList();
      notifyListeners();
    });
  }

  getFollowup(int index) {
    fs = FollowupService();
    return fs!.get(index);
  }

  addFollowup(Followup followup) {
    fs = FollowupService();
    fs!.add(followup);
    // getFollowupByLead(followup.leadUid!);
    // getAllFollowups();
  }

  updateFollowup(Followup followup) {
    fs = FollowupService();
    fs!.update(followup);
    getFollowupByLead(followup.leadUid!);
    // getAllFollowups();
  }

  deleteFollowup(int index) {
    fs = FollowupService();
    fs!.delete(index);
    getFollowupByLead(fs!.get(index).leadUid!);
    // getAllFollowups();
  }

  getAllDeals() {
    Future.microtask(() {
      ds = DealService();
      deals = ds!.getAll().reversed.toList();
      notifyListeners();
    });
  }

  getDealsByLead(String uid) {
    Future.microtask(() {
      ds = DealService();
      deals = ds!.getAll().where((e) => e.leadUid! == uid).toList();
      notifyListeners();
    });
  }

  getAllPayments() {
    Future.microtask(() {
      ps = PaymentService();
      payments = ps!.getAll().reversed.toList();
      notifyListeners();
    });
  }

  getProfile() {
    Future.microtask(() {
      pros = ProfileService();
      if (pros!.getAll().isNotEmpty) profile = pros!.get(0);
      notifyListeners();
    });
  }

  getBusiness() {
    Future.microtask(() {
      bs = BusinessService();
      if (bs!.getAll().isNotEmpty) business = bs!.get(0);
      notifyListeners();
    });
  }
}
