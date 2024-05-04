

//class OrderRepository {
//
//  Future<void> addOrder(Map<String, dynamic> data) async {
//    await _firestoreService.collection('orders').add(data);
//  }
//
//  Future<void> updateOrder(String id, Map<String, dynamic> data) async {
//    await _firestoreService.collection('orders').doc(id).update(data);
//  }
//
//  Future<void> deleteOrder(String id) async {
//    await _firestoreService.collection('orders').doc(id).delete();
//  }
//
//  Future<List<Map<String, dynamic>>> fetchData() async {
//    final snapshot = await _firestoreService.collection('orders').get();
//    return snapshot.docs.map((doc) => doc.data()).toList();
//  }
//
//  Future<Map<String, dynamic>> getDataById(String id) async {
//    final snapshot = await _firestoreService.collection('orders').doc(id).get();
//    return snapshot.data()!;
//  }
//
//  Future<List<Map<String, dynamic>>> fetchDataByUserId(String userId) async {
//    final snapshot = await _firestoreService.collection('orders').where('userId', isEqualTo: userId).get();
//    return snapshot.docs.map((doc) => doc.data()).toList();
//  }
//
//  Future<List<Map<String, dynamic>>> fetchDataByStatus(String status) async {
//    final snapshot = await _firestoreService.collection('orders').where('status', isEqualTo: status).get();
//    return snapshot.docs.map((doc) => doc.data()).toList();
//  }
//
//  Future<List<Map<String, dynamic>>> fetchDataByDate(DateTime date) async {
//    final snapshot = await _firestoreService.collection('orders').where('date', isEqualTo: date).get();
//    return snapshot.docs.map((doc) => doc.data()).toList();
//  }
//
//  Future<List<Map<String, dynamic>>> fetchDataByUserIdAndStatus(String userId, String status) async {
//    final snapshot = await _firestoreService.collection('orders').where('userId', isEqualTo: userId).where('status', isEqualTo: status).get();
//    return snapshot.docs.map((doc) => doc.data()).toList();
//  }
//
//  Future<List<Map<String, dynamic>>> fetchDataByUserIdAndDate(String userId, DateTime date) async {
//    final snapshot = await _firestoreService.collection('orders').where('userId', isEqualTo: userId).where('date', isEqualTo: date).get();
//    return snapshot.docs.map((doc) => doc.data()).toList();
//  }
//
//
//
//
//}