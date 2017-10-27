From: James Morris <james.l.morris@oracle.com>
Date: Fri, 27 Oct 2017 08:04:31 +0000
Subject: Re: [PATCH] KEYS: return full count in keyring_read() if buffer is too small
Message-Id: <alpine.LFD.2.20.1710271004150.3746@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171026205644.105471-1-ebiggers3@gmail.com>
In-Reply-To: <20171026205644.105471-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Ben Hutchings <ben@decadent.org.uk>, Xiao Yang <yangx.jy@cn.fujitsu.com>, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

On Thu, 26 Oct 2017, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Commit e645016abc80 ("KEYS: fix writing past end of user-supplied buffer
> in keyring_read()") made keyring_read() stop corrupting userspace memory
> when the user-supplied buffer is too small.  However it also made the
> return value in that case be the short buffer size rather than the size
> required, yet keyctl_read() is actually documented to return the size
> required.  Therefore, switch it over to the documented behavior.
> 
> Note that for now we continue to have it fill the short buffer, since it
> did that before (pre-v3.13) and dump_key_tree_aux() in keyutils arguably
> relies on it.
> 
> Fixes: e645016abc80 ("KEYS: fix writing past end of user-supplied buffer in keyring_read()")
> Reported-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: <stable@vger.kernel.org> # v3.13+
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

