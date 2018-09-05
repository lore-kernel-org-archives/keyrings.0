From: Ken Bassford <kbassford@apertussolutions.com>
Date: Wed, 05 Sep 2018 17:39:16 +0000
Subject: Possible bug found in request-key configuration.
Message-Id: <165aad11ebf.b40d2a0c16761.7731136507248448449@apertussolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Ladies and Gentlemen,

Forgive me if this is not the proper place to post this question, it was the only place I have access to that I could be sure would not end up in a unmaintained dead end.

I have been working on a storage allocation scheme running under OpenXT; and I appear to have uncovered a bug in keyutils-1.5.10 wherein a config file placed under '/etc/request-key.d/' (keymgmt.conf for keys with a "keymgmt" prefix) will not be detected, but if I copy the same lines from that config file, and append them to the end of '/etc/request-key.conf', the key request is executed as expected.  I don't believe this is the manner it is intended to work according to "request-key.conf(5)".

Thank you in advance for your time.

Sincerely,
Ken Bassford
Apertus Solutions
