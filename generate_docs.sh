#!/bin/sh

jazzy \
 --objc \
 --clean \
 --author "Certificate Helper" \
 --author_url https://github.com/certificate-helper \
 --github_url https://github.com/certificate-helper/CertificateKit \
 -r https://tlsinspector.com/docs/index.html \
 -d https://tlsinspector.com/docs/docsets/CertificateKit.xml \
 --module-version 1.0.0 \
 --module CertificateKit \
 --umbrella-header CertificateKit/CertificateKit.h \
 --framework-root .
