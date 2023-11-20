
class AllCollections
{


}

class UserDetails
{
  String? name;
  String? email;
  var phoneNumber;
  var dob;
  String? area;
  String? pinCode;
  bool? isAdmin;
  bool? isParent;
  var parentNo;

  UserDetails({this.phoneNumber,this.name,this.isAdmin,this.area,this.dob,this.email,this.isParent,this.parentNo,this.pinCode});

}

enum OTPfor {
  login,
  register
}