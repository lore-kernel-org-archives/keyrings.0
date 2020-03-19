From: David Howells <dhowells@redhat.com>
Date: Thu, 19 Mar 2020 16:57:03 +0000
Subject: Re: [PATCH v8 6/8] security: keys: trusted: add PCR policy to TPM2 keys
Message-Id: <3180901.1584637023@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200310051607.30334-7-James.Bottomley@HansenPartnership.com> <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200310051607.30334-7-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: dhowells@redhat.com, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> keyctl new 32 keyhandle=0x81000001 hash=sha1 pcrinfo=030000016768033e216468247bd
> 031a0a2d9876d79818f8f" @u

I think part of this got lost.  There's only one '"' for a start.

David
