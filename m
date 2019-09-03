From: David Howells <dhowells@redhat.com>
Date: Tue, 03 Sep 2019 16:29:21 +0000
Subject: Re: [PATCH 08/11] usb: Add USB subsystem notifications [ver #7]
Message-Id: <29419.1567528161@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190903161202.GB22754@roeck-us.net> <20190903125129.GA18838@roeck-us.net> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk> <156717350329.2204.7056537095039252263.stgit@warthog.procyon.org.uk> <7481.1567526867@warthog.procyon.org.uk>
In-Reply-To: <20190903161202.GB22754@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> wrote:

> > > This added call to usbdev_remove() results in a crash when running
> > > the qemu "tosa" emulation. Removing the call fixes the problem.
> > 
> > Yeah - I'm going to drop the bus notification messages for now.
> > 
> It is not the bus notification itself causing problems. It is the
> call to usbdev_remove().

Unfortunately, I don't know how to fix it and don't have much time to
investigate it right now - and it's something that can be added back later.

David
