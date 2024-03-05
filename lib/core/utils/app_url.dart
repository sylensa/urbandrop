import 'package:flutter/material.dart';
import 'package:urbandrop/flavor_settings.dart';

 String websiteBaseURL = "https://dev.showout.studio/cards/";
 String apiKey = "fgy6435678hghytr534qwe567890poijhgyftr543wesdrtfyu";

class AppUrl {
  static const String liveBaseURL = "https://api.showout.studio/";
  static const String qaBaseURL = "https://apidev.showout.studio/";
  // static const String qaBaseURL = "https://fd1f-176-58-104-20.ngrok-free.app/";
  static const String localBaseURL = "http://127.0.0.1:8000/api/";

  static const String websocketWS = "ws://127.0.0.1:6001/app/adeo_key";
  static const String websocketWSS = "wss://adeo.app:6001/app/adeo_key";

  static const String websocket = websocketWS;

  static String baseURL = FlavorSettings.apiBaseUrl;
  static String userLogin = "${baseURL}auth/login";
  static String userAppleLogin = "${baseURL}auth/apple-login";
  static String verifyUserDocs = "${baseURL}user/verify-docs";
  static String userFacebookLogin = "${baseURL}auth/facebook-login";
  static String userGoogleLogin = "${baseURL}auth/google-login";
  static String userRegister = "${baseURL}user/create";
  static String userUpdate = "${baseURL}user";
  static String createFolder = "${baseURL}folder/create";
  static String addCardsToFolder = "${baseURL}folder/add-card";
  static String removeCardsToFolder = "${baseURL}folder/remove-card";
  static String createCard = "${baseURL}card/create";
  static String createListCard = "${baseURL}card-listings";
  static String getListCardChild = "${baseURL}card-listings/child-listings";
  static String joinPlaylist = "${baseURL}playlist/join";
  static String loadFromCard = "${baseURL}payments/load-from-listed-cards";
  static String withdrawals = "${baseURL}withdrawals";
  static String userVerify = "${baseURL}auth/verify";
  static String userVerifyWeavr = "${baseURL}weavr/verify-email";
  static String tokenizedCard = "${baseURL}weavr/tokenized-card";
  static String blockWeavrCard = "${baseURL}weavr/block-card";
  static String unBlockWeavrCard = "${baseURL}weavr/unblock-card";
  static String userVerifyOTP = "${baseURL}auth/verify-otp";
  static String userVerifyWeavrOTP = "${baseURL}weavr/verify-mobile";
  static String userSendOTP = "${baseURL}auth/send-otp";
  static String userSendWeavrOTP = "${baseURL}auth/send-weavr-otp";
  static String verifyPasscode = "${baseURL}auth/verify-passcode";
  static String changePasscode = "${baseURL}user/change-passcode";
  static String changePassword = "${baseURL}user/change-password";
  static String resendVerification = "${baseURL}auth/resend-verification-code";
  static String resendWeavrEmailVerification = "${baseURL}auth/resend-weavr-verification-code";
  static String getUser = "${baseURL}user";
  static String config = "${baseURL}config";
  static String readNotification = "${baseURL}notifications/mark-read";
  static String getUserNotifications = "${baseURL}notifications/list";
  static String checkStageName = "${baseURL}user/check-profile-name";
  static String refreshToken = "${baseURL}auth/refresh-token";
  static String forgotPassword = "${baseURL}auth/forgot-password";
  static String getRandomCards = "${baseURL}card/random";
  static String getAds = "${baseURL}ads";
  static String getSearchCards = "${baseURL}card/search";
  static String getCardList = "${baseURL}card/list";
  static String getCardPlayList = "${baseURL}playlist";
  static String getPopularCardList = "${baseURL}card/popular";
  static String getTrendingCardList = "${baseURL}card/trending";
  static String geRecentlyPlayedCardList = "${baseURL}card/recently-played";
  static String getCardsGenre = "${baseURL}card/genres";
  static String hotometerValues = "${baseURL}card/hotometer-values";
  static String cardTransaction = "${baseURL}card/transactions";
  static String usersTransaction = "${baseURL}user/transactions";
  static String ownedCards = "${baseURL}card/owned";
  static String recentReleasedCards = "${baseURL}card/list";
  static String topEarningCards = "${baseURL}card/top-earning";
  static String bidList = "${baseURL}card-listings/bids";
  static String likeCard = "${baseURL}card/like";
  static String cardListing = "${baseURL}card-listings";
  static String dislikeCard = "${baseURL}card/dislike";
  static String favourite = "${baseURL}card/favorite";
  static String unFavourite = "${baseURL}card/unfavorite";
  static String cardPlay = "${baseURL}song/play";
  static String leavePlaylist = "${baseURL}playlist/leave";
  static String createSong = "${baseURL}song/create";
  static String listSongs = "${baseURL}song/list";
  static String listFolders = "${baseURL}folder/list";
  static String getFolder = "${baseURL}folder";
  static String cardListingActivity = "${baseURL}card-listings/activity";
  static String hotPick = "${baseURL}card/hot-pick";
  static String card = "${baseURL}card";
  static String userFollow = "${baseURL}user/follow";
  static String blockUser = "${baseURL}user/block";
  static String reportUser = "${baseURL}user/report";
  static String userFollowers = "${baseURL}user/followers";
  static String userFollowings = "${baseURL}user/followings";
  static String knowledgebase = "${baseURL}kb/list";
  static String chatNotification = "${baseURL}user/send-chat-notification";
  static String userTimeline = "${baseURL}card-listings/timeline";
  static String likeActivity = "${baseURL}card-listings/activity/like";
  static String disLikeActivity = "${baseURL}card-listings/activity/dislike";
  static String favouriteActivity = "${baseURL}card-listings/activity/favorite";
  static String viewedActivity = "${baseURL}card-listings/activity/mark-viewed";
  static String unFavoriteActivity = "${baseURL}card-listings/activity/unfavorite";
  static String explore = "${baseURL}card/explore";
  static String cardHolders = "${baseURL}card/holders";
  static String cardWatchers= "${baseURL}card/watchers";
  static String creditCard= "${baseURL}payments/load-from-credit-card";
  static String bankAccount= "${baseURL}payments/bank-account";
  static String paymentCard= "${baseURL}payments/payment-card";
  static String virtualCard= "${baseURL}weavr/request-virtual-card";
  static String paymentEntities= "${baseURL}payments/entities";
  static String listBankAccount= "${baseURL}payments/bank-account/list";
  static String search= "${baseURL}search";
  static String getForYou= "${baseURL}for-you";
  static String tradeRequest= "${baseURL}card-listings/trade/requests";
  static String acceptTradeRequest= "${baseURL}card-listings/trade/accept";
  static String confirmTradeRequest= "${baseURL}card-listings/trade/confirm";
  static String counterTradeRequest= "${baseURL}card-listings/trade/counter";
  static String declineTradeRequest= "${baseURL}card-listings/trade/decline";
  static String startKyc= "${baseURL}weavr/kyc";
  static String refreshWeavrToken= "${baseURL}auth/refresh-weavr-token";
  static String headersList= "${baseURL}headers/list";
  static String cardMetrics= "${baseURL}user/card-metrics";


  static String websocketIpURL =
      "ws://18.185.228.99:6001/app/programmers@shammah/websocket";

  static String googleLogin = "${baseURL}google/signin";
  static const String bannerAdUnitIdAndroid =
      "ca-app-pub-3198630326946940~5162048290";
  static const String bannerAdUnitIdiOS =
      "ca-app-pub-3198630326946940~5162048290";
}

class FirebaseString {
  static String chatList = 'ChatList';
  static String tradeChatList = 'TradeChatList';
  static String messages = 'messages';
  static String myChat = 'MyChat';
  static String tradeChat = 'TradeChat';
  static String chat = 'Chat';
  static String trade = 'trade';
  static String searchMessages = 'SearchMessages';
  static String tradeSearchMessages = 'TradeSearchMessages';
}


class UploadingFileIndicator extends StatelessWidget {
  final String title;
  const UploadingFileIndicator({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Center(
        child: Stack(
          fit: StackFit.expand,
          children: const [
            CircularProgressIndicator(
              strokeWidth: 10,
              backgroundColor: Colors.white,
              color: Color(0xFF006437),
            ),
            Center(
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: Icon(Icons.upload_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
