From: David Howells <dhowells@redhat.com>
Date: Tue, 03 Sep 2019 22:39:08 +0000
Subject: Re: [PATCH 11/11] smack: Implement the watch_key and post_notification hooks [untested] [ver #7]
Message-Id: <14969.1567550348@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <23d61564-026e-b37a-8b16-ce68d5949f6c@schaufler-ca.com> <87bf0363-af77-1e5a-961f-72730e39e3a6@schaufler-ca.com> <e36fa722-a300-2abf-ae9c-a0246fc66d0e@schaufler-ca.com> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk> <156717352917.2204.17206219813087348132.stgit@warthog.procyon.org.uk> <4910.1567525310@warthog.procyon.org.uk> <11467.1567534014@warthog.procyon.org.uk>
In-Reply-To: <23d61564-026e-b37a-8b16-ce68d5949f6c@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, Stephen Smalley <sds@tycho.nsa.gov>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> I rebuilt with keys-next, updated the tests again, and now
> the suite looks to be running trouble free.

Glad to hear that, thanks.

> I do see a message SKIP DUE TO DISABLED SELINUX which I take to mean that
> there is an SELinux specific test.

tests/bugzillas/bz1031154/runtest.sh

David
