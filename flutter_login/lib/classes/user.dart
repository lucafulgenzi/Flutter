class User {
  String name;
  String lastName;
  String email;
  String password;
  String date;

  User({this.name, this.lastName, this.email, this.date});

  setName(String _name) {
    this.name = _name;
  }

  getName() {
    return name;
  }

  setLastName(String _lastName) {
    this.lastName = _lastName;
  }

  getLastName() {
    return lastName;
  }

  setEmail(String _email) {
    this.email = _email;
  }

  getEmail() {
    return email;
  }

  setPassword(String _password) {
    this.password = _password;
  }

  getPassword() {
    return password;
  }

  setDate(String _date) {
    this.date = _date;
  }

  getDate() {
    return date;
  }

  setUser(User user) {
    this.name = user.name;
    this.lastName = user.lastName;
    this.date = user.date;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      date: json['date'],
    );
  }
}
