// on boarding models
class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}
class SliderViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.currentIndex, this.numberOfSlides);
}

class Customer {
  String id;
  String name;
  int numberOfNotifications;
  Customer(this.id, this.name, this.numberOfNotifications);
}
class Contacts {
  String phone;
  String email;
  String link;
  Contacts(this.phone, this.email, this.link);
}
class Authentication{
  Customer? customer;
  Contacts? contacts;
  Authentication(this.customer, this.contacts);
}