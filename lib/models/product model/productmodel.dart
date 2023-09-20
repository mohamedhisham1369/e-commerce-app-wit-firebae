class productmodel{

  String? stockQuantity;
  String? category;
  String? price;
  String? image;
  String? name;
  String? description;
  int ? id;




  productmodel(this.stockQuantity, this.category,  this.price,this.image ,this.name, this.description ,this.id);



  productmodel.fromjson( Map<String ,dynamic> json){

    stockQuantity = json['stockQuantity'];
    category = json['category'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    id = json['id'];



  }


  Map<String ,dynamic> tojson(){
    return{
      'stockQuantity':stockQuantity,
      'category':category,
      "image":image,
      "name":name,
      "price":price,
      "description":description,
      "id":id,

    };

  }

}