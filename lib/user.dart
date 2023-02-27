class Users{
  final String ?name,email,phone,password;

  Users(this.name, this.email, this.phone, this.password);
  Users.fromJson(Map<String,dynamic> json, this.name, this.email, this.phone, this.password,);
  Map<String,dynamic> toJson()=>{
    "name":this.name,
    "email":this.email,
    "phone":this.phone,
    "password":this.password


  };

}