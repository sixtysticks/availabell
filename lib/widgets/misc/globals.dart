library availabell.globals;

// HARD CODINGS
const hardcodedLat = 52.5807836;
const hardcodedLon = -1.8247012;

// Measurements
const double halfSpacer = 10.0;
const double spacer = 20.0;

// Global Strings
const String appName = 'Availabell';
const String brandFontName = 'SpicyRice';
const String defaultFontName = 'Muli';

// Add details view
const String addDetailsTitle = 'Add your details';
const String firstNameLabel = 'First name';
const String lastNameLabel = 'Last name';
const String jobTitleLabel = 'Job title';
const String jobTypeLabel = 'Job type';
const String locationLabel = 'Location';
const String skillsLabel = 'Skills';
const String urlLabel = 'Personal website';
const String finishLabel = 'Finish';
const String fullTimeLabel = "Full-time";
const String contractLabel = "Contract";
const String partTimeLabel = "Part-time";
const String temporaryLabel = "Temporary";

// Route Names
const String homeRoute = '/home';
const String loginRoute = '/login';
const String addDetailsRoute = '/add-details';

// Assets
const avLogo = 'assets/images/availabell-logo.png';
const linkedInLogo = 'assets/images/linkedin-sign-in-default.png';

// JobSeekers
const String noJobSeekersLabel = 'There are none of your connections currently looking for work';

// Auth
const redirectURI = 'https%3A%2F%2Fwww.sixtysticks.com';
const clientId = '86gw6a7a4e0w0n';
const clientSecret = '4nCGOklo8jHzmeaX';
const mapBoxAccessToken = 'pk.eyJ1Ijoic2l4dHlzdGlja3MiLCJhIjoiY2tpcTBmN3dlMDJ0OTMyb2J1aDExbG5qMSJ9.DJTYede_CwfUL5v0azTL_A';
const linkedInLoginUrl =
    'https://www.linkedin.com/oauth/v2/authorization?response_type=code&state=0JTNhg9rVsZ3tCqS7sUHsUMQs3oJMduVFDNFBGm8&scope=r_liteprofile&client_id=${clientId}&redirect_uri=${redirectURI}';

// Firebase
const firebaseUrlJobSeekers = 'https://availabell-666-default-rtdb.europe-west1.firebasedatabase.app/jobseekers.json';
