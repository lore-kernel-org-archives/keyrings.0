From: James Morris <james.l.morris@oracle.com>
Date: Fri, 27 Oct 2017 08:06:01 +0000
Subject: Re: [PATCH] keyctl: use keyctl_read_alloc() in dump_key_tree_aux()
Message-Id: <alpine.LFD.2.20.1710271005480.3746@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171026210008.106248-1-ebiggers3@gmail.com>
In-Reply-To: <20171026210008.106248-1-ebiggers3@gmail.com>
To: keyrings@vger.kernel.org

On Thu, 26 Oct 2017, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> dump_key_tree_aux() (part of 'keyctl show') was racy: it allocated a
> buffer for the keyring contents, then read the keyring.  But it's
> possible that keys are added to the keyring concurrently.  This is
> problematic for two reasons.  First, when keyctl_read() is passed a
> buffer that is too small, it is unspecified whether it is filled or not.
> Second, even if the buffer is filled, some keys (not necessarily even
> the newest ones) would be omitted from the listing.
> 
> Switch to keyctl_read_alloc() which handles the "buffer too small" case
> correctly by retrying the read.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

