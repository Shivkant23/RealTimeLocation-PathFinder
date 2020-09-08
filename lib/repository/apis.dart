class APIs{
  String userSignUp = "auth/signup";
  String signin = "auth/signin";
  String getUserDetails = "auth/userprofile/";
  String updateDonorProfile = "auth/updateProfileDonor";
  String updateNgoProfile = "auth/updateProfileNgo";// not usable in mobile application
  String saveorUpdateMyNGO = "donor/myNgo";
  String getDonorMyNGO = "donor/getMyNgo/6";
  String donorPaymentFrequencySetup = "donor/updatePymtFrequency";
  String getDonorPaymentFrequency = "donor/getPymtFrequency/6";
  String donorDonations = "donor/ngoPayment";
  String saveorUpdateDonorReference = "donor/myReferences";
  String getDonorReferences = "donor/getMyReferences/6";
  String saveorUpdateNGOReferences = "ngo/references";
  String getNgoReferences = "";// not usable in mobile application
  String emailVerification = "auth/confirmEmail/";
  String verifyOTP = "auth/verifyOTP";
  String forgotPassword = "auth/forgotPassword";
  String changePassword = "auth/changePassword";
  String lookup = "master/getLookup/";
}