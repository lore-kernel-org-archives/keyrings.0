From: David Howells <dhowells@redhat.com>
Date: Thu, 25 Apr 2019 11:38:21 +0000
Subject: Re: [PATCH 07/11] keys: Move the user and user-session keyrings to the user_namespace
Message-Id: <3832.1556192301@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG48ez23c1eiEJpBwkV183sesj6EDWoMsEh40GDXQkS1W2_nMA@mail.gmail.com> <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk> <155612246750.8564.9186344007442012471.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAG48ez23c1eiEJpBwkV183sesj6EDWoMsEh40GDXQkS1W2_nMA@mail.gmail.com>
To: Jann Horn <jannh@google.com>
Cc: dhowells@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, keyrings@vger.kernel.org, linux-security-module <linux-security-module@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, dwalsh@redhat.com, vgoyal@redhat.com

Jann Horn <jannh@google.com> wrote:

> > +       struct key              *user_keyring_register;
> 
> Maybe a comment about locking semantics above user_keyring_register?
> "Only written once, may be read locklessly with READ_ONCE()", or
> something like that?

Ok.

> > -
> > +#define __KDEBUG
> 
> Was that supposed to be in here, or did you commit that accidentally?

Accidental.

> > -       struct key *uid_keyring, *session_keyring;
> > +       struct key *reg_keyring = user_ns->user_keyring_register;
> 
> This is a lockless read of a field that may be written concurrently;
> this should be READ_ONCE(). (Especially on alpha, I think the memory
> ordering will actually be incorrect without READ_ONCE().)

Yeah, you're right about both of these that you pointed out.  It's not needed
when the user_ns->keyring_sem is taken for writing, however.

> > +               if (!IS_ERR(reg_keyring))
> > +                       user_ns->user_keyring_register = reg_keyring;
> 
> This is a write of a pointer that may be read concurrently; this
> should be smp_store_release().

Yep.

> > +       else if ((user_session = get_user_session_keyring())) {
> > +               key_ref = keyring_search_aux(make_key_ref(user_session, 1),
> > +                                            ctx);
> >                 if (!IS_ERR(key_ref))
> >                         goto found;
> 
> I'm not sure I understand this code. In the "goto found" case, the
> key_put() below is skipped, right? Is that intentional?

Actually, the key_put() should be directly after the keyring_search_aux()
call, before the error check.

> >  error_alloc:
> >         complete_request_key(authkey, ret);
> > +error_us:
> > +       key_put(user_session);
> >         kleave(" = %d", ret);
> >         return ret;
> >  }
> 
> This looks weird. If the look_up_user_keyrings() fails, user_session
> might still be an uninitialized pointer, right? And then the "goto
> error_us" jumps down here and calls key_put() on that?

The call to complete_request_key() should be after error_us and the key_put()
should be before it.

> > @@ -289,16 +291,19 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
> >
> >                         if (dest_keyring)
> >                                 break;
> > +                       /* Fall through */
> >
> >                         /* fall through */
> >                 case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:
> 
> Why two "fall through" comments?

Someone else added one and when I rebased, I don't think I got a conflict.

David
