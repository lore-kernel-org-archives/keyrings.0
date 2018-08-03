From: David Howells <dhowells@redhat.com>
Date: Fri, 03 Aug 2018 08:28:53 +0000
Subject: Re: [PATCH v6 05/11] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <24764.1533284933@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <465ca753-ad2c-6888-b139-8cb9c4472290@intel.com>
 <153255233932.51274.17371670672074459834.stgit@djiang5-desk3.ch.intel.com>
 <153255001863.51274.11308713958786222873.stgit@djiang5-desk3.ch.intel.com>
 <20101.1533211253@warthog.procyon.org.uk>
In-Reply-To: <465ca753-ad2c-6888-b139-8cb9c4472290@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> In order to do this, I would need to do a key_add() in userspace to add

Well, add_key().

> a new key with the new payload before I can initiate update correct? So
> for an update it would look something like:
> 1. (user) add key with new payload
> 2. (user) lookup old key

You don't technically need the old key - just a key with the old password in
it.  It doesn't need to have any useful description since you're providing it
directly.

> 3. (user) write to sysfs update attrib: "update:<old id>:<new id>"
> 4. (kernel) check old_id against cached key and make sure they match
> 5. (kernel) check new key desc against old key and make sure they match
> 6. (kernel) update to hardware
> 6. (kernel) when success, link the new key to the kernel keyring and
> it'll replace the old key?

Yep - provided it has the same description.  A keyring can only keep one key
of any {type, description} at any one time.  Adding a second will displace the
first.

David
