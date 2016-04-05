# CHCertificate

CHCertificate makes working with X509 certificates a breeze!

## Prerequisites

CHCertificate requires OpenSSL-Universal.  It's as easy as adding it to your podfile:

```ruby
target 'Your Awesome App' do

pod 'OpenSSL-Universal', '1.0.1.18'

end
```

## Installing:

1. Drag `CHCertificate.m` and `CHCertificate.h` onto your project in Xcode
2. Compile
3. There is no step three 🎉

## Documentation

### Creating a certificate:

There are two ways to create CHCertificate objects:

```objectivec
- (void) fromURL:(NSString *)URL finished:(void (^)(NSError * error, NSArray<CHCertificate *>* certificates))finished
+ (CHCertificate *) withCertificateRef:(SecCertificateRef)cert
```

`fromURL:finished:` takes all of the leg work of dealing with NSURLSessions and makes it easy -
you give us a URL and we'll give you an array of CHCertificates for the entire certificate chain!

```objectivec
self.certificates = [NSArray<CHCertificate *> new];
[[CHCertificate alloc] fromURL:@"https://www.google.com" finished:^(NSError *error, NSArray<CHCertificate *> *certificates, BOOL trustedChain) {
    if (error) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertController animated:YES completion:nil];
        });
    } else {
        self.certificates = certificates;
    }
}];
```

Now that's easy!

`withCertificateRef:` can be used if you need to manage the URLSessions yourself. Give us the `SecCertificateRef` and we'll take care of the rest.

### Verifying certificate:

Need to check fingerprints? CHCertificate makes it easy! Use:

```objectivec
- (NSString *) SHA256Fingerprint;
- (NSString *) MD5Fingerprint; // Not safe!
- (NSString *) SHA1Fingerprint; // Not safe!
```

Verify certificate issue dates with:

```objectivec
- (NSDate *) notAfter;
- (NSDate *) notBefore;
- (BOOL) validIssueDate;
```

Want to test if a cert chain is trusted?

```objectivec
// from within URLSession:didReceiveChallenge:completionHandler:
SecTrustRef trust = challenge.protectionSpace.serverTrust;
BOOL trusted = [CHCertificate trustedChain:trust];
```

### Certificate pinning

You can easily perform certificate pinning without the need for `.cer` of other PKCS files by verifiying the SHA256 fingerprint of the cert.

```objectivec
CHCertificate * certificate = ...
NSString * expectedFingerprint = @"14 4C E1 52 91 5B AA D2 33 C5 FE 21 57 35 98 B3 66 87 17 3B B7 5A EC 04 CC 63 53 50 66 18 59 F8";
BOOL verified = [certificate verifyFingerprint:expectedFingerprint type:kFingerprintTypeSHA256];
if (verified) {
    // All clear!
} else {
    // Uh oh!
    // Don't be a jerk - Preventing use of the application due to a different certificate is DRM!
    // And we all know that DRM is EVIL! 👺
}
```