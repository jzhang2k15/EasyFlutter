class User {
  final String name;
  final String email;

  User(this.name, this.email);

  // 重定向构造方法，该方法没有主体，仅仅是重定向到另一个构造方法，在冒号后面调用另一个构造方法
  factory User.fromJson(Map<String, dynamic> json) => new User(json['name'], json['email']) ;
//  name = json['name'],
//        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}


