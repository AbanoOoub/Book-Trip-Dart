import 'package:dart_project/modules/customer.dart';
class Trip {
  int trip_id;
  String trip_location;
  int trip_limit;
  String date;
  double trip_price;
  List<customer> Custs = new List<customer>();

  Trip(this.trip_id, this.trip_location, this.trip_limit, this.date, this.trip_price);

}