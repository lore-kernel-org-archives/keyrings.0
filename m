From: James Morris <jmorris@namei.org>
Date: Wed, 02 Aug 2017 07:22:30 +0000
Subject: Re: [Linux-ima-devel] [PATCH, RESEND 08/12] ima: added parser for RPM data type
Message-Id: <alpine.LRH.2.20.1708021716440.1117@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170725154423.24845-9-roberto.sassu@huawei.com> <20170801102036.15371-1-roberto.sassu@huawei.com> <20170801102709.GA24285@infradead.org> <11206fd8-d189-deb0-ab67-aec373f8d979@huawei.com>
In-Reply-To: <11206fd8-d189-deb0-ab67-aec373f8d979@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-ima-devel@lists.sourceforge.net

On Tue, 1 Aug 2017, Roberto Sassu wrote:

> On 8/1/2017 12:27 PM, Christoph Hellwig wrote:
> > On Tue, Aug 01, 2017 at 12:20:36PM +0200, Roberto Sassu wrote:
> > > This patch introduces a parser for RPM packages. It extracts the digests
> > > from the RPMTAG_FILEDIGESTS header section and converts them to binary
> > > data
> > > before adding them to the hash table.
> > >
> > > The advantage of this data type is that verifiers can determine who
> > > produced that data, as headers are signed by Linux distributions vendors.
> > > RPM headers signatures can be provided as digest list metadata.
> >
> > Err, parsing arbitrary file formats has no business in the kernel.
> 
> The benefit of this choice is that no actions are required for
> Linux distribution vendors to support the solution I'm proposing,
> because they already provide signed digest lists (RPM headers).
> 
> Since the proof of loading a digest list is the digest of the
> digest list (included in the list metadata), if RPM headers are
> converted to a different format, remote attestation verifiers
> cannot check the signature.
> 
> If the concern is security, it would be possible to prevent unsigned
> RPM headers from being parsed, if the PGP key type is upstreamed
> (adding in CC keyrings@vger.kernel.org).

It's a security concern and also a layering violation, there should be no 
need to parse package file formats in the kernel.

I'm not really clear on exactly how this patch series works.  Can you 
provide a more concrete explanation of what steps would occur during boot 
and attestation? 

-- 
James Morris
<jmorris@namei.org>

