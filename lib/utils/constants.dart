import 'package:flutter/cupertino.dart';
import 'package:morphable_shape/morphable_shape.dart';


ShapeBorder beveledRectangle = RectangleShapeBorder(
  borderRadius: DynamicBorderRadius.only(
    topLeft: DynamicRadius.circular(38.toPXLength)
  )
);

ShapeBorder rightBeveledRectangle = RectangleShapeBorder(
    borderRadius: DynamicBorderRadius.only(
       bottomRight: DynamicRadius.circular(38.toPXLength)
    )
);

const textFieldPadding =
EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10);

const String networkAddress = 'amrita-events-2022.herokuapp.com';
const bool isHTTPS = true;
const String storageJWTKey = "USER_AUTH_JWT";
const String nameKey = "USER_NAME";
const String roleKey = "USER_ROLE";
const String dateRegistered = "USER_REGISTER_DATE";
const String emailIdKey = "USER_EMAIL";
const String userIdKey = "USER_ID";
const user = "user";
const admin = "admin";
const superAdmin = "super_admin";
const eventOptions = ["ALL EVENTS", "CULTURAL", "TECHNICAL", "SPIRITUAL"];
//event types
const eventAdd = "event_add";
const eventModify = "event_modify";
const eventDelete = "event_delete";
const notification = "notification";