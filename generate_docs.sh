#!/bin/sh

jazzy \
 --objc \
 --clean \
 --author "Certificate Helper" \
 --author_url https://github.com/certificate-helper \
 --github_url https://github.com/certificate-helper/CertificateKit \
 --module-version 1.0.0 \
 --module CertificateKit \
 --umbrella-header CertificateKit/CertificateKit.h \
 --framework-root .
