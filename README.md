# CertificateKit

CertificateKit is an advanced iOS library for working with SSL/TLS X.509 certificates. It's primarily used within the [TLS Inspector iOS app](https://tlsinspector.com) but can be used in any iOS project.

The primary goal with CertificateKit is to provide an easy-to-use front-end to OpenSSLs X.509 APIs.

## Installation

**Due to the complex nature of CertificateKit, it cannot be installed using Cocoapods and must be installed manually.**

 1. Download the Latest Release
 2. Add the `CertificateKit.framework` file to your project by dragging and dropping it onto the Project Navigator in Xcode

## Getting Started

To get a chain of certificates (Root, Intermediate, and Server) for a given URL:

```objc
self.chain = [CKCertificateChain new];

[self.chain
 certificateChainFromURL:[NSURL URLWithString:@""]
 finished:^(NSError * _Nullable error, CKCertificateChain * _Nullable chain) {
     if (error) {
         // Do something
     }

     // Is the chain trusted
     switch (chain.trusted) {
         case CKCertificateChainTrustStatusTrusted:
             // Trusted by system
             break;
         case CKCertificateChainTrustStatusUntrusted:
             // Untrusted by system
             break;
     }

     // Is the server certificate revoked
     if (chain.server.revoked.isRevoked) {
         // Print the reason why it was revoked
         NSLog(@"%@", chain.server.revoked.reasonString);
     }
 }];
```

```swift
let chain: CKCertificateChain = CKCertificateChain()

chain.certificateChain(from: URL(string: "")!) { (error, chain) in
    if error != nil {
        // Do something
    }

    // Is the chain trusted
    if let trust: CKCertificateChainTrustStatus = chain?.trusted {
        switch trust {
            case .trusted:
                // Trusted by system
            break
            case .untrusted:
                // Untrusted by system
            break
        }
    }

    // Is the server certificate revoked
    if chain?.server?.revoked.isRevoked ?? false {
        let reasonString = chain?.server?.revoked.reasonString
        print(reasonString)
    }
}
```
