From: Casey Schaufler <casey@schaufler-ca.com>
Date: Fri, 15 May 2020 19:10:24 +0000
Subject: Re: [PATCH] keys: Move permissions checking decisions into the checking code
Message-Id: <1ca402a1-5665-44b8-ef94-9473ebd6a32a@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
 <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
 <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com>
 <3999877.1589475539@warthog.procyon.org.uk>
 <CAEjxPJ5wW2qHYDsqKr5rjnRJ++4f2LXobCQkKZvWCSb_j0WN6w@mail.gmail.com>
 <196730.1589561109@warthog.procyon.org.uk>
 <CAEjxPJ6JGZxF_G63Y7M-CQpmt5Sqp2uFF4oEKS6NpNLZxXhXcA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6JGZxF_G63Y7M-CQpmt5Sqp2uFF4oEKS6NpNLZxXhXcA@mail.gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>

On 5/15/2020 11:55 AM, Stephen Smalley wrote:
> On Fri, May 15, 2020 at 12:45 PM David Howells <dhowells@redhat.com> wrote:
>> I can go back to the enum patch for the moment if you and Casey can put up
>> with that for the moment?
> Yes, let's do that.

OK by me.
