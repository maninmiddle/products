abstract class NavigationEvent {}

class CartCountChangedEvent extends NavigationEvent {
  final int count;
  CartCountChangedEvent(this.count);
}
