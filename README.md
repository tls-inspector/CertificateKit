# CHCertificate

CHCertificate makes working with X509 certificates a breeze!

# Installing

Because CHCertificate uses static libraries, we cannot use Cocoapods.

## Quick & Easy

Download & extract `CHCertificate.framework` from the releases section and drag it onto your app.

## The hard way

CHCertificate requires OpenSSL-Universal.  It's as easy as adding it to your podfile:

```ruby
target 'Your Awesome App' do

pod 'OpenSSL-Universal'

end
```

1. Drag `CHCertificate.m` and `CHCertificate.h` onto your project in Xcode
2. Compile
3. There is no step three 🎉

## Documentation

### Creating a certificate:

The current way to get CHCertificates is using `certificateChainFromURL:finished:`.

```objectivec
+ (void) certificateChainFromURL:(NSURL *)URL finished:(void (^)(NSError * error,
                                                                 NSArray<CHCertificate *> * certificates,
                                                                 BOOL trustedChain))finished;
```

This will query the web server (bypassing ATS & other restriction) and get the certificate chain.

```objectivec
[NSThread detachNewThreadWithBlock:^{
    [CHCertificate certificateChainFromURL:[NSURL URLWithString:@"https://www.google.com/"] finished:^(NSError *error, NSArray<CHCertificate *> *certificates, BOOL trustedChain) {
        if (error) {
            // Handle the error. Error codes are in the enum CHCertificateError
        } else {
            // Start using the certificates, trusted chain is if the system indicated that the chain
            // is valid by the systems certificate store.
        }
    }];
}];
```

Now that's easy!

### Verifying certificate:

Need to check fingerprints? CHCertificate makes it easy! Use:

```objectivec
- (NSString *) SHA512Fingerprint; // Maybe a bit overkill
- (NSString *) SHA256Fingerprint; // Just right!
- (NSString *) MD5Fingerprint; // Not safe!
- (NSString *) SHA1Fingerprint; // Not safe!
```

Want to verify a certificates fingerprints? We provide you with a function just for that:

```objectivec
- (BOOL) verifyFingerprint:(NSString *)fingerprint type:(CHCertificateFingerprintType)type;
```

`verifyFingerprint:type:` will strip all non-alphanumeric characters, and verify the lowercase
strings if they match. Perfect for when you are dealing with systems that use different formats
for certificate fingerprints.

Verify certificate issue dates with:

```objectivec
- (NSDate *) notAfter;
- (NSDate *) notBefore;
- (BOOL) validIssueDate;
```

### Certificate pinning

You can easily perform certificate pinning without the need for `.cer` of other PKCS files by
verifying the SHA256 fingerprint of the cert.

```objectivec
CHCertificate * certificate = ...
NSString * expectedFingerprint = @"14 4C E1 52 91 5B AA D2 33 C5 FE 21 57 35 98 B3 66 87 17 3B B7 5A EC 04 CC 63 53 50 66 18 59 F8";
BOOL verified = [certificate verifyFingerprint:expectedFingerprint type:CHCertificateFingerprintTypeSHA256];
if (verified) {
    // All clear!
} else {
    // Uh oh!
    // Don't be a jerk - Preventing use of the application due to a different certificate is DRM!
    // And we all know that DRM is EVIL! 👺
}
```
