From: David Howells <dhowells@redhat.com>
Date: Wed, 14 Nov 2018 18:00:22 +0000
Subject: keyutils-1.6 released
Message-Id: <25167.1542218422@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org

I have tagged and push keyutils v1.6 to:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git

Significant changes since v1.5.11 include:

 - When scanning its config files to find a helper to execute, request-key now
   takes the match with the least number of characters matching a wildcard
   rather than the first match.

   This allows a more specific match on a particular type to be installed that
   overrides a general match (say with the DNS resolver).

 - request-key has an additional flag that allows helper execution to be
   suppressed to make config debugging easier.

 - Support in keyctl for public key operations using asymmetric-type keys
   (requires kernel v4.20).

 - The dependency on MIT Kerberos is removed.

 - Added pkg-config spec for libkeyutils.

David
