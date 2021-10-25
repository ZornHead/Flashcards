import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/browse_cards_screen/browse_cards_screen.dart';
import 'package:flutter_app/screens/cancel_subs_reason_screen/cancel_subs_reason_screen.dart';
import 'package:flutter_app/screens/cancel_subscription_screen%20%20/cancel_subscription_screen.dart';
import 'package:flutter_app/screens/card_back_screen/card_back_screen.dart';
import 'package:flutter_app/screens/card_front_screen/card_fronts_screen.dart';
import 'package:flutter_app/screens/category_popup_screen/category_popup_screen.dart';
import 'package:flutter_app/screens/smartmix_card_fronts_screen%20/smartmix_card_fronts_screen%20.dart';
import 'package:flutter_app/screens/change_password_screen/change_password_screen.dart';
import 'package:flutter_app/screens/contact_screen/contact_screen.dart';
import 'package:flutter_app/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:flutter_app/screens/home_screen/home_screen.dart';
import 'package:flutter_app/screens/mental_practice_screen/mental_practice_screen.dart';
import 'package:flutter_app/screens/otp_screen/otp_screen.dart';
import 'package:flutter_app/screens/password_otp_screen/password_otp_screen.dart';
import 'package:flutter_app/screens/privacy_screen/privacy_screen.dart';
import 'package:flutter_app/screens/profile_otp_scrren/profile_otp_screen.dart';
import 'package:flutter_app/screens/profile_premium_screen/profile_premium_screen.dart';
import 'package:flutter_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter_app/screens/refer_friend_screen/refer_friend_screen.dart';
import 'package:flutter_app/screens/refer_via_friend_screen/refer_via_friend_screen.dart';
import 'package:flutter_app/screens/referred_friend_screen/referred_friend_screen.dart';
import 'package:flutter_app/screens/start_screen/start_screen.dart';
import 'package:flutter_app/screens/subscription_screen/subscription_screen.dart';
import 'package:flutter_app/screens/terms_services_screen/terms_services_screen.dart';
import 'package:flutter_app/screens/training_tip_screen/training_tip_screen.dart';

class AppRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityWidget(
        builder: (context, isOnline) => MaterialApp(
          title: 'MMA',
          theme: ThemeData(
            primaryColor: DayTheme.primaryColor,
            primarySwatch: DayTheme.primaryMaterialColor,
          ),
          initialRoute: HomeScreen.id,
          routes: {
            HomeScreen.id: (context) => Material(
                  child: HomeScreen(),
                ),
            ProfileScreen.id: (context) => Material(
                  child: ProfileScreen(),
                ),
            OtpScreen.id: (context) => Material(
                  child: OtpScreen(),
                ),
            PasswordOtpScreen.id: (context) => Material(
                  child: PasswordOtpScreen(),
                ),
            ProfileOtpScreen.id: (context) => Material(
                  child: ProfileOtpScreen(),
                ),
            EditProfileScreen.id: (context) => Material(
                  child: EditProfileScreen(),
                ),
            ProfilePremiumScreen.id: (context) => Material(
                  child: ProfilePremiumScreen(),
                ),
            CancelSubscriptionScreen.id: (context) => Material(
                  child: CancelSubscriptionScreen(),
                ),
            ChangePasswordScreen.id: (context) => Material(
                  child: ChangePasswordScreen(),
                ),
            ReferFriendScreen.id: (context) => Material(
                  child: ReferFriendScreen(),
                ),
            ReferViaFriendScreen.id: (context) => Material(
                  child: ReferViaFriendScreen(),
                ),
            TermsServiesScreen.id: (context) => Material(
                  child: TermsServiesScreen(),
                ),
            PrivacyScreen.id: (context) => Material(
                  child: PrivacyScreen(),
                ),
            SubscriptionScreen.id: (context) => Material(
                  child: SubscriptionScreen(),
                ),
            ContactScreen.id: (context) => Material(
                  child: ContactScreen(),
                ),
            CancelSubsReasonScreen.id: (context) => Material(
                  child: CancelSubsReasonScreen(),
                ),
            ReferredFriendScreen.id: (context) => Material(
                  child: ReferredFriendScreen(),
                ),
            MentalPracticeScreen.id: (context) => Material(
                  child: MentalPracticeScreen(),
                ),
            StartScreen.id: (context) => Material(
                  child: StartScreen(),
                ),
            BrowseCardScreen.id: (context) => Material(
                  child: BrowseCardScreen(),
                ),
            CardBack.id: (context) => Material(
                  child: CardBack(),
                ),
            CardFronts.id: (context) => Material(
                  child: CardFronts(),
                ),
            SmartMixCardFronts.id: (context) => Material(
                  child: SmartMixCardFronts(),
                ),
            TrainingTipScreen.id: (context) => Material(
                  child: TrainingTipScreen(),
                ),
            CategoryPopupScreen.id: (context) => Material(
                  child: CategoryPopupScreen(),
                ),
          },
        ),
      ),
    );
  }
}
