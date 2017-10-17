From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 17 Oct 2017 17:52:06 +0000
Subject: Re: [RFC][PATCH 00/15] KEYS: Fixes
Message-Id: <20171017175206.GB555@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171016183141.GD121701@gmail.com>
	<20171012185612.GA11577@gmail.com>
	<150782504738.1655.12882942775980793687.stgit@warthog.procyon.org.uk>
	<2176.1507909168@warthog.procyon.org.uk>
	<27552.1508192842@warthog.procyon.org.uk>
In-Reply-To: <27552.1508192842@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Mon, Oct 16, 2017 at 11:27:22PM +0100, David Howells wrote:
> Okay, I've fixed those issues, I think.  I've renamed the instantiation labels
> to positive.
> 
> Thanks,
> David
> ---
> commit f23f3bb0ba3be44e775ac74148157136b919e3b0
> Author: David Howells <dhowells@redhat.com>
> Date:   Wed Oct 4 16:43:25 2017 +0100
> 
>     KEYS: Fix race between updating and finding a negative key
>     
>     Consolidate KEY_FLAG_INSTANTIATED, KEY_FLAG_NEGATIVE and the rejection
>     error into one field such that:
>     
>      (1) The instantiation state can be modified/read atomically.
>     
>      (2) The error can be accessed atomically with the state.
>     
>      (3) The error isn't stored unioned with the payload pointers.
>     
>     This deals with the problem that the state is spread over three different
>     objects (two bits and a separate variable) and reading or updating them
>     atomically isn't practical, given that not only can uninstantiated keys
>     change into instantiated or rejected keys, but rejected keys can also turn
>     into instantiated keys - and someone accessing the key might not be using
>     any locking.
>     
>     The main side effect of this problem is that what was held in the payload
>     may change, depending on the state.  For instance, you might observe the
>     key to be in the rejected state.  You then read the cached error, but if
>     the key semaphore wasn't locked, the key might've become instantiated
>     between the two reads - and you might now have something in hand that isn't
>     actually an error code.
>     
>     The state is now KEY_IS_UNINSTANTIATED, KEY_IS_POSITIVE or a negative error
>     code if the key is negatively instantiated.  The key_is_instantiated()
>     function is replaced with key_is_positive() to avoid confusion as negative
>     keys are also 'instantiated'.
>     
>     Additionally, barriering is included:
>     
>      (1) Order payload-set before state-set during instantiation.
>     
>      (2) Order state-read before payload-read when using the key.
>     
>     Further separate barriering is necessary if RCU is being used to access the
>     payload content after reading the payload pointers.
>     
>     Fixes: 146aa8b1453b ("KEYS: Merge the type-specific data with the payload data")
>     Cc: stable@vger.kernel.org # v4.4+
>     Reported-by: Eric Biggers <ebiggers@google.com>
>     Signed-off-by: David Howells <dhowells@redhat.com>
> 

This looks good now; feel free to add

	Reviewed-by: Eric Biggers <ebiggers@google.com>
