From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 10 Aug 2017 13:12:45 +0000
Subject: Re: [Linux-ima-devel] [PATCH, RESEND 08/12] ima: added parser for RPM data type
Message-Id: <1502370765.3367.69.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20170725154423.24845-9-roberto.sassu@huawei.com>
         <20170801102036.15371-1-roberto.sassu@huawei.com>
         <20170801102709.GA24285@infradead.org>
         <11206fd8-d189-deb0-ab67-aec373f8d979@huawei.com>
         <alpine.LRH.2.20.1708021716440.1117@namei.org>
         <0506050f-c4f1-1b36-a25b-c5418607906d@huawei.com>
         <1502289048.19092.62.camel@linux.vnet.ibm.com>
         <fffaf219-a633-478a-ec0e-2869419fe3b0@huawei.com>
In-Reply-To: <fffaf219-a633-478a-ec0e-2869419fe3b0@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>, James Morris <jmorris@namei.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

On Wed, 2017-08-09 at 19:18 +0200, Roberto Sassu wrote:
> On 8/9/2017 4:30 PM, Mimi Zohar wrote:
> > On Wed, 2017-08-09 at 11:15 +0200, Roberto Sassu wrote:
> >> On 8/2/2017 9:22 AM, James Morris wrote:
> >>> On Tue, 1 Aug 2017, Roberto Sassu wrote:
> >>>
> >>>> On 8/1/2017 12:27 PM, Christoph Hellwig wrote:
> >>>>> On Tue, Aug 01, 2017 at 12:20:36PM +0200, Roberto Sassu wrote:
> >>>>>> This patch introduces a parser for RPM packages. It extracts the digests
> >>>>>> from the RPMTAG_FILEDIGESTS header section and converts them to binary
> >>>>>> data
> >>>>>> before adding them to the hash table.
> >>>>>>
> >>>>>> The advantage of this data type is that verifiers can determine who
> >>>>>> produced that data, as headers are signed by Linux distributions vendors.
> >>>>>> RPM headers signatures can be provided as digest list metadata.
> >>>>>
> >>>>> Err, parsing arbitrary file formats has no business in the kernel.
> >>>>
> >>>> The benefit of this choice is that no actions are required for
> >>>> Linux distribution vendors to support the solution I'm proposing,
> >>>> because they already provide signed digest lists (RPM headers).
> >>>>
> >>>> Since the proof of loading a digest list is the digest of the
> >>>> digest list (included in the list metadata), if RPM headers are
> >>>> converted to a different format, remote attestation verifiers
> >>>> cannot check the signature.
> >>>>
> >>>> If the concern is security, it would be possible to prevent unsigned
> >>>> RPM headers from being parsed, if the PGP key type is upstreamed
> >>>> (adding in CC keyrings@vger.kernel.org).
> >>>
> >>> It's a security concern and also a layering violation, there should be no
> >>> need to parse package file formats in the kernel.
> >>
> >> Parsing RPMs is not strictly necessary. Digests from the headers
> >> can be extracted and written to a new file using the compact data
> >> format (introduced with patch 7/12).
> >>
> >> At boot time, IMA measures this file before digests are uploaded to the
> >> kernel. At this point, only files with unknown digest will be added
> >> to the measurement list. At verification time, verifiers recreate the
> >> measurement list by merging together the digests uploaded to the
> >> kernel with the unknown digests. Then, they verify the obtained list.
> >>
> >> There are two ways to verify the digests: searching them in a reference
> >> database, or checking a signature. With the 'ima-sig' measurement list
> >> template, it is possible to verify signatures for each accessed file.
> >> With this patch set, it is possible to verify the signature of
> >> the file containing the digests uploaded to the kernel. If the data
> >> format changes, the signature cannot be verified.
> >>
> >> To avoid this limitation, the parsers could be moved to a userspace
> >> tool which then uploads the parsed digests to the kernel. IMA would
> >> measure the original files. But, if the tool is compromised, it could
> >> load digests not included in the parsed files. With the current solution
> >> this problem does not arise because no changes can be done by userspace
> >> applications to the uploaded data while digests are parsed by IMA.
> >>
> >> I could remove the RPM parser from the patch set for now.
> >>
> >> Is the remaining part of the patch set ok, and is the explanation of
> >> what it does clear?
> >
> > From a trusted boot perspective, file measurements are added to the
> > measurement list, before access to the file is given.  The measurement
> > list contains ALL measurements, as defined by policy.  This patch set
> > changes that meaning to be all measurements, as defined by policy,
> > with the exception of those in a white list.
> 
> The digest list is also measured, so the measurement list is complete.
> Verifiers have to check the digest of digest lists. Otherwise, they
> would get an unknown digest and conclude that the system being verified
> has been compromised.

Your proposal is basically a pre-approved "batched" measurement, of a
set of known good measurements, without the corresponding list of
measurements that this "batched" measurement represents.  Right?

This pre-approved "batched" measurement represents not what has been
accessed/executed on the system, but what potentially could be
accessed/executed.  That's a major difference.

> If you prefer, I could add a new policy rule option to avoid file
> measurements if the digest is in the digest list.

Huh?  Patch "ima: don't report measurements if digests are included in
the loaded lists" is already doing this.

> 
> > Changing the fundamental meaning of the measurement list is not
> > acceptable.  You could define a new securityfs file to differentiate
> > between the full measurement list and this abbreviated one.  But
> 
> There cannot be two measurement lists at the same time. Providing the
> full measurement list (containing the digest of files being accessed)
> implies that its integrity must be protected with PCR extends, making
> the optimization done by this patch set useless.

True, so you would be able to configure the system with one or the
other type of list, not both.  At least there would be a clear
understanding of what that list represents.

> 
> > before making this sort of change, I would prefer to address the
> > underlying problem - TPM peformance.
> 
> Even if the TPM driver performance improves significantly (17 seconds
> for 1000 extends), the boot time delay would be still noticeable
> (8.5 seconds for normal boot + 24 seconds for 1400 PCR extends).

Agreed, there is still room for more TPM improvements.  Just Nayna's
one patch, without any other changes, brought the timing down from 53s
for a 1000 extends to just 11s.  (The initial patch was Nack'ed, but
we're working with the tpmdd and the TCG's device driver work group
(DDWG).)

> In my opinion, this patch set is useful without considering the
> performance improvement: reduced size of measurement lists and
> verification of digest list signatures, instead of file signatures,
> where signatures are already provided by Linux distributions.

Right, there's always a trade off.  My suggestion, assuming we go with
this approach, would be to make that trade off clear by using
different lists.

> 
> > There are a couple of things that could be done to improve the TPM
> > driver performance, itself.  Once all of these options have been
> > pursued, we could then consider batching the measurements to the TPM,
> > meaning that the measurement list would still contain all the file
> > measurements, but instead of extending the TPM for each measurement, a
> > batched hash - a hash of a group of file measurements - would be
> > extended into the TPM.
> 
> Probably, I didn't explain clearly that this patch set does not decrease
> the security of IMA.
> 
> Extending the PCR for a group of file measurements means that the system
> can be compromised between two PCR extends without detection because
> a malicious binary could alter IMA before the next extend.

Currently, a measurement is added to the measurement list and then is
used to extend the TPM, before returning to the caller.

A performance improvement would still first add the measurement to the
measurement list, but would then queue and wait for the measurement to
extend the TPM, before returning to the caller.  In a multi threaded
environment, the queued measurements could be "batched" - a hash of a
set of hashes - to extend the TPM.

The delay would be at most two times it takes to extend the TPM - one
to complete an existing current "batched" extend and another new
"batched" extend.

The difficulty with this approach is identifying which measurements
are included in which "batched" measurement.  This approach provides
the same guarantees as previously.

Before making the TPM performance problem an IMA issue and "fixing" it
in IMA, I would prefer that the TPM performance be addressed directly.

Mimi

> 
> This patch set extends the PCR with the digest of digest lists, before
> files are accessed. No actions happen before either the digest lists
> have been measured or the file measurement is added to the measurement
> list, if the file digest is not included in the digest list.


