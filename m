From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 06 Jun 2019 14:33:06 +0000
Subject: Re: [PATCH 09/10] usb: Add USB subsystem notifications [ver #3]
Message-Id: <20190606143306.GA11294@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155981420247.17513.18371208824032389940.stgit@warthog.procyon.org.uk>
 <Pine.LNX.4.44L0.1906061020000.1641-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1906061020000.1641-100000@iolanthe.rowland.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk, linux-usb@vger.kernel.org, raven@themaw.net, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-block@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:24:18AM -0400, Alan Stern wrote:
> On Thu, 6 Jun 2019, David Howells wrote:
> 
> > Add a USB subsystem notification mechanism whereby notifications about
> > hardware events such as device connection, disconnection, reset and I/O
> > errors, can be reported to a monitoring process asynchronously.
> 
> USB I/O errors covers an awfully large and vague field.  Do we really
> want to include them?  I'm doubtful.

See the other patch on the linux-usb list that wanted to start adding
KOBJ_CHANGE notifications about USB "i/o errors".

So for "severe" issues, yes, we should do this, but perhaps not for all
of the "normal" things we see when a device is yanked out of the system
and the like.

thanks,

greg k-h
