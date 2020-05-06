From: Waiman Long <longman@redhat.com>
Date: Wed, 06 May 2020 01:29:58 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <3be0ef1d-fe7f-6b02-d9c0-c6b750fd94f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <694135.1586290793@warthog.procyon.org.uk>
 <20200407200318.11711-1-longman@redhat.com>
 <694340.1586290917@warthog.procyon.org.uk>
 <20200505133521.eb8901d0b92e09452191ab49@linux-foundation.org>
In-Reply-To: <20200505133521.eb8901d0b92e09452191ab49@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On 5/5/20 4:35 PM, Andrew Morton wrote:
> On Tue, 07 Apr 2020 21:21:57 +0100 David Howells <dhowells@redhat.com> wr=
ote:
>
>> David Howells <dhowells@redhat.com> wrote:
>>
>>>>   			if (unlikely(key_data))
>>>> -				__kvzfree(key_data, key_data_len);
>>>> +				kvfree_sensitive(key_data, key_data_len);
>>> I think the if-statement is redundant.
>> Ah - I see that you explicitly wanted to keep it.
> Why's that?

There is a comment above it:

 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /*
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * The key may change (unl=
ikely) in between 2 consecutive
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * __keyctl_read_key() cal=
ls. In this case, we reallocate
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * a larger buffer and red=
o the key read when
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * key_data_len < ret <=3D=
 buflen.
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret > key_data_len) {
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (=
unlikely(key_data))
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 __kvzfree(key_data, key_data_len);

key_data will be defined only if the unlikely case that the key increase=20
in length between the 2 consecutive __keyctl_read_key() call and we have=20
to enlarge the buffer and read the key again. I want to keep the=20
unlikely() macro to emphasize the fact that this condition should not=20
happen.

>> There's a good chance it'll get janitored at some point.
> Indeed.  Perhaps add a few little comments to explain the reasoning and
> to keep the janitorial fingers away?
>
I can reword the comment to make it more explicit and send a v4 if you=20
think the current comment is not clear enough.

Cheers,
Longman
