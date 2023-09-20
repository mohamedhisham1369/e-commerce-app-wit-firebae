class usermodel{

  String? name;
  String? email;
  String? phone;
  String? Uid;
  String? image;


  usermodel(this.name, this.email, this.phone, this.Uid,this.image);



  usermodel.fromjson( Map<String ,dynamic> json){

    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    Uid = json['Uid'];
    image = json['image'];




  }


  Map<String ,dynamic> tojson(){
    return{
      'email':email,
      'name':name,
      'phone':phone,
      "image":image,

    };

  }

}