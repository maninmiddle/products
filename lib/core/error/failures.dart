// Class to represent a failure with an optional error message
class Failure {
  // The error message associated with the failure
  final String message;
  // Constructor that takes an optional message parameter
  // If no message is provided, a default message is assigned
  Failure([this.message = 'An unexpected error occurred']);
}
