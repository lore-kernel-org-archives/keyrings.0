From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 17 Oct 2018 14:34:15 +0000
Subject: Re: [PATCH] support other engines for module signing
Message-Id: <1539786855.3769.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LFD.2.21.1810171142300.20697@hatman>
In-Reply-To: <alpine.LFD.2.21.1810171142300.20697@hatman>
To: keyrings@vger.kernel.org

On Wed, 2018-10-17 at 11:43 +0100, Mark J Cox wrote:
> Allow sign-file to use any available OpenSSL engine, not limited
> to PKCS-11 by using "enginename:keyname" syntax.  We have to do a
> special case for pkcs11 key name passing.

There's actually already a proposal for this which David (Howells) has
been ignoring:

https://marc.info/?l=linux-keyrings&m1845297302654&w=2

It tries to use the correct UI callbacks, which yours is missing.

James
