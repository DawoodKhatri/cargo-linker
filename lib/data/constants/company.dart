List<String> SERVICE_TYPES = ["Rail", "Road", "Ship", "Air"];
List<String> EMPLOYEES_COUNT = [
  "0 - 99",
  "100 - 499",
  "500 - 999",
  "1000 and above"
];

class VERIFICATION_STATUS {
  static String incomplete = "Incomplete";
  static String underVerification = "Under Verification";
  static String rejected = "Rejected";
  static String verified = "Verified";
}

Map<String, String> TEST_COMPANY = {
  "Name": "WorldShare",
  "Registration Number": "123456",
  "Service Type": "Air",
};

List<Map<String, dynamic>> LISTED_CONTAINERS = [
  {
    "containerId": "123467",
    "type": "Standard",
    "size": "30",
    "pickup": {"lat": "30", "long": "45"},
    "drop": {"lat": "30", "long": "45"},
    "due": "2024-02-22T05:30:00.000Z",
    "dimension": {"length": "2", "width": "4", "height": "8"},
    "price": "2780"
  },
  {
    "containerId": "123467",
    "type": "Standard",
    "size": "40",
    "pickup": {"lat": "15", "long": "18"},
    "drop": {"lat": "36", "long": "78"},
    "due": "2024-02-15T05:30:00.000Z",
    "dimension": {"length": "2", "width": "4", "height": "8"},
    "price": "3950"
  },
  {
    "containerId": "123467",
    "type": "Standard",
    "size": "20",
    "pickup": {"lat": "15", "long": "19"},
    "drop": {"lat": "25", "long": "34"},
    "due": "2024-02-18T05:30:00.000Z",
    "dimension": {"length": "2", "width": "4", "height": "8"},
    "price": "1480"
  },
  {
    "containerId": "123467",
    "type": "Standart",
    "size": "30",
    "pickup": {"lat": "17", "long": "35"},
    "drop": {"lat": "18", "long": "28"},
    "due": "2024-02-16T05:30:00.000Z",
    "dimension": {"length": "2", "width": "4", "height": "8"},
    "price": "1690"
  }
];
