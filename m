From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Aug 2018 11:07:00 +0000
Subject: Re: [PATCH v5 06/12] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <13701.1533208020@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <7f826777-c9bd-d602-a8d5-613adc6b4a94@intel.com>
 <4d79bd7b-c992-8259-2408-100756b9983e@intel.com>
 <0a5ba1eb-01d2-b0f2-5e67-262fdb488bb7@intel.com>
 <153186087803.27463.7423668214880824595.stgit@djiang5-desk3.ch.intel.com>
 <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
 <9360.1531912457@warthog.procyon.org.uk>
 <19525.1531988520@warthog.procyon.org.uk>
 <9090.1532101203@warthog.procyon.org.uk>
In-Reply-To: <7f826777-c9bd-d602-a8d5-613adc6b4a94@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> New:
> 1. userspace inject key into kernel keyring

I presume this step is what you do to use the nvdimm?  If so, this can use
request_key() and then splice the key across to the kernel keyring.

> 2. userspace triggers update with new key id and old key id
> 3. kernel looks up keys with key-id in kernel
> 4. kernel tries to update with hardware
> 5. on success kernel accepts new key (or update old key payload)

     ... and splices the key into the kernel keyring.

> Also, unlock right now basically is a request-key to userspace to retrieve
> the key before we unlock. If we go the other way it sounds like we need to
> inject all the keys from userspace first before unlock can happen?

No, you'd still use request_key() for that.

It's the change-password event that I'm suggesting you should use two
explicitly nominated keys for.

> I do think associating with the current key id with the nvdimm object
> can make things a lot easier and I can just do key_lookup() instead of
> calling request_key().

You shouldn't be using key_lookup().

> What about:
> 1. user triggers update through sysfs
> 2. kernel fetches old key with key-id that's associated with the nvdimm
> object from keyring

You can do that.  You'd use key_search() for that.

> 3. kernel request_key from userspace for new key

This bit I quibble with.  I think you should specify it to make sure that you
get the password you intended and don't pick something else up by accident.

> 4. kernel sends both payloads to hardware to attempt update
> 5. on success kernel invalidates old key and updates key-id associated
> with the nvdimm object

I think you should just link the new key across.  It should have the same
description as the old key to the kernel keyring.  This would displace the
old key automatically.

> ... lookup the key via key-id ...

You shouldn't use key IDs within the kernel, except at the UAPI boundary.  You
should be using the key description as the handle - and, in this case, it
should be an identifier you can match uniquely within the system with the
particular nvdimm.

David
