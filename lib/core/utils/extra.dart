import 'package:intl/intl.dart';

const kTextPlaceholder =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';
const kUrlImagePlaceholder =
    "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80";

const kLongTextPlaceHolder =
    "Chief Joseph Olaitan Adenuga Jr.[1] (born 19 September 1982), known professionally as Skepta, is a British-Nigerian grime MC, rapper and"
    " record producer. Alongside his younger brother Jme, "
    "he briefly joined Roll Deep before becoming founding members of Boy Better"
    " Know in 2005. With Boy Better Know, Skepta clashed with fellow MC Devilman for "
    "the video release Lord of the Mics 2, in what is remembered as one of the biggest"
    " clashes in grime history.[2][3] Skepta released his debut studio album Greatest "
    "Hits in 2007 and his second album, Microphone Champion in 2009, both independently; "
    "while his third studio album Doin' It Again was released in 2011 by AATW. He made his "
    "acting debut in the 2015 film Anti-Social. Skepta's fourth studio album, Konnichiwa (2016), "
    "featured the hit singles";

const kValueNotice =
    "In financial markets, a share is a unit used as mutual funds, limited partnerships, and real estate investment trusts. Share capital refers to all of the shares of an enterprise. The owner of shares in the company is a shareholder (or stockholder) of the corporation.";

String getDurationTime(Duration duration) {
  int min = (duration.inSeconds / 60).floor();
  int sec = duration.inSeconds % 60;
  return "${NumberFormat('00').format(min)}:${NumberFormat('00').format(sec)}";
}
