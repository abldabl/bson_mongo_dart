part of bson;

class BsonInt extends BsonObject {
  BsonInt(this.data);

  BsonInt.fromBuffer(BsonBinary buffer) : data = extractData(buffer);

  int data;

  static int extractData(BsonBinary buffer) => buffer.readInt32();

  @override
  int get value => data;
  @override
  int byteLength() => 4;
  @override
  int get typeByte => bsonDataInt;
  @override
  void packValue(BsonBinary buffer) => buffer.writeInt(data);
}

class BsonLong extends BsonObject {
  BsonLong(this.data);
  BsonLong.fromBuffer(BsonBinary buffer) : data = extractData(buffer);

  Int64 data;

  static Int64 extractData(BsonBinary buffer) => buffer.readFixInt64();

  @override
  Int64 get value => data;
  @override
  int byteLength() => 8;
  @override
  int get typeByte => bsonDataLong;
  @override
  void packValue(BsonBinary buffer) => buffer.writeFixInt64(data);
}

class BsonInt16 extends BsonObject {
  BsonInt16(this.data);

  BsonInt16.fromBuffer(BsonBinary buffer) : data = extractData(buffer);

  int data;

  static int extractData(BsonBinary buffer) => buffer.readInt16();

  @override
  int get value => data;
  @override
  int byteLength() => 2;
  @override
  int get typeByte => bsonDataInt16;
  @override
  void packValue(BsonBinary buffer) => buffer.writeInt16(data);
}
