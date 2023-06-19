/// Abstract base class for mappers that convert between model and entity objects.
///
/// The [BaseMapper] class defines two methods: [mapToEntity] and [mapToModel].
/// Implementations of this class should provide concrete implementations for these methods.
///
/// The [mapToEntity] method takes a [Model] object and converts it to an [Entity] object.
/// It is responsible for mapping the fields from the model to the corresponding fields in the entity.
///
/// The [mapToModel] method takes an [Entity] object and converts it to a [Model] object.
/// It is responsible for mapping the fields from the entity to the corresponding fields in the model.
///
abstract class BaseMapper<Model, Entity> {
  /// Converts a [Model] object to an [Entity] object.
  ///
  /// The [model] parameter is the instance of the model object to be converted.
  ///
  /// Returns an instance of the entity object with the mapped fields from the model.
  Entity mapToEntity({
    required Model? model,
  });

  /// Converts an [Entity] object to a [Model] object.
  ///
  /// The [entity] parameter is the instance of the entity object to be converted.
  ///
  /// Returns an instance of the model object with the mapped fields from the entity.
  Model mapToModel({
    required Entity entity,
  });
}
