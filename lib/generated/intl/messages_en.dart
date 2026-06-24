// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(time) => "Completed from ${time}";

  static String m1(count) =>
      "${count} ${Intl.plural(count, one: 'day', other: 'days')} ago";

  static String m2(count) =>
      "${count} ${Intl.plural(count, one: 'hour', other: 'hours')} ago";

  static String m3(count) => "${count} Messages";

  static String m4(count) =>
      "${count} ${Intl.plural(count, one: 'minute', other: 'minutes')} ago";

  static String m5(step) => "Next step: ${step}";

  static String m6(filter) => "No tasks found for \'${filter}\'";

  static String m7(count) =>
      "${count} ${Intl.plural(count, one: 'week', other: 'weeks')} ago";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessZone": MessageLookupByLibrary.simpleMessage("Access Zone"),
    "accountInformation": MessageLookupByLibrary.simpleMessage(
      "Account information",
    ),
    "achievement": MessageLookupByLibrary.simpleMessage("Achievement"),
    "achievementDetails": MessageLookupByLibrary.simpleMessage(
      "Achievement Details",
    ),
    "active": MessageLookupByLibrary.simpleMessage("Active"),
    "activityTimeline": MessageLookupByLibrary.simpleMessage(
      "ACTIVITY TIMELINE",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addCommentHint": MessageLookupByLibrary.simpleMessage(
      "Add a reply or a new inquiry...",
    ),
    "addCommentLabel": MessageLookupByLibrary.simpleMessage("Add Comment"),
    "addNotesHint": MessageLookupByLibrary.simpleMessage("Add Notes"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("Add Photo or Vedio"),
    "addReport": MessageLookupByLibrary.simpleMessage("Add Report"),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "address2": MessageLookupByLibrary.simpleMessage("Address"),
    "age": MessageLookupByLibrary.simpleMessage("Age"),
    "alertRequired": MessageLookupByLibrary.simpleMessage(
      "Verification required",
    ),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "appName": MessageLookupByLibrary.simpleMessage("CitiFix"),
    "appTitle": MessageLookupByLibrary.simpleMessage("CitiFix"),
    "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "areYouSureLogout": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to logout?",
    ),
    "assigned": MessageLookupByLibrary.simpleMessage("Assigned"),
    "attentionRequired": MessageLookupByLibrary.simpleMessage(
      "Attention Required",
    ),
    "available_tasks": MessageLookupByLibrary.simpleMessage("Available Tasks"),
    "camera": MessageLookupByLibrary.simpleMessage("Camera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelApp": MessageLookupByLibrary.simpleMessage("Cancel Application"),
    "category": MessageLookupByLibrary.simpleMessage("Category"),
    "caughtUpMessage": MessageLookupByLibrary.simpleMessage(
      "You are all caught up! Check back later.",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "checking_account_status": MessageLookupByLibrary.simpleMessage(
      "Checking account status...",
    ),
    "choosePreferredLanguage": MessageLookupByLibrary.simpleMessage(
      "Choose your preferred language",
    ),
    "citizen": MessageLookupByLibrary.simpleMessage("Citizen"),
    "citizenIdentity": MessageLookupByLibrary.simpleMessage("Citizen Identity"),
    "citizenResponsibilityDesc": MessageLookupByLibrary.simpleMessage(
      "1. Reports must be truthful and accurate.\n2. Photos must be clear and related to the issue.\n3. Misuse of the platform (fake reports) leads to a permanent ban.",
    ),
    "citizenResponsibilityTitle": MessageLookupByLibrary.simpleMessage(
      "Citizen Responsibilities",
    ),
    "civix": MessageLookupByLibrary.simpleMessage("Civix"),
    "comments": MessageLookupByLibrary.simpleMessage("Comments"),
    "completed": MessageLookupByLibrary.simpleMessage("Resolved"),
    "completedBy": MessageLookupByLibrary.simpleMessage("Completed By"),
    "completedFrom": m0,
    "completionData": MessageLookupByLibrary.simpleMessage("COMPLETION DATA"),
    "completionDetails": MessageLookupByLibrary.simpleMessage(
      "Completion Details",
    ),
    "completionImages": MessageLookupByLibrary.simpleMessage(
      "Completion Images",
    ),
    "completionNote": MessageLookupByLibrary.simpleMessage("Completion Note"),
    "completionNotes": MessageLookupByLibrary.simpleMessage("COMPLETION NOTES"),
    "complianceDocuments": MessageLookupByLibrary.simpleMessage(
      "Compliance Documents",
    ),
    "compressingVideo": MessageLookupByLibrary.simpleMessage(
      "Compressing video...",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm Delete"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Please confirm your password",
    ),
    "confirmedZone": MessageLookupByLibrary.simpleMessage("CONFIRMED ZONE"),
    "contactSupport": MessageLookupByLibrary.simpleMessage(
      "Still have questions? Contact Support",
    ),
    "continueToApp": MessageLookupByLibrary.simpleMessage("Continue to App"),
    "created": MessageLookupByLibrary.simpleMessage("CREATED"),
    "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "dataSecurityNote": MessageLookupByLibrary.simpleMessage(
      "Your data is securely stored and encrypted.",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "dateBirth": MessageLookupByLibrary.simpleMessage("Date Brith"),
    "dateOfBirth": MessageLookupByLibrary.simpleMessage("Date of Birth"),
    "dateRequired": MessageLookupByLibrary.simpleMessage(
      "Please choose date of birth",
    ),
    "daysAgo": m1,
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this report?",
    ),
    "deleteall": MessageLookupByLibrary.simpleMessage("Delete all"),
    "department": MessageLookupByLibrary.simpleMessage("Department"),
    "describeIssue": MessageLookupByLibrary.simpleMessage(
      "Describe the issue...",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "descriptionHint": MessageLookupByLibrary.simpleMessage(
      "Write a detailed description...",
    ),
    "descriptionIsRequired": MessageLookupByLibrary.simpleMessage(
      "Description is required",
    ),
    "descriptionLabel": MessageLookupByLibrary.simpleMessage("Description"),
    "descriptionTooShort": MessageLookupByLibrary.simpleMessage(
      "Description must be at least 10 characters",
    ),
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "digitalIdIssued": MessageLookupByLibrary.simpleMessage(
      "Digital ID Issued",
    ),
    "distance_to_task": MessageLookupByLibrary.simpleMessage(
      "DISTANCE TO TASK",
    ),
    "documentNumber": MessageLookupByLibrary.simpleMessage("Document Number"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don’t have an account?",
    ),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Email already exists or database error",
    ),
    "emailRequired": MessageLookupByLibrary.simpleMessage("Email is required"),
    "emptyReportsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Any new reports you create will appear here.",
    ),
    "engineering": MessageLookupByLibrary.simpleMessage("Engineering"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Enter confirm password",
    ),
    "enterNameHint": MessageLookupByLibrary.simpleMessage(
      "Enter as shown on ID",
    ),
    "enterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Enter new password",
    ),
    "enterNotes": MessageLookupByLibrary.simpleMessage("Enter your notes here"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorIdNotClear": MessageLookupByLibrary.simpleMessage(
      "The ID image is not clear or has expired.",
    ),
    "errorMissingData": MessageLookupByLibrary.simpleMessage(
      "Some required information is missing from your documents.",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "errorSelfieMismatch": MessageLookupByLibrary.simpleMessage(
      "The selfie does not match the provided ID photo.",
    ),
    "errorTitle": MessageLookupByLibrary.simpleMessage(
      "Oops! Something went wrong.",
    ),
    "expiresDate": MessageLookupByLibrary.simpleMessage("Expires "),
    "failedToLoadCategories": MessageLookupByLibrary.simpleMessage(
      "Failed to load categories",
    ),
    "faqCategory": MessageLookupByLibrary.simpleMessage(
      "Frequently Asked Questions",
    ),
    "fcm": MessageLookupByLibrary.simpleMessage("FCM"),
    "finish": MessageLookupByLibrary.simpleMessage("Get Started"),
    "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
    "firstNameRequired": MessageLookupByLibrary.simpleMessage(
      "First name is required",
    ),
    "fixTimeAnswer": MessageLookupByLibrary.simpleMessage(
      "Repair time depends on the issue\'s severity. You can track the real-time progress in the \'My Reports\' section.",
    ),
    "fixTimeQuestion": MessageLookupByLibrary.simpleMessage(
      "How long does it take to fix a problem?",
    ),
    "fix_water_leak": MessageLookupByLibrary.simpleMessage("Fix Water Leak"),
    "forgetPassword": MessageLookupByLibrary.simpleMessage(
      "Forget Password....?",
    ),
    "forgetPasswordDesc": MessageLookupByLibrary.simpleMessage(
      "Please enter the email address associated with your account, and we\'ll send you an OTP to reset your password.",
    ),
    "forgetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Forgot Password",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password"),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "fullNamea": MessageLookupByLibrary.simpleMessage("Full Legal Name"),
    "gender": MessageLookupByLibrary.simpleMessage("Gender"),
    "haveAccount": MessageLookupByLibrary.simpleMessage(
      "Have an account already?",
    ),
    "heading_to_task": MessageLookupByLibrary.simpleMessage("Heading to Task"),
    "help": MessageLookupByLibrary.simpleMessage("Help & Terms"),
    "helpAndLegal": MessageLookupByLibrary.simpleMessage("Help & Legal"),
    "hintAddress": MessageLookupByLibrary.simpleMessage("Enter your address"),
    "hintEmail": MessageLookupByLibrary.simpleMessage(
      "Enter your email address",
    ),
    "hintFirstName": MessageLookupByLibrary.simpleMessage(
      "Enter your First Name",
    ),
    "hintLastName": MessageLookupByLibrary.simpleMessage(
      "Enter your Last Name",
    ),
    "hintNationalNumber": MessageLookupByLibrary.simpleMessage(
      "Enter National number",
    ),
    "hintPassword": MessageLookupByLibrary.simpleMessage("********"),
    "hintPhone": MessageLookupByLibrary.simpleMessage("Enter your Phone"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "hoursAgo": m2,
    "howToReportAnswer": MessageLookupByLibrary.simpleMessage(
      "Open the app, tap the \'+\' button, take a photo, and pin the location. Our system will automatically notify the nearest worker.",
    ),
    "howToReportQuestion": MessageLookupByLibrary.simpleMessage(
      "How do I report a maintenance issue?",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "idBack": MessageLookupByLibrary.simpleMessage("ID Back"),
    "idFront": MessageLookupByLibrary.simpleMessage("ID Front"),
    "idLabel": MessageLookupByLibrary.simpleMessage("ID"),
    "identity": MessageLookupByLibrary.simpleMessage("Identity"),
    "identityDocs": MessageLookupByLibrary.simpleMessage("Identity Docs"),
    "imageBlurry": MessageLookupByLibrary.simpleMessage("Image Blurry"),
    "imageRequired": MessageLookupByLibrary.simpleMessage("Image is required"),
    "inProgress": MessageLookupByLibrary.simpleMessage("IN PROGRESS"),
    "inside_work_zone": MessageLookupByLibrary.simpleMessage(
      "Inside Work Zone",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "invalidPassword": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters and include letters and numbers and special characters",
    ),
    "invalidPhone": MessageLookupByLibrary.simpleMessage("Invalid phone"),
    "invalidRequest": MessageLookupByLibrary.simpleMessage(
      "Invalid request. Please try again",
    ),
    "isOnboardingViewed": MessageLookupByLibrary.simpleMessage(
      "is_show_on_board",
    ),
    "issueMedia": MessageLookupByLibrary.simpleMessage("ISSUE MEDIA"),
    "job": MessageLookupByLibrary.simpleMessage("Job"),
    "justNow": MessageLookupByLibrary.simpleMessage("Just now"),
    "km": MessageLookupByLibrary.simpleMessage("KM"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
    "lastNameRequired": MessageLookupByLibrary.simpleMessage(
      "Last name is required",
    ),
    "legalCategory": MessageLookupByLibrary.simpleMessage("Legal & Privacy"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "loadingCategories": MessageLookupByLibrary.simpleMessage(
      "Loading Categories...",
    ),
    "location": MessageLookupByLibrary.simpleMessage("Location"),
    "locationNotFound": MessageLookupByLibrary.simpleMessage(
      "Location not found",
    ),
    "locationSearchFailed": MessageLookupByLibrary.simpleMessage(
      "Could not find that location",
    ),
    "logIn": MessageLookupByLibrary.simpleMessage("log in"),
    "login": MessageLookupByLibrary.simpleMessage("Log in"),
    "logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "logoutConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out of your account?",
    ),
    "logoutFailed": MessageLookupByLibrary.simpleMessage("Logout failed"),
    "logoutSuccess": MessageLookupByLibrary.simpleMessage(
      "Logged out successfully",
    ),
    "markAllRead": MessageLookupByLibrary.simpleMessage("Mark all read"),
    "markAsCompletedBtn": MessageLookupByLibrary.simpleMessage(
      "Mark as Completed",
    ),
    "markasCompeleted": MessageLookupByLibrary.simpleMessage(
      "You can solve the problem now.",
    ),
    "markasCompeleteds": MessageLookupByLibrary.simpleMessage(
      "You can solve the problem now.",
    ),
    "messagesCount": m3,
    "minutesAgo": m4,
    "monitoring_area": MessageLookupByLibrary.simpleMessage("Monitoring Area"),
    "msgRegister": MessageLookupByLibrary.simpleMessage(
      "we have sent a 6-digit code to your registered email address/phone number",
    ),
    "msgResetPassword": MessageLookupByLibrary.simpleMessage(
      "We’ve sent you a code to reset your password. Please check your email.",
    ),
    "msgResettingPass": MessageLookupByLibrary.simpleMessage(
      "Code verified successfully. Please set your new password.",
    ),
    "msgResettingPassword": MessageLookupByLibrary.simpleMessage(
      "Resetting password...",
    ),
    "mustCompleteReportImages": MessageLookupByLibrary.simpleMessage(
      "You must complete the required report\nimages before finishing the task.",
    ),
    "nationalID": MessageLookupByLibrary.simpleMessage("National ID"),
    "nationalId": MessageLookupByLibrary.simpleMessage("National ID"),
    "nationalIdBack": MessageLookupByLibrary.simpleMessage("National ID Back"),
    "nationalIdDigits": MessageLookupByLibrary.simpleMessage(
      "National ID must contain only digits",
    ),
    "nationalIdFront": MessageLookupByLibrary.simpleMessage(
      "National ID Front",
    ),
    "nationalIdLength": MessageLookupByLibrary.simpleMessage(
      "National ID must be exactly 14 digits",
    ),
    "nationalIdRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter national ID",
    ),
    "nationalNumber": MessageLookupByLibrary.simpleMessage("National number"),
    "needHelp": MessageLookupByLibrary.simpleMessage("Need help?"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "nextStep": m5,
    "noCommentsYet": MessageLookupByLibrary.simpleMessage(
      "No comments yet. Be the first to reply!",
    ),
    "noData": MessageLookupByLibrary.simpleMessage(
      "No data available at the moment",
    ),
    "noDescription": MessageLookupByLibrary.simpleMessage(
      "No Description provided.",
    ),
    "noInternet": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noNotifications": MessageLookupByLibrary.simpleMessage(
      "No new notifications",
    ),
    "noRecentReports": MessageLookupByLibrary.simpleMessage(
      "No recent reports",
    ),
    "noReportsAvailable": MessageLookupByLibrary.simpleMessage(
      "No reports available currently",
    ),
    "noResult": MessageLookupByLibrary.simpleMessage("No results found"),
    "noTasksFound": m6,
    "noTitle": MessageLookupByLibrary.simpleMessage("No Title"),
    "no_tasks_available": MessageLookupByLibrary.simpleMessage(
      "No tasks available right now",
    ),
    "notes": MessageLookupByLibrary.simpleMessage("Notes"),
    "notesLabel": MessageLookupByLibrary.simpleMessage("Additional Notes"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notify_new_tasks": MessageLookupByLibrary.simpleMessage(
      "We\'ll notify you when new tasks arrive.",
    ),
    "numberMismatch": MessageLookupByLibrary.simpleMessage(
      "Number didn\'t match the image provided",
    ),
    "oldPassword": MessageLookupByLibrary.simpleMessage("Old Password"),
    "online": MessageLookupByLibrary.simpleMessage("Online"),
    "otpMsgRegister": MessageLookupByLibrary.simpleMessage(
      "Enter the code sent to your email",
    ),
    "otpMsgResetPassword": MessageLookupByLibrary.simpleMessage(
      "Enter the code to reset your password",
    ),
    "otpVerification": MessageLookupByLibrary.simpleMessage("OTP Verification"),
    "overview": MessageLookupByLibrary.simpleMessage("OverView"),
    "passportPhoto": MessageLookupByLibrary.simpleMessage(
      "Passport Photo Page",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordLowercase": MessageLookupByLibrary.simpleMessage(
      "One lowercase character",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Minimum 8 characters",
    ),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "passwordNumber": MessageLookupByLibrary.simpleMessage("One number"),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "passwordRulesTitle": MessageLookupByLibrary.simpleMessage(
      "Please add all necessary characters to create safe password.",
    ),
    "passwordSpecialChar": MessageLookupByLibrary.simpleMessage(
      "One special character",
    ),
    "passwordUppercase": MessageLookupByLibrary.simpleMessage(
      "One uppercase character",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "phone": MessageLookupByLibrary.simpleMessage("Phone"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "phoneRequired": MessageLookupByLibrary.simpleMessage("Phone is required"),
    "photoGallery": MessageLookupByLibrary.simpleMessage("Photo Gallery"),
    "presonalPhoto": MessageLookupByLibrary.simpleMessage("personal Photo"),
    "privacyPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Citifix protects your privacy. Citizen contact details are hidden from workers; they only receive the location and issue description.",
    ),
    "privacyPolicyTitle": MessageLookupByLibrary.simpleMessage(
      "Data Protection Policy",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("PROGRESS"),
    "progressTracking": MessageLookupByLibrary.simpleMessage(
      "Progress Tracking",
    ),
    "proofOfWork": MessageLookupByLibrary.simpleMessage("PROOF OF WORK *"),
    "quickApproveBtn": MessageLookupByLibrary.simpleMessage("Quick Approve"),
    "recentReport": MessageLookupByLibrary.simpleMessage("My Recent Reports"),
    "reference": MessageLookupByLibrary.simpleMessage("Reference:"),
    "rejectionReasonLabel": MessageLookupByLibrary.simpleMessage(
      "Rejection Reason",
    ),
    "rememberMe": MessageLookupByLibrary.simpleMessage("Remember me"),
    "reportDescription": MessageLookupByLibrary.simpleMessage(
      "Report Description",
    ),
    "reportDescriptionHint": MessageLookupByLibrary.simpleMessage(
      "Describe the details of the Report",
    ),
    "reportDetails": MessageLookupByLibrary.simpleMessage("Report Details"),
    "reportSentSuccess": MessageLookupByLibrary.simpleMessage(
      "Report sent successfully",
    ),
    "reportTitle": MessageLookupByLibrary.simpleMessage("Street hole"),
    "reportTitleHint": MessageLookupByLibrary.simpleMessage("Report title"),
    "reportTitleLabel": MessageLookupByLibrary.simpleMessage("Report Title"),
    "reportedBy": MessageLookupByLibrary.simpleMessage("Reported by"),
    "reportedImages": MessageLookupByLibrary.simpleMessage(
      "Original Reported Images",
    ),
    "reporter": MessageLookupByLibrary.simpleMessage("Reporter"),
    "reports": MessageLookupByLibrary.simpleMessage("Reports"),
    "requestSentSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Request sent successfully",
    ),
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend Code"),
    "resendCodeIn": MessageLookupByLibrary.simpleMessage("Resend Code In"),
    "resetPasswordPurpose": MessageLookupByLibrary.simpleMessage(
      "reset your password",
    ),
    "resolved": MessageLookupByLibrary.simpleMessage("Resolved"),
    "resolvedReports": MessageLookupByLibrary.simpleMessage("Resolved Reports"),
    "resubmit": MessageLookupByLibrary.simpleMessage("Resubmit Request"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "reupload": MessageLookupByLibrary.simpleMessage("Re-upload"),
    "reviewDesc": MessageLookupByLibrary.simpleMessage(
      "Your request is currently being reviewed by our team. We will notify you once the status is updated.",
    ),
    "reviewInformation": MessageLookupByLibrary.simpleMessage(
      "Review Information",
    ),
    "sample_address": MessageLookupByLibrary.simpleMessage(
      "842 Riverside Dr, Apt 4B",
    ),
    "sample_description": MessageLookupByLibrary.simpleMessage(
      "Emergency pipe burst reported in the main bathroom. High priority. Residents are currently on-site and have shut off the main valve.",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Save Changes"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Search for report..."),
    "searchHint1": MessageLookupByLibrary.simpleMessage(
      "Search for \"Water leak\"",
    ),
    "searchHint2": MessageLookupByLibrary.simpleMessage(
      "Search for \"Broken streetlight\"",
    ),
    "searchHint3": MessageLookupByLibrary.simpleMessage(
      "Search for \"Waste accumulation\"",
    ),
    "searchHint4": MessageLookupByLibrary.simpleMessage(
      "Search for \"Pothole repair\"",
    ),
    "searchHint5": MessageLookupByLibrary.simpleMessage(
      "Describe the issue...",
    ),
    "searchLocationHint": MessageLookupByLibrary.simpleMessage(
      "Search for a location",
    ),
    "searchMyReports": MessageLookupByLibrary.simpleMessage(
      "Search my reports",
    ),
    "searchPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Search reports...",
    ),
    "searchPothole": MessageLookupByLibrary.simpleMessage(
      "Search for \"Pothole repair\"",
    ),
    "searchStreetlight": MessageLookupByLibrary.simpleMessage(
      "Search for \"Broken streetlight\"",
    ),
    "searchTasksHint": MessageLookupByLibrary.simpleMessage(
      "Search for tasks...",
    ),
    "searchWaste": MessageLookupByLibrary.simpleMessage(
      "Search for \"Waste accumulation\"",
    ),
    "searchWaterLeak": MessageLookupByLibrary.simpleMessage(
      "Search for \"Water leak\"",
    ),
    "secureSession": MessageLookupByLibrary.simpleMessage(
      "SECURE SESSION • 08:42:11 REMAINING",
    ),
    "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
    "see_all": MessageLookupByLibrary.simpleMessage("See All"),
    "selectCategory": MessageLookupByLibrary.simpleMessage("Select Category"),
    "selectCategoryHint": MessageLookupByLibrary.simpleMessage(
      "Select Category",
    ),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("Select Language"),
    "selectRole": MessageLookupByLibrary.simpleMessage("Select a role"),
    "selectRoleError": MessageLookupByLibrary.simpleMessage(
      "Please select a role",
    ),
    "sendAnonymously": MessageLookupByLibrary.simpleMessage("Send Anonymously"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Send Code"),
    "sendReport": MessageLookupByLibrary.simpleMessage("Submit Report"),
    "sessionExpired": MessageLookupByLibrary.simpleMessage(
      "Session expired. Please login again",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("SETTINGS"),
    "showAllTasks": MessageLookupByLibrary.simpleMessage("Show all tasks"),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "signUpNow": MessageLookupByLibrary.simpleMessage("Sign up now"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "startTask": MessageLookupByLibrary.simpleMessage("Start Task"),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "statusApproved": MessageLookupByLibrary.simpleMessage("Approved"),
    "statusPending": MessageLookupByLibrary.simpleMessage("Pending"),
    "statusRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "stay_focused": MessageLookupByLibrary.simpleMessage(
      "Stay focused and let\'s get to work!",
    ),
    "step": MessageLookupByLibrary.simpleMessage("Step"),
    "submissionSummary": MessageLookupByLibrary.simpleMessage(
      "Submission Summary",
    ),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "submitMore": MessageLookupByLibrary.simpleMessage(
      "Submit Additional Info",
    ),
    "submitted": MessageLookupByLibrary.simpleMessage("Submitted:"),
    "submittedAtLabel": MessageLookupByLibrary.simpleMessage("Submitted"),
    "success": MessageLookupByLibrary.simpleMessage("Success"),
    "support": MessageLookupByLibrary.simpleMessage("Support"),
    "tapMapToChooseLocation": MessageLookupByLibrary.simpleMessage(
      "Tap the map or search to choose the report location.",
    ),
    "tapToScan": MessageLookupByLibrary.simpleMessage("Tap to scan"),
    "taskDetails": MessageLookupByLibrary.simpleMessage("Task Details"),
    "taskOwnerLabel": MessageLookupByLibrary.simpleMessage("• Task Owner"),
    "tasks": MessageLookupByLibrary.simpleMessage("Tasks"),
    "tasksSubtitle": MessageLookupByLibrary.simpleMessage(
      "Keep track of your daily progress",
    ),
    "termsCitizenCategory": MessageLookupByLibrary.simpleMessage(
      "Terms for Citizens",
    ),
    "termsWorkerCategory": MessageLookupByLibrary.simpleMessage(
      "Terms for Workers",
    ),
    "titleIsRequired": MessageLookupByLibrary.simpleMessage(
      "Title is required",
    ),
    "titleTooShort": MessageLookupByLibrary.simpleMessage(
      "Title must be at least 3 characters",
    ),
    "topAchievements": MessageLookupByLibrary.simpleMessage(
      "Top Achievement Reports",
    ),
    "totalReports": MessageLookupByLibrary.simpleMessage("TOTAL REPORTS"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "underReview": MessageLookupByLibrary.simpleMessage("Under Review"),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("Unknown Location"),
    "unknownStatus": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unread": MessageLookupByLibrary.simpleMessage("unread"),
    "updateDocuments": MessageLookupByLibrary.simpleMessage("Update Documents"),
    "updateYourId": MessageLookupByLibrary.simpleMessage(
      "Update your ID by EOD to keep access.",
    ),
    "uploadCompletionImages": MessageLookupByLibrary.simpleMessage(
      "Upload Completion Images",
    ),
    "urgent": MessageLookupByLibrary.simpleMessage("URGENT"),
    "verification": MessageLookupByLibrary.simpleMessage("Verification"),
    "verificationComplete": MessageLookupByLibrary.simpleMessage(
      "Verification Complete",
    ),
    "verificationFailed": MessageLookupByLibrary.simpleMessage(
      "Verification Failed",
    ),
    "verificationFailedDesc": MessageLookupByLibrary.simpleMessage(
      "Unfortunately, we couldn\'t verify your account based on the information provided.",
    ),
    "verificationGuide": MessageLookupByLibrary.simpleMessage(
      "Verification Guide",
    ),
    "verificationRequestsTitle": MessageLookupByLibrary.simpleMessage(
      "Verification Requests",
    ),
    "verificationSubTitle": MessageLookupByLibrary.simpleMessage(
      "Please complete the following data to verify your account as a professional worker",
    ),
    "verificationSuccessDesc": MessageLookupByLibrary.simpleMessage(
      "Your digital credentials have been successfully authenticated.",
    ),
    "verificationTitle": MessageLookupByLibrary.simpleMessage(
      "Account Verification",
    ),
    "verified": MessageLookupByLibrary.simpleMessage("VERIFIED"),
    "verifyNow": MessageLookupByLibrary.simpleMessage("Verify Now"),
    "viewAllRequests": MessageLookupByLibrary.simpleMessage(
      "View All Requests",
    ),
    "viewDetailsBtn": MessageLookupByLibrary.simpleMessage("View Details"),
    "viewDigitalBadge": MessageLookupByLibrary.simpleMessage(
      "View Digital Badge",
    ),
    "viewDirectionsUpdate": MessageLookupByLibrary.simpleMessage(
      "View Directions & Update",
    ),
    "view_details": MessageLookupByLibrary.simpleMessage("View Details"),
    "weeksAgo": m7,
    "welcome_message": MessageLookupByLibrary.simpleMessage("Welcome, "),
    "whatsNext": MessageLookupByLibrary.simpleMessage("What\'s Next?"),
    "whatsNextDesc": MessageLookupByLibrary.simpleMessage(
      "Your data and ID photos will be carefully checked. This process usually takes 24 to 48 business hours.",
    ),
    "worker": MessageLookupByLibrary.simpleMessage("Worker"),
    "workerConductDesc": MessageLookupByLibrary.simpleMessage(
      "1. Workers must upload \'Before\' and \'After\' photos for every task.\n2. Tasks must be completed within the assigned timeframe.\n3. Professional behavior is mandatory during site visits.",
    ),
    "workerConductTitle": MessageLookupByLibrary.simpleMessage(
      "Worker Standards & Conduct",
    ),
    "zone": MessageLookupByLibrary.simpleMessage("Zone"),
    "zoneAlpha": MessageLookupByLibrary.simpleMessage("Zone Alpha"),
  };
}
