From: David Howells <dhowells@redhat.com>
Date: Wed, 24 Apr 2019 22:24:31 +0000
Subject: Re: [PATCH 07/11] keys: Move the user and user-session keyrings to the user_namespace
Message-Id: <3753.1556144671@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG48ez23c1eiEJpBwkV183sesj6EDWoMsEh40GDXQkS1W2_nMA@mail.gmail.com> <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk> <155612246750.8564.9186344007442012471.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAG48ez23c1eiEJpBwkV183sesj6EDWoMsEh40GDXQkS1W2_nMA@mail.gmail.com>
To: Jann Horn <jannh@google.com>
Cc: dhowells@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, keyrings@vger.kernel.org, linux-security-module <linux-security-module@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, dwalsh@redhat.com, vgoyal@redhat.com

Jann Horn <jannh@google.com> wrote:

> Overall, this looks good to me, apart from some details.
> 
> The user_keyring_register keyring is basically just used like an
> xarray/idr/... that maps from namespaced UIDs to keyrings, right? (Not
> saying it's a bad idea, just want to make sure I understand it
> correctly.)

Well, a keyring is a wrapper around an assoc_array object, the keyring search
functions do the access checks and the keys garbage collector does the
cleanup.  Also, each UID is mapped to two keyrings.

I'll have a look at applying the rest of your comments tomorrow.

Thanks,
David
