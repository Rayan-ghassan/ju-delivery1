class Home {
  List<Room> rooms;

  Home({required this.rooms});
}

class Room {
  double area;
  List<Window> windows;
  String wallColor;
  Door door;

  Room(
      {required this.area,
      required this.windows,
      required this.wallColor,
      required this.door});
}

class Window {
  double height;
  double width;
  String type;

  Window({required this.height, required this.width, required this.type});
}

class Door {
  double height;
  double width;
  String color;

  Door({required this.height, required this.width, required this.color});
}

void main() {
  List<Room> rooms = [
    Room(
        area: 16,
        windows: [
          Window(height: 100, width: 80, type: "Glass"),
          Window(height: 80, width: 80, type: "Double Glass"),
        ],
        wallColor: "White",
        door: Door(height: 220, width: 120, color: "Brown")),
    Room(
        area: 30,
        windows: [
          Window(height: 140, width: 200, type: "Glass"),
          Window(height: 120, width: 100, type: "Double Glass"),
        ],
        wallColor: "brown and black",
        door: Door(height: 220, width: 120, color: "White")),
    Room(
        area: 30,
        windows: [
          Window(height: 140, width: 200, type: "Glass"),
          Window(height: 120, width: 100, type: "Double Glass"),
        ],
        wallColor: "brown and black",
        door: Door(height: 220, width: 120, color: "White")),
    Room(
        area: 30,
        windows: [
          Window(height: 140, width: 200, type: "Glass"),
          Window(height: 120, width: 100, type: "Double Glass"),
        ],
        wallColor: "brown and black",
        door: Door(height: 220, width: 120, color: "White")),
    Room(
        area: 30,
        windows: [
          Window(height: 140, width: 200, type: "Glass"),
          Window(height: 120, width: 100, type: "Double Glass"),
        ],
        wallColor: "brown and black",
        door: Door(height: 220, width: 120, color: "White"))
  ];
  Home home = Home(rooms: rooms);

  Laptop laptop = Laptop(
      screen: DeviceScreen(type: "Double glass"),
      type: "omen",
      cpu: Cpu(type: "Core i-7 6700Hq"),
      battery: Battery(size: 4000),
      productionFactoryName: "HP");
  Laptop laptop2 = Laptop(
      screen: DeviceScreen(type: "Double glass"),
      type: "omen2",
      cpu: Cpu(type: "Core i-7 6700Hq"),
      battery: Battery(size: 12000),
      productionFactoryName: "HP");
  print(laptop ==
      laptop2); // false    true  (values override == for all classes )

  // inheritnce

  // ElectronicDevice hpLaptop=Laptop(screen: screen, type: type, cpu: cpu, battery: battery, productionFactoryName: productionFactoryName); // polymorphism
  // ElectronicDevice samsungMobile=Mobile(screen: screen, type: type, cpu: cpu, battery: battery, productionFactoryName: productionFactoryName); // polymorphism
  // ElectronicDevice ipad=Ipad(screen: screen, type: type, cpu: cpu, battery: battery, productionFactoryName: productionFactoryName); // polymorphism

  // dependency Injection
  printElectronicDevice(laptop);
  printElectronicDevice(laptop2);
  Mobile mobile = Mobile(
      screen: DeviceScreen(type: "glass"),
      type: "S24 ultra",
      cpu: Cpu(type: "batata"),
      battery: Battery(size: 4000),
      productionFactoryName: "Samsung");
  printElectronicDevice(mobile);
}
//
// void printLaptopData(Laptop laptop) {
//   print(laptop.battery.size);
//   print(laptop.productionFactory);
// }
//
// void printMobileData(Mobile mobile) {
//   print(mobile.battery.size);
//   print(mobile.productionFactory);
// }
//
// void printIpadData(Ipad ipad) {
//   print(ipad.battery.size);
//   print(ipad.productionFactory);
// }

void printElectronicDevice(ElectronicDevice device) {
  // dependency injection
  print(device.battery.size);
  print(device.productionFactory);
  if (device is Mobile) {
    print(device.type);
  }
  if (device is Laptop) {
    print(device.cpu.type);
  }
}

class ElectronicDevice {
  Battery battery;
  String productionFactory;

  ElectronicDevice({required this.battery, required this.productionFactory});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElectronicDevice &&
          battery == other.battery &&
          productionFactory == other.productionFactory;

  @override
  int get hashCode =>
      battery.hashCode ^ productionFactory.hashCode; // xor // glass DELL
}

class Battery {
  double size;

  Battery({required this.size});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Battery &&
          runtimeType == other.runtimeType &&
          size == other.size;

  @override
  int get hashCode => size.hashCode;
}

class Laptop extends ElectronicDevice {
  DeviceScreen screen;
  String type;
  Cpu cpu;

  Laptop(
      {required this.screen,
      required this.type,
      required this.cpu,
      required Battery battery,
      required String productionFactoryName})
      : super(battery: battery, productionFactory: productionFactoryName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Laptop &&
          screen == other.screen &&
          type == other.type &&
          cpu == other.cpu;

  @override
  int get hashCode =>
      super.hashCode ^ screen.hashCode ^ type.hashCode ^ cpu.hashCode;
}

class Ipad extends ElectronicDevice {
  DeviceScreen screen;
  String type;
  Cpu cpu;

  Ipad(
      {required this.screen,
      required this.type,
      required this.cpu,
      required Battery battery,
      required String productionFactoryName})
      : super(battery: battery, productionFactory: productionFactoryName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Laptop &&
          screen == other.screen &&
          type == other.type &&
          cpu == other.cpu;

  @override
  int get hashCode =>
      super.hashCode ^ screen.hashCode ^ type.hashCode ^ cpu.hashCode;
}

class Mobile extends ElectronicDevice {
  DeviceScreen screen;
  String type;
  Cpu cpu;

  Mobile(
      {required this.screen,
      required this.type,
      required this.cpu,
      required Battery battery,
      required String productionFactoryName})
      : super(battery: battery, productionFactory: productionFactoryName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Laptop &&
          screen == other.screen &&
          type == other.type &&
          cpu == other.cpu;

  @override
  int get hashCode =>
      super.hashCode ^ screen.hashCode ^ type.hashCode ^ cpu.hashCode;
}

class DeviceScreen {
  String type;

  DeviceScreen({required this.type});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceScreen &&
          runtimeType == other.runtimeType &&
          type == other.type;

  @override
  int get hashCode => type.hashCode;
}

class Cpu {
  String type;

  Cpu({required this.type});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cpu && runtimeType == other.runtimeType && type == other.type;

  @override
  int get hashCode => type.hashCode;
}
// task

// create a class called Shape   that have 2 attribute  msa7a mo7e6
// create a sub class called rectangle and triangle
// print the area for the shapes using dependency injection

// read about abstract class

// create a class called Shape   that have 2 abstract methods  msa7a mo7e6
// create a sub class called rectangle and triangle
// print the area for the shapes using dependency injection

// abstract class , methods   // design
