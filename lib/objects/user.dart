class User{
  String log;
  String password;

  User(this.log, this.password);

  String tryEntry(String logVal, String passVal){
    if (logVal == log){
      if (passVal == password){
        return 'yees';
      }
      else {
        return 'Incorrect password';
      }
    }
    else {
      return 'Incorrect login';
    }
  }
}