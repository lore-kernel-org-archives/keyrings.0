From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 02 Aug 2017 11:22:35 +0000
Subject: Re: [Linux-ima-devel] [PATCH, RESEND 08/12] ima: added parser for RPM data type
Message-Id: <5de9c4a2-dc96-b916-162a-adafd7da278b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170725154423.24845-9-roberto.sassu@huawei.com>
 <20170801102036.15371-1-roberto.sassu@huawei.com>
 <20170801102709.GA24285@infradead.org>
 <11206fd8-d189-deb0-ab67-aec373f8d979@huawei.com>
 <alpine.LRH.2.20.1708021716440.1117@namei.org>
In-Reply-To: <alpine.LRH.2.20.1708021716440.1117@namei.org>
To: James Morris <jmorris@namei.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-ima-devel@lists.sourceforge.net

On 8/2/2017 9:22 AM, James Morris wrote:
> On Tue, 1 Aug 2017, Roberto Sassu wrote:
>
>> On 8/1/2017 12:27 PM, Christoph Hellwig wrote:
>>> On Tue, Aug 01, 2017 at 12:20:36PM +0200, Roberto Sassu wrote:
>>>> This patch introduces a parser for RPM packages. It extracts the digests
>>>> from the RPMTAG_FILEDIGESTS header section and converts them to binary
>>>> data
>>>> before adding them to the hash table.
>>>>
>>>> The advantage of this data type is that verifiers can determine who
>>>> produced that data, as headers are signed by Linux distributions vendors.
>>>> RPM headers signatures can be provided as digest list metadata.
>>>
>>> Err, parsing arbitrary file formats has no business in the kernel.
>>
>> The benefit of this choice is that no actions are required for
>> Linux distribution vendors to support the solution I'm proposing,
>> because they already provide signed digest lists (RPM headers).
>>
>> Since the proof of loading a digest list is the digest of the
>> digest list (included in the list metadata), if RPM headers are
>> converted to a different format, remote attestation verifiers
>> cannot check the signature.
>>
>> If the concern is security, it would be possible to prevent unsigned
>> RPM headers from being parsed, if the PGP key type is upstreamed
>> (adding in CC keyrings@vger.kernel.org).
>
> It's a security concern and also a layering violation, there should be no
> need to parse package file formats in the kernel.
>
> I'm not really clear on exactly how this patch series works.  Can you
> provide a more concrete explanation of what steps would occur during boot
> and attestation?

The main idea of this patch set is that, if a system executes
or reads good files (e.g. those from a Linux distribution),
the difference between the assertion 'a file could have possibly
been accessed' and 'a file has been accessed' is not relevant
for verifiers that only check the provenance of software.

Then, for those verifiers, a measurement representing the list of
good files which could have possibly been accessed gives the same
guarantees of individual file measurements.

The patch set introduces two data types:

- digest list: contains the digests of good files
- list metadata: contains the digest, the signature and the path
                  of each digest list to load (why loading many
                  lists instead of one will be clear after I explain
                  the remote attestation verification process)

Steps at boot:

1) systemd reads the path of list metadata from /etc/ima/digest-lists
    and writes it to a new securityfs file created by IMA
2) IMA reads and parses the list metadata (same mechanism for
    loading a policy, already upstreamed)
3) for each list metadata, IMA reads and parses the digest list
    and adds the file digests to a hash table
4) when a file is accessed, IMA calculates the digest as before
    and searches the file digest in the new hash table; if the
    digest is found, IMA sets the IMA_MEASURED flag in the inode
    metadata and clears the IMA_MEASURE action

Notes:

- list metadata and digest lists are measured before IMA reads them
- the digest of digest lists is also added to the hash table, otherwise
   there would be a measurement for each digest list

The measurement list looks like:

10 <template digest> ima-ng <digest> boot_aggregate
10 <template digest> ima-ng <digest> systemd (exe + libs)
10 <template digest> ima-ng <digest> /etc/ima/digest-lists
10 <template digest> ima-ng <digest> <list metadata>
10 <template digest> ima-ng <digest> <unknown files>


Steps during the verification:

Case 1: list metadata and digest lists are provided to verifiers

This is necessary when:
- digest lists are not signed
- verifiers do not trust the signer
- verifiers want to perform more checks on digest lists
   (digest lists may contain digest of outdated software)

Verifiers:

1) parse the list metadata received
2) for each digest list received, calculate the digest and
    compare it with the digest included in the list metadata
3) calculate the digest of list metadata and compare it with
    the digest in the measurement list
4) calculate the digest of the path of list metadata and compare
    it with the digest of /etc/ima/digest-lists in the measurement list
5) check boot_aggregate, systemd exe and libs, and unknown files
6) check the digest lists


Case 2: only list metadata is provided to verifiers

Verifiers:

1) parse the list metadata received
2) for each digest list, verify the signature
3) calculate the digest of the path of list metadata and compare
    it with the digest of /etc/ima/digest-lists in the measurement list
4) check boot_aggregate, systemd exe and libs, and unknown files

In Case 2, the verification process is simplified, because if
the signature of digest lists is valid, this means that possibly
accessed files are provided by the signer.

The problem here is that verifiers know the digest of possibly
accessed files from the measurement done by IMA at the time
digest lists are read. If IMA cannot parse the original (signed)
digest list, it would measure something that cannot be verified
with the signature.

RPM-based distributions already provide signed digest lists
(the RPM headers) for each package. To avoid the performance
penalty due to extending a PCR for each digest list, only
an entry for the list metadata is added to the measurement list.

For RPM-based Linux distributions, the full lifecycle for configuring
IMA can be implemented with very low effort. The tasks are:

1) systemd patch to load list metadata: just extend the existing
    patch to load the policy
2) userspace tools to parse the RPM database: done
3) dracut module to generate and include the digest lists and
    metadata into the initial ram disk: at the moment this is done
    from the dracut command line
4) plugin for the software management that executes the tool
    to generate the digest list for updated packages: to be implemented

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
