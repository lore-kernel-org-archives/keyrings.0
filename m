From: David Howells <dhowells@redhat.com>
Date: Wed, 06 Dec 2017 14:50:17 +0000
Subject: Re: [PATCH] security: keys: remove redundant assignment to key_ref
Message-Id: <15713.1512571817@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LFD.2.20.1712051116130.21642@localhost>
	<20171204181424.15808-1-colin.king@canonical.com>
In-Reply-To: <alpine.LFD.2.20.1712051116130.21642@localhost>
To: linux-security-module@vger.kernel.org

James Morris <james.l.morris@oracle.com> wrote:

> I think a general cleanup in that function to make all of these follow the 
> pattern:
> 
> 	if (something) {
> 		key_ref = ERR_PTR(-error);
> 		goto error;
> 	}
> 
> rather than unconditionally setting the error first, would be better, but 
> this is a clear enough fix on its own.

There's a preference in Linux to use:

	key_ref = ERR_PTR(-error);
 	if (something)
 		goto error;

instead because it uses less vertical space.  It might originally have been
promulgated by Linus, but I don't remember.  Though you do have a point - your
way makes error handling less subject breakage from code rearrangement.

David
