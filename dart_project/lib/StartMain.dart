import 'dart:io';

import 'package:dart_project/modules/customer.dart';
import 'package:dart_project/modules/trip.dart';

List<Trip> Trips = new List<Trip>();
int Trip_ID;
int Cust_ID;
String Cust_name;
bool isback = false;

void main() {
  init();

  print("Welcome To My Travel Agency ^-^");

  while (true) {
    print(" _______________________");
    print("| (a) Admin             |");
    print("| (c) Customer          |");
    print("| (e) Exit              |");
    print(" _______________________");
    String input = stdin.readLineSync();
    //Admin
    if (input == "a") {
      print("Enter Password:");
      String pass = stdin.readLineSync();
      while (true) {
        if (pass == "0000") {
          print(" _______________________");
          print("| (1) Add Trip          |");
          print("| (2) Edit Trip         |");
          print("| (3) Delete Trip       |");
          print("| (4) View Trips        |");
          print("| (5) Search Trip       |");
          print("| (6) View Passengers   |");
          print("| (7) View Last Trips   |");
          print("| (*) Back              |");
          print(" _______________________");
          String choice = stdin.readLineSync();
          switch (choice[0]) {
            case "1":
              addTrip(Trip_ID);
              break;
            case "2":
              print("Enter Trip ID");
              int inputId = int.parse(stdin.readLineSync());
              editTrip(inputId);
              break;
            case "3":
              print("Enter Trip ID");
              int inputId = int.parse(stdin.readLineSync());
              deleteTrip(inputId);
              break;
            case "4":
              viewTrips();
              break;
            case "5":
              print("Enter Trip Price");
              double inputprice = double.parse(stdin.readLineSync());
              searchByPrice(inputprice);
              break;
            case "6":
              viewPassengers();
              break;
            case "7":
              latestTripsAdded();
              break;
            case "*":
              isback = true;
              break;
            default:
              print("Wrong choice");
              break;
          }
        } else {
          print("Wrong Password");
          break;
        }
        if (isback) {
          isback = false;
          break;
        }
      }
    }
    //Customer
    else if (input == "c") {
      Cust_ID++;
      print("Enter Your Name");
      Cust_name = stdin.readLineSync();
      print("Welcome " +
          Cust_name +
          ", Your ID is " +
          Cust_ID.toString() +
          " How can I help you ?");

      while (true) {
        print("_______________________");
        print("| (1) View Trips       |");
        print("| (2) Search Trip      |");
        print("| (3) Reverse Trip     |");
        print("| (4) Your Last Trips  |");
        print("| (*) Back             |");
        print(" _______________________");
        String choice = stdin.readLineSync();
        switch (choice[0]) {
          case "1":
            viewTrips();
            break;
          case "2":
            print("Enter Trip Price");
            double inputprice = double.parse(stdin.readLineSync());
            searchByPrice(inputprice);
            break;
          case "3":
            print("Enter Trip ID");
            int inputid = int.parse(stdin.readLineSync());
            reserveTrip(inputid);
            break;
          case "4":
            latestTripsForCust(Cust_ID);
            break;
          case "*":
            isback = true;
            break;
          default:
            print("Wrong choice");
            break;
        }
        if (isback) {
          isback = false;
          break;
        }
      }
    }
    //Exist
    else if (input == "e") {
      break;
    } else {
      print("Wrong choice!");
    }
  }
}

void addTrip(int id) {
  print("Enter Trip Location");
  String location = stdin.readLineSync();
  print("Enter Passengers limit");
  int limit = int.parse(stdin.readLineSync());
  print("Enter Trip Date");
  DateTime now = DateTime.now();
  String date = stdin.readLineSync();
  print("Enter Trip Price");
  double price = double.parse(stdin.readLineSync());
  Trips.add(new Trip(id, location, limit, date, price));

  print("Trip Added Successfully");
  Trip_ID++;
}

void editTrip(int id) {
  Trip curr_Trip;
  bool found = false;
  for (int i = 0; i < Trips.length; i++) {
    if (Trips[i].trip_id == id) {
      curr_Trip = Trips.elementAt(i);
      found = true;
    }
  }
  if (found) {
    found = false;
    print("Trip ID:" + curr_Trip.trip_id.toString());
    print(" ______________________________________");
    print("| (1) Edit Trip Location:" + curr_Trip.trip_location);
    print("| (2) Edit Trip Limits:" + curr_Trip.trip_limit.toString());
    print("| (3) Edit Trip Date:" + curr_Trip.date);
    print("| (4) Edit Trip Price:" + curr_Trip.trip_price.toString());
    print(" ______________________________________");

    int editnum = int.parse(stdin.readLineSync());
    switch (editnum) {
      case 1:
        print("Enter New Trip Location:");
        String newloc = stdin.readLineSync();
        curr_Trip.trip_location = newloc;
        print("Location Updated");
        break;
      case 2:
        print("Enter New Trip Limits:");
        int newlim = int.parse(stdin.readLineSync());
        if (newlim < curr_Trip.Custs.length) {
          print("This trip's limit can't be less than " +
              curr_Trip.Custs.length.toString());
        } else {
          curr_Trip.trip_limit = newlim;
          print("Limit Updated");
        }
        break;
      case 3:
        print("Enter New Trip Date:");
        String newdate = stdin.readLineSync();
        curr_Trip.date = newdate;
        print("Date Updated");
        break;
      case 4:
        print("Enter New Trip Price:");
        double newprice = double.parse(stdin.readLineSync());
        curr_Trip.trip_price = newprice;
        print("Price Updated");
        break;
      default:
        print("Wrong choice");
        break;
    }
  } else {
    print("This Trip ID not Exist");
  }
}

void deleteTrip(int id) {
  if (id < Trip_ID) {
    for (int i = 0; i < Trips.length; i++) {
      if (Trips[i].trip_id == id) {
        Trips.removeAt(i);
        print("Trip Deleted");
      }
    }
  } else {
    print("This TripID Not Exist");
  }
}

void viewTrips() {
  Trips.sort((a, b) => a.date.compareTo(b.date));
  for (int i = 0; i < Trips.length; i++) {
    print("Trip ID:" + Trips[i].trip_id.toString());
    print("Trip Location:" + Trips[i].trip_location);
    print("Trip Limits:" + Trips[i].trip_limit.toString());
    print("Trip Date:" + Trips[i].date);
    if (Trips[i].trip_price > 10000) {
      double newprice = discount(Trips[i].trip_price);
      print("Trip Price:" +
          Trips[i].trip_price.toString() +
          " After Discount:" +
          newprice.toString());
    } else {
      print("Trip Price:" + Trips[i].trip_price.toString());
    }
    print("****************************************************");
  }
}

void searchByPrice(double price) {
  bool found = false;
  for (int i = 0; i < Trips.length; i++) {
    if (Trips[i].trip_price == price) {
      found = true;
      print("Trip ID:" + Trips[i].trip_id.toString());
      print("Trip Location:" + Trips[i].trip_location);
      print("Trip Limits:" + Trips[i].trip_limit.toString());
      print("Trip Date:" + Trips[i].date);
      print("Trip Price:" + Trips[i].trip_price.toString());
      print("****************************************************");
    }
  }
  if (!found) {
    print("This Price not in our trips");
  }
}

double discount(double oldprice) {
  double newprice = oldprice - (oldprice * 0.2);
  return newprice;
}

void reserveTrip(int tripid) {
  bool isbooked = isTripBooked(tripid);
  if (!isbooked) {
    bool found = false;
    customer newcust = new customer(Cust_ID, Cust_name);
    for (int i = 0; i < Trips.length; i++) {
      if (Trips[i].trip_id == tripid) {
        found = true;
        if (Trips[i].trip_limit > Trips[i].Custs.length) {
          Trips[i].Custs.add(newcust);
          print("Booked Successfully");
          break;
        } else {
          print("This Trip is Full");
          break;
        }
      }
    }
    if (!found) print("This Trip ID not Exists");
  } else {
    print("You already Booked this Trip");
  }
}

bool isTripBooked(int id) {
  for (int i = 0; i < Trips.length; i++) {
    if (Trips[i].trip_id == id) {
      for (int j = 0; j < Trips[i].Custs.length; j++) {
        if (Trips[i].Custs[j].custID == (Cust_ID)) {
          return true;
        }
      }
    }
  }
  return false;
}

void latestTripsForCust(int custid) {
  int count = 0;
  bool found = false;
  for (int i = 0; i < Trips.length; i++) {
    for (int j = 0; j < Trips[i].Custs.length; j++) {
      if (Trips[i].Custs[j].custID == custid) {
        if (custid == (Cust_ID) && count < 10) {
          print(Trips[i].trip_id);
          count++;
          found = true;
        } else {
          print("This not your ID");
          break;
        }
      }
    }
  }
  if (!found) print("Your ID not Exists, Please Reverse a trip");
}

void latestTripsAdded() {
  int start = Trips.length-10;
  if(start<=10)
    start = 0;
  for (int i = start; i < Trips.length; i++) {
    print("Trip ID:" + Trips[i].trip_id.toString());
    print("Trip Location:" + Trips[i].trip_location);
    print("Trip Limits:" + Trips[i].trip_limit.toString());
    print("Trip Date:" + Trips[i].date);
    if (Trips[i].trip_price > 10000) {
      double newprice = discount(Trips[i].trip_price);
      print("Trip Price:" +
          Trips[i].trip_price.toString() +
          " After Discount:" +
          newprice.toString());
    } else {
      print("Trip Price:" + Trips[i].trip_price.toString());
    }
    print("****************************************************");
  }
}


void viewPassengers() {
  for (int i = 0; i < Trips.length; i++) {
    print("Trip ID: " + Trips[i].trip_id.toString());
    int custLength = Trips[i].Custs.length;
    if(custLength > 0) {
      for (int j = 0; j < custLength; j++) {
        print("Customer" + (j + 1).toString() + ": " +
            Trips[i].Custs[j].custName);
      }
    }
    else{
      print("None Books this Trip");
    }
  }
}

void init() {
  customer cust1 = new customer(1, "Fathy Medhat");
  customer cust2 = new customer(2, "Abanoub Matta");
  customer cust3 = new customer(3, "Adel Fathy");
  customer cust4 = new customer(4, "Mohamed Ahmed");
  customer cust5 = new customer(5, "Ahmed Ali");

  Trip trp1 = new Trip(1, "Loc1", 3, "22/5/2021", 1000);
  trp1.Custs.add(cust1);
  trp1.Custs.add(cust2);

  Trip trp2 = new Trip(2, "Loc2", 4, "1/1/2020", 10000);
  trp2.Custs.add(cust3);
  trp2.Custs.add(cust4);

  Trip trp3 = new Trip(3, "Loc3", 5, "2/1/2020", 2000);
  trp3.Custs.add(cust4);

  Trip trp4 = new Trip(4, "Loc4", 2, "23/5/2020", 15000);
  trp4.Custs.add(cust3);
  trp4.Custs.add(cust5);

  Trip trp5 = new Trip(5, "Loc5", 10, "3/1/2020", 5000);
  trp5.Custs.add(cust1);
  trp5.Custs.add(cust2);

  Trips.add(trp1);
  Trips.add(trp2);
  Trips.add(trp3);
  Trips.add(trp4);
  Trips.add(trp5);

  Cust_ID = 5;
  Trip_ID = 6;
}
