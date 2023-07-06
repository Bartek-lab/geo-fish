class UserLocation {
  final double latitude;
  final double longitude;
  UserLocation(this.latitude, this.longitude);
}

class Fish {
  final String name;
  final String size;
  final UserLocation position;
  final String imageUrl;

  Fish(this.imageUrl, this.name, this.size, this.position);
}
