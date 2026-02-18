// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventModelAdapter extends TypeAdapter<EventModel> {
  @override
  final int typeId = 0;

  @override
  EventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventModel(
      id: fields[0] as String,
      eventCategory: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      date: fields[4] as int,
      time: fields[5] as String,
      location: fields[6] as String,
      isFav: fields[7] as bool,
      toBeNotified: fields[8] as bool,
      userId: fields[9] as String,
      eventPosition: fields[10] as LatLng,
    );
  }

  @override
  void write(BinaryWriter writer, EventModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.eventCategory)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.isFav)
      ..writeByte(8)
      ..write(obj.toBeNotified)
      ..writeByte(9)
      ..write(obj.userId)
      ..writeByte(10)
      ..write(obj.eventPosition);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
