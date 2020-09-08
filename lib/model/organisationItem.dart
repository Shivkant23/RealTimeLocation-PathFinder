class Organisation{
  String stageName;
  String avatarString; 
  String orgName; 
  String owner; 
  String date;

  Organisation({this.stageName, this.avatarString, this.orgName, this.owner, this.date});

  String get getStageName => stageName;
  String get getAvatarString => avatarString;
  String get getOrgName => orgName;
  String get getOwner => owner;
  String get getDate => date;
}