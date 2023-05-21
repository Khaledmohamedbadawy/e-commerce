import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/constants.dart';

class sto {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  deleteoredr(docoumentId) {
    _firestore.collection(koredercollection).doc(docoumentId).delete();
  }

}