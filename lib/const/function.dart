import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../page/loginout/loginpage.dart';
import '../service/bookmarksprovider.dart';
import 'fontstyle.dart';
import 'globalcolors.dart';

class GlobalMethod {
  static final auth = FirebaseAuth.instance;
  static final firebasedatabase = FirebaseFirestore.instance.collection('News');
  

  static googleSignUp() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await auth.signInWithCredential(credential)).user;

      return user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static deletebooks(String id, BuildContext context) {
     final newsProvider = Provider.of<BookmarksProvider>(context, listen: false);
    newsProvider.delete(publishedAt: id);
    GlobalMethod.toastMessage("Delete Sucessfully");
    Navigator.pop(context);
  }

  static Future<void> logOutDialog(
      {required BuildContext context, bool isDelete = false, String? id}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isDelete == true
              ? Row(
                  children: [
                    const Text('Delete'),
                    Icon(
                      Icons.delete,
                      color: GlobalColors.red,
                    ),
                  ],
                )
              : const Text('Logout'),
          content: isDelete == true
              ? const Text('Are you want to Delete this Bookmarks Item')
              : const Text('Are you want to login in this App'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: GlobalColors.red,
                textStyle: tabLabelStyle,
              ),
              child: const Text('Yes'),
              onPressed: () {
                isDelete == true
                    ? deletebooks(id!, context)
                    : auth.signOut().then((value) {
                        Navigator.pushNamed(context, LoginPage.routeName);
                        GlobalMethod.toastMessage("Logout Sucessfully");
                      }).onError((error, stackTrace) {});
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: GlobalColors.red, textStyle: tabLabelStyle),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static String formattedDatText(String publishArt) {
    DateTime pareseData = DateTime.parse(publishArt);
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(pareseData);
    DateTime publishDate =
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(formattedDate);
    return "${publishDate.day}/${publishDate.month}/${publishDate.year} on ${publishDate.hour}:${publishDate.minute}";
  }

  static ElevatedButton paginationButton(
      {required Function function, required String text}) {
    return ElevatedButton(
        onPressed: () {
          function();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalColors.deepred,
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(textStyle: tabLabelStyle),
        ));
  }

  static Column errorMethod({required String error}) {
    return Column(
      children: [
        Flexible(
          flex: 7,
          child: Image.asset(
            "asset/image/nonewsitemfound.png",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          flex: 3,
          child: Text(
            error,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: GlobalColors.red,
                    fontSize: 16,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    );
  }

  static Container applogo() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: GlobalColors.white,
          border: Border.all(color: GlobalColors.red, width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("JU",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: GlobalColors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w900))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                color: GlobalColors.red,
                borderRadius: BorderRadius.circular(1)),
            child: Text("News",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: GlobalColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600))),
          )
        ],
      ),
    );
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, gravity: ToastGravity.BOTTOM, fontSize: 16.0, backgroundColor: GlobalColors.red, textColor: Colors.white);
  }

  static Future<void> errorDialog(
      {required String errorMessage, required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(errorMessage),
          title: Row(
            children: const [
              Icon(
                IconlyBold.danger,
                color: Colors.red,
              ),
              SizedBox(
                width: 8,
              ),
              Text('An error occured'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
