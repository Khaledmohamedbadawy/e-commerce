import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/Screens/admin/addproduct.dart';
import 'package:commerce/Screens/admin/editproduct.dart';
import 'package:commerce/Screens/models/product.dart';
import 'package:commerce/widgets/constants.dart';
class store {
final FirebaseFirestore _firestore =FirebaseFirestore.instance;
addproduct(Product product){
_firestore.collection(kproductcollection).add(
    {
      kproductname : product.pname,
      kproductprice : product.pprice,
      kproductdescription : product.pdescribtion,
      kproductlocation : product.plocation,
      kproductcategory : product.pcategory

});
}
Stream<QuerySnapshot> loadproduct() {
  return _firestore.collection(kproductcollection).snapshots();
}
Stream<QuerySnapshot> loadOrders() {
  return _firestore.collection(kOrders).snapshots();
}

Stream<QuerySnapshot> loadOrderDetails(documentId) {
  return _firestore
      .collection(kOrders)
      .doc(documentId)
      .collection(kOrderDetails)
      .snapshots();
}


deleteproduct(docoumentId){
     _firestore.collection(kproductcollection).doc(docoumentId).delete();
}
editproduct(data,documentId){
  _firestore.collection(kproductcollection).doc(documentId).update(data);
}

storeOrders(data, List<Product> products) {
  var documentRef = _firestore.collection(kOrders).doc();
  documentRef.set(data);
  for (var product in products) {
    documentRef.collection(kOrderDetails).doc().set({
      kproductname: product.pname,
      kproductprice: product.pprice,
      kProductQuantity: product.pquantity,
      kproductlocation: product.plocation,
      kproductcategory: product.pcategory
    });
  }
}

}