#!/bin/bash
# Adds a security certificate to the system keychain and manually sets as trusted
# Assumes certificate has already been placed on machine

TARGET_KEYCHAIN="/Library/Keychains/System.keychain"
CERT_PATH="/private/tmp/radius.com.cer"

security add-trusted-cert -d -k "$TARGET_KEYCHAIN" "$CERT_PATH"