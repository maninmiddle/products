/// Base class for events related to the home screen.
///
/// All events that modify or interact with the state of the home screen
/// should extend this class.
abstract class HomeEvent {}

/// Event triggered to fetch the list of products.
class FetchProductsEvent extends HomeEvent {}
