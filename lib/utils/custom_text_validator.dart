import '../model/user.dart';

class TextValidator {
  String? validate(String? value, bool isCustomField, BasicData basicData) {
    if (value == null || value == '' && isCustomField) {
      return 'Body is required';
    }
    // print(basicData.accountName);
    value = value.toString().toLowerCase();
    switch (basicData.accountName) {
      case 'twitter':
        {
          if (!(value.startsWith('https://www.twitter.com/') ||
              value.startsWith('@'))) {
            return 'Please enter a valid Username or URL';
          } else if (!value.startsWith('https://') && !value.startsWith('@')) {
            return 'Please enter username starting with @';
          }
          return null;
        }
      case 'facebook':
        {
          if (value.isEmpty) return null;
          if (value.startsWith('https://') &&
              !value.startsWith('https://www.facebook.com/')) {
            return 'Please enter a valid username or URL';
          } else {
            return null;
          }
        }
      case 'linkedin':
        {
          if (value.isEmpty) return null;
          if (!value.startsWith('https://www.linkedin.com/')) {
            return 'Please enter a valid username or URL';
          } else {
            return null;
          }
        }
      case 'instagram':
        {
          if (value.isEmpty) return null;
          if (value.startsWith('https://') &&
              !value.startsWith('https://www.instagram.com/')) {
            return 'Please enter a valid username or URL';
          } else {
            return null;
          }
        }
      case 'youtube':
        {
          if (value.isEmpty) return null;
          if (!value.startsWith('https://www.youtube.com/')) {
            return 'Please enter a valid username or URL';
          } else {
            return null;
          }
        }
      case 'tumblr':
        {
          if (value.isEmpty) return null;
          if (value.startsWith('https://') &&
              !value.startsWith('https://www.tumblr.com/blog/view/')) {
            return 'Please enter a valid username or URL';
          } else {
            return null;
          }
        }
      case 'medium':
        {
          if (value.isEmpty) return null;
          if ((value.startsWith('https://') && !(value.contains('medium')))) {
            return 'Please enter a valid username or URL';
          } else if (!value.startsWith('https://') && value.startsWith('@')) {
            return 'Please enter username without @';
          } else {
            return null;
          }
        }
      case 'tiktok':
        {
          if (value.isEmpty) return null;
          if (value.startsWith('https://') &&
              !value.startsWith('https://www.tiktok.com/')) {
            return 'Please enter a valid username or URL';
          } else if (!value.startsWith('https://') && !value.startsWith('@')) {
            return 'Please enter username starting with @';
          } else {
            return null;
          }
        }
      case 'snapchat':
        {
          if (value.isEmpty) return null;
          if (!value.startsWith('https://www.snapchat.com/')) {
            return 'Please enter a valid username or URL';
          } else {
            return null;
          }
        }
      case 'pinterest':
        {
          if (value.isEmpty) return null;
          if (value.startsWith('https://') &&
              !value.startsWith('https://pin.it/')) {
            return 'Please enter a valid username or URL';
          } else if (!value.startsWith('https://') && value.startsWith('@')) {
            return 'Please enter username without @';
          } else {
            return null;
          }
        }
      case 'github':
        {
          if (value.isEmpty) return null;
          if (value.startsWith('https://www.github.com/')) {
            return 'Please enter a valid username or URL';
          } else {
            return null;
          }
        }

      case 'steam':
        {
          if (value.isEmpty) return null;
          if (value.startsWith('https://') &&
              !value.startsWith('https://steamcommunity.com/')) {
            return 'Please enter a valid username or URL';
          } else {
            return null;
          }
        }
      case 'discord':
        {
          if (value.isEmpty) return null;
          if (value.startsWith('https://') &&
              !value.startsWith('https://www.discord.com/users/')) {
            return 'Please enter a valid username or URL';
          } else if (!value.startsWith('https://') && !value.contains('#')) {
            return 'Please enter a valid username';
          } else {
            return null;
          }
        }
      case 'twitch':
        {
          if (value.isEmpty) return null;
          if (value.startsWith('https://') &&
              !value.startsWith('https://www.twitch.tv/')) {
            return 'Please enter a valid username or URL';
          } else {
            return null;
          }
        }
      default:
        break;
    }
    return null;
  }
}
