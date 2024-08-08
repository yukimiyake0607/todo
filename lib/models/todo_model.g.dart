// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoModelImplAdapter extends TypeAdapter<_$TodoModelImpl> {
  @override
  final int typeId = 0;

  @override
  _$TodoModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TodoModelImpl(
      id: fields[0] as String,
      title: fields[1] as String,
      subTitle: fields[2] as String,
      isChecked: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$TodoModelImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subTitle)
      ..writeByte(3)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModelImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
