# Simple Share

A Flutter plugin for share file (image, PDF, video, ecc) or text.

## Installation

To use the plugin, add `simple_share` as a
[dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Usage

For share file: 

```SimpleShare.share(uri: uri.toString());```

For share file with subject (like in Gmail)

```SimpleShare.share(uri: uri.toString(), subject: "subject example");```

For share text: 

```SimpleShare.share(msg: "shared Text");```

For share text with subject (like in Gmail)

```SimpleShare.share(msg: "My message"", subject: "subject example");```


## Example

See the [example application](https://github.com/giandifra/simple_share/tree/master/example) source
for a complete sample app using the Simple RSA encryption.