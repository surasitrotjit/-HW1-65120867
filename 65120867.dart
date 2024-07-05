class Room {
  int roomNumber;
  String roomType;
  double price;
  bool isBooked;

  Room({
    required this.roomNumber,
    required this.roomType,
    required this.price,
    this.isBooked = false,
  });

  void bookRoom() {
    if (!isBooked) {
      isBooked = true;
    } else {
      print('Room $roomNumber is already booked.');
    }
  }

  void cancelBooking() {
    if (isBooked) {
      isBooked = false;
    } else {
      print('Room $roomNumber is not booked.');
    }
  }

  @override
  String toString() {
    return 'Room $roomNumber - $roomType: \$${price.toStringAsFixed(2)} per night';
  }
}

class Guest {
  String name;
  String guestId;
  List<Room> bookedRooms = [];

  Guest({
    required this.name,
    required this.guestId,
  });

  bool bookRoom(Room room) {
    if (!room.isBooked) {
      bookedRooms.add(room);
      room.bookRoom();
      return true;
    } else {
      print('Room ${room.roomNumber} is already booked.');
      return false;
    }
  }

  bool cancelRoom(Room room) {
    if (bookedRooms.contains(room)) {
      bookedRooms.remove(room);
      room.cancelBooking();
      return true;
    } else {
      print('Room ${room.roomNumber} is not booked by ${this.name}.');
      return false;
    }
  }

  @override
  String toString() {
    return 'Guest $guestId: $name';
  }
}

class Hotel {
  List<Room> rooms = [];
  List<Guest> guests = [];

  void addRoom(Room room) {
    rooms.add(room);
  }

  void removeRoom(Room room) {
    rooms.remove(room);
  }

  void registerGuest(Guest guest) {
    guests.add(guest);
  }

  bool bookRoom(String guestId, int roomNumber) {
    Guest? guest = getGuest(guestId);
    Room? room = getRoom(roomNumber);
    if (guest != null && room != null) {
      return guest.bookRoom(room);
    } else {
      print('Guest or Room not found.');
      return false;
    }
  }

  bool cancelRoom(String guestId, int roomNumber) {
    Guest? guest = getGuest(guestId);
    Room? room = getRoom(roomNumber);
    if (guest != null && room != null) {
      return guest.cancelRoom(room);
    } else {
      print('Guest or Room not found.');
      return false;
    }
  }

  Room getRoom(int roomNumber) {
    // Return the room if found, otherwise throw an exception or handle as needed
    Room? foundRoom = rooms.firstWhere((room) => room.roomNumber == roomNumber,
        orElse: () => throw Exception('Room not found'));
    return foundRoom;
  }

  Guest getGuest(String guestId) {
    // Return the guest if found, otherwise throw an exception or handle as needed
    Guest? foundGuest = guests.firstWhere((guest) => guest.guestId == guestId,
        orElse: () => throw Exception('Guest not found'));
    return foundGuest;
  }

  @override
  String toString() {
    String roomInfo = rooms.isEmpty
        ? 'No rooms available.'
        : rooms.map((room) => room.toString()).join('\n');

    String guestInfo = guests.isEmpty
        ? 'No guests registered.'
        : guests.map((guest) => guest.toString()).join('\n');

    return 'Hotel Information:\nRooms:\n$roomInfo\nGuests:\n$guestInfo';
  }
}

void main() {
  Hotel hotel = Hotel();

  Room room1 = Room(roomNumber: 101, roomType: 'Single', price: 1000);
  Room room2 = Room(roomNumber: 102, roomType: 'Double', price: 2000);
  Room room3 = Room(roomNumber: 103, roomType: 'Suite', price: 3000);

  hotel.addRoom(room1);
  hotel.addRoom(room2);
  hotel.addRoom(room3);

  Guest guest1 = Guest(name: 'Surasit', guestId: 'G001');
  Guest guest2 = Guest(name: 'BaBoon', guestId: 'G002');

  // Register guests
  hotel.registerGuest(guest1);
  hotel.registerGuest(guest2);

  hotel.bookRoom('G001', 101);
  hotel.bookRoom('G002', 102);
  hotel.bookRoom(
      'G001', 101); // This should print that the room is already booked

  hotel.cancelRoom('G001', 101);

  print(hotel);
}
