// ignore_for_file: constant_identifier_names

enum MessageEnum {
  TEXT('TEXT'),
  IMAGE('IMAGE'),
  AUDIO('AUDIO'),
  VIDEO('VIDEO'),
  GIF('GIF');

  // Enhanced Enums
  const MessageEnum(this.type);
  final String type;
}

// To convert string to enum and enum to string

// Using an extension
extension ConvertMessage on String {
  MessageEnum toEnum() {
    // this will give the string value on which the extension was used
    switch (this) {
      case 'AUDIO':
        return MessageEnum.AUDIO;
      case 'VIDEO':
        return MessageEnum.VIDEO;
      case 'TEXT':
        return MessageEnum.TEXT;
      case 'IMAGE':
        return MessageEnum.IMAGE;
      case 'GIF':
        return MessageEnum.GIF;
      default:
        return MessageEnum.TEXT;
    }
  }
}
