From: Yannik Sembritzki <yannik@sembritzki.me>
Date: Thu, 16 Aug 2018 13:17:47 +0000
Subject: Re: [PATCH 1/2] Replace magic for trusting the secondary keyring with #define
Message-Id: <07e17009-18bb-df72-3408-7e8c0c11e16f@sembritzki.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
	<18610.1534425319@warthog.procyon.org.uk>
In-Reply-To: <18610.1534425319@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On 16.08.2018 15:15, David Howells wrote:
> I would suggest something like that.  I've switched the patches over as has
> been suggested.  I think it makes more sense to create the constant first and
> then use that.
>
> I've also fleshed out the patch description a bit and added cc and Fixes
> fields as appropriate.

Thanks, that looks good to me.
I see that you only cc'd stable@ in the (now) second patch. I'm curious,
will this automatically apply the first patch to stable?

Yannik
