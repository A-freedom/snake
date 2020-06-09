import 'dart:ui';

class Object {
  Color color;
  List coordinates;
  List _LastCoordinates ;
  int totalLength;
  int rowLength;
  Object({this.coordinates, this.color, this.totalLength, this.rowLength});

  int moveUpDown(int e) {
    if (e > -1 && e < totalLength) {
      return e;
    } else {
      if (e >= totalLength) {
        return e - totalLength;
      } else {
        return totalLength + e;
      }
    }
  }

  void get moveDown {
    coordinates.add(moveUpDown(coordinates.last + rowLength));
    coordinates.removeAt(0);
    this._LastCoordinates = this.coordinates ;
  }

  void get moveUp {
    coordinates.add(moveUpDown(coordinates.last - rowLength));
    coordinates.removeAt(0);
    this._LastCoordinates = this.coordinates ;
  }

  void get moveLeft {
    coordinates.add(((coordinates.last % rowLength) == 0)
        ? coordinates.last + rowLength - 1
        : coordinates.last - 1);
    coordinates.removeAt(0);
    this._LastCoordinates = this.coordinates ;
  }

  void get moveRight {
    coordinates.add((((coordinates.last + 1) % rowLength) == 0)
        ? coordinates.last - rowLength + 1
        : coordinates.last + 1);
    coordinates.removeAt(0);
    this._LastCoordinates = this.coordinates ;
  }

  void grow(direction) {
    var app  = coordinates.last ;
    this.coordinates = this._LastCoordinates ;
    switch (direction) {
      case 'up':
        {
          coordinates.add(moveUpDown(coordinates.last - rowLength));
        }
        break;
      case 'down':
        {
          coordinates.add(moveUpDown(coordinates.last + rowLength));
        }
        break;
      case 'left':
        {
          coordinates.add(((coordinates.last % rowLength) == 0)
              ? coordinates.last + rowLength - 1
              : coordinates.last - 1);
        }
        break;
      case 'right':
        {
          coordinates.add((((coordinates.last + 1) % rowLength) == 0)
              ? coordinates.last - rowLength + 1
              : coordinates.last + 1);
          coordinates.removeAt(0);
        }
        break;
    }
  }
}
