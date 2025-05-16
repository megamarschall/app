// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motorcycle_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MotorcycleAdapter extends TypeAdapter<Motorcycle> {
  @override
  final int typeId = 1;

  @override
  Motorcycle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Motorcycle(
      name: fields[0] as String,
      purchaseDate: fields[1] as String,
      purchasePrice: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Motorcycle obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.purchaseDate)
      ..writeByte(2)
      ..write(obj.purchasePrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MotorcycleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
