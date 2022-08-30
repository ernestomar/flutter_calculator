/// Para lo unico que se crea esta clase abstracta es para garantizar
/// que todos lo Blocs se eliminarán de forma correcta.
/// Porque un Bloc siempre tendra un Stream y no es bueno tener varios Streams
/// sin hacer nada, entoces se debe garantizar que se liberarán recursos.
abstract class Bloc {
  /// Dentro de este metodo se deben cerrar todos los StreamController que se hayan
  /// creado
  void dispose();
}
