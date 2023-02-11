// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_directory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedDirectoryAdapter extends TypeAdapter<SavedDirectory> {
  @override
  final int typeId = 0;

  @override
  SavedDirectory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedDirectory(
      directory: fields[1] as String,
      name: fields[2] as String,
      iconId: fields[3] as int,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, SavedDirectory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.directory)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.iconId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedDirectoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
