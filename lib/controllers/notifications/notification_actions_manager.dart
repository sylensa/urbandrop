import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:urbandrop/core/helper/helper.dart';


class NotificationsActionsManager {
  static NotificationsActionsManager? instance;
  late BuildContext _ctx;

  NotificationsActionsManager(BuildContext ctx) {
    _ctx = ctx;
  }
  static getInstance(BuildContext ctx) {
    instance ??= NotificationsActionsManager(ctx);

    return instance;
  }

  Future performActionOnly(String? action) => performAction(varag: {"action": action});

  Future performAction({required Map<String, dynamic> varag}) async {
    Widget? pageToGo;
    final action = varag['type'] ?? 'none';
    final payload = varag['payload'];

    // final meta = varag['meta'];

    debugPrint("Perform Action ==> $action");

    //Todo replace param varag with entity value from api


    switch (action) {
      case NotificationActions.FOLLOWING:
      case NotificationActions.CARD_WATCH:
      case NotificationActions.CARD_SALE:
      case NotificationActions.CARD_PURCHASE:
        log("payload:${varag['payload']}");
        log("user:${jsonDecode(payload)}");
        var decodedPayload = jsonDecode(payload);
        log("decodedPayload:${decodedPayload}");

        break;

      case NotificationActions.GENERAL:

        break;


      case NotificationActions.NEW_MESSAGE:

        break;

      case NotificationActions.CHAT:

        break;

      case NotificationActions.TRADEREQUEST:
      case NotificationActions.TRADEACCEEPT:
      case NotificationActions.TRADEDECLINE:

      break;

      case NotificationActions.ACTIVITYWATCH:

        break;

      case NotificationActions.TRANSACTIONS:
        break;

      case NotificationActions.DIVIDEND:
      case NotificationActions.WITHDRAWALSTATUS:
        break;

      case NotificationActions.FORCE_UPDATE:

        break;
    }

    if (pageToGo != null) goTo(_ctx, pageToGo);

  }
}

class NotificationActions {
  static const FOLLOWING = "following";
  static const CARD_WATCH = "card_watch";
  static const CARD_PURCHASE = "card_purchase";
  static const CARD_SALE = "card_sale";
  static const GENERAL = "general";
  static const CHAT = "chat";
  static const NEW_MESSAGE = "new_message";
  static const TRADEREQUEST = "trade_request";
  static const TRADEDECLINE = "trade_declined";
  static const TRADEACCEEPT = "trade_accepted";
  static const ACTIVITYWATCH = "activity_watch";
  static const TRANSACTIONS = "transaction";
  static const DIVIDEND = "dividend";
  static const WITHDRAWALSTATUS = "withdrawal_status";

  static const FORCE_UPDATE = "force_update";
}
class NotificationTypes {
  static const GENERAL_WITH_ACTION = 'general_requires_action';
  static const GENERAL = 'general';
}
