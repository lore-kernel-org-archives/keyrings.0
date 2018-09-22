From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 22 Sep 2018 01:26:16 +0000
Subject: Re: [PATCH v8 06/12] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <CAPcyv4gVoN2orHRFie-Q=hBRva1UCds-g=nHAT6zqEZ8YBh3uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153549647177.4089.18112512093259339717.stgit@djiang5-desk3.ch.intel.com>
 <153549632073.4089.3609134467249378610.stgit@djiang5-desk3.ch.intel.com>
 <19459.1537574236@warthog.procyon.org.uk>
 <c804ec81-68c5-3e11-c65f-1226e68a4b2b@intel.com>
In-Reply-To: <c804ec81-68c5-3e11-c65f-1226e68a4b2b@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>, Kees Cook <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Eric Biggers <ebiggers3@gmail.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Fri, Sep 21, 2018 at 5:29 PM Dave Jiang <dave.jiang@intel.com> wrote:
[..]
> > What I meant here was to use, say, nvdimm_lookup_user_key() to get a key from
> > userspace that contains the old password.  You can use the description of the
> > key to search nvdimm_keyring for the private key and then compare the
> > passwords.
>
> Ok I have a bit of confusion here. When the user injects a new key with
> the same description and new passphrase, would that not replace the
> existing user key with the old passphrase? Also, if I'm calling
> lookup_user_key, where would the key_id come from for the old user key?
> I suppose I can cache it.... Maybe I'm not quite understanding the exact
> flow of how things you are suggesting.

If the DIMM is in the in the unlocked state the kernel should already
have the old passphrase cached, right? Could we just have the kernel
fail ->change_key() requests if the kernel does not already have a
valid old passphrase?

It does mean we can't support going from the locked state directly to
changing the password, but I would expect requiring an initial unlock
is fine.
