// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductCategoryAdapter extends TypeAdapter<ProductCategory> {
  @override
  final int typeId = 0;

  @override
  ProductCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCategory(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as bool,
      fields[4] as String?,
    )..subCategory = (fields[5] as List).cast<ProductCategory>();
  }

  @override
  void write(BinaryWriter writer, ProductCategory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.sectionId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.hasChild)
      ..writeByte(4)
      ..write(obj.parentId)
      ..writeByte(5)
      ..write(obj.subCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
