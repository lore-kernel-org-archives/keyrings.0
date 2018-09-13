From: David Howells <dhowells@redhat.com>
Date: Thu, 13 Sep 2018 14:08:37 +0000
Subject: [PATCH 0/3] keyutils: request_key and DNS resolver changes
Message-Id: <153684771698.10049.12488548190876920608.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-security-module@vger.kernel.org


Here's a set of keyutils patches that makes it possible to override the DNS
resolver (or any other upcall target).  This allows the kafs-utils package to
override requests to the dns resolver and make use of static configuration in
addition to DNS lookups.  This allows this function to be moved out of
keyutils and allows the dependency on krb5 to be removed.

The following changes are made:

 (1) request-key now has better command-line option support for debugging the
     configuration.

 (2) request-key now reads all its config files and searches for the best
     match rather than the first match.

     'Best match' is defined as the match with the least number of characters
     skipped by a wildcard, first in the left most column, then in the next
     column and so on.

     So in the following two config lines:

    	create  dns_resolver *		*	/sbin/key.dns_resolver %k
	create  dns_resolver afsdb:*	*	/sbin/dns_afsdb %k

     For dns_resolver keys, the second line is preferred if the description
     matches "afsdb:*" - no matter the order in which they're encountered -
     but the first line will be used otherwise.

 (3) The AFS cellservdb config file parsing is removed from key.dns_resolver
     and the dependencies for the krb5 profile functions are dropped.
    
The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git

on branch next (bottom 3 patches).

Thanks,
David
---
David Howells (3):
      request-key: Provide a command line option to suppress execution
      request-key: Find best match rather than first match
      Remove the dependency on MIT Kerberos


 Makefile               |    2 
 dns.afsdb.c            |  268 ++++---------------------------
 keyutils.spec          |    2 
 man/request-key.8      |   31 +++-
 man/request-key.conf.5 |   36 ++--
 request-key.c          |  419 +++++++++++++++++++++++++++++-------------------
 6 files changed, 336 insertions(+), 422 deletions(-)
