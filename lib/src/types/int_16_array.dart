part of bson;

class BsonInt16Array extends BsonObject {
  BsonInt16Array(this.data);
  BsonInt16Array.fromBuffer(BsonBinary buffer) : data = extractData(buffer);

  List data;
  int? _dataSize;

  static List<dynamic> extractData(BsonBinary buffer) {
    var ret = <dynamic>[];
    buffer.offset += 2;
    var typeByte = buffer.readByte();
    while (typeByte != 0) {
      // Consume the name (for arrays it is the index)
      buffer.readCString();
      // TODO try typeByte = bsonDataInt16
      ret.add(BsonObject.fromTypeByteAndBuffer(typeByte, buffer).value);
      typeByte = buffer.readByte();
    }
    return ret;
  }

  int get size {
    if (_dataSize == null) {
      _dataSize = 0;
      for (var i = 0; i < data.length; i++) {
        _dataSize = _dataSize! + BsonObject.elementSize('$i', data[i]);
      }
    }
    return _dataSize!;
  }

  int dataSize() => size;

  @override
  List get value => data;
  @override
  int byteLength() => dataSize() + 1 + 2;
  @override
  int get typeByte => bsonDataInt16Array;
  @override
  void packValue(BsonBinary buffer) {
    buffer.writeInt16(byteLength());
    for (var i = 0; i < data.length; i++) {
      BsonObject.bsonObjectFrom(data[i]).packElement(i.toString(), buffer);
    }
    buffer.writeByte(0);
  }
}
