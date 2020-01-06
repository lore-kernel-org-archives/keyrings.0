From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 06 Jan 2020 21:53:23 +0000
Subject: Re: [PATCH v4 4/9] security: keys: trusted: use ASN.1 tpm2 key format for the blobs
Message-Id: <abc1b20bf3170eeed11922f5678608a6357160f1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-5-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20191230173802.8731-5-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, 2019-12-30 at 09:37 -0800, James Bottomley wrote:

Again bad formatting in the short summary.

> Modify the tpm2 key format blob output to export and import in the
> ASN.1 form for tpm2 sealed object keys.  For compatibility with prior
> trusted keys, the importer will also accept two tpm2b quantities
> representing the public and private parts of the key.  However, the
> export via keyctl pipe will only output the ASN.1 format.

I think this is fair enough when it comes to backwards compatibility.

What you should do with the earlier patch is to document in the commit
message this framework for backwards compatibility. It is redundancy
but makes the commit log easier to follow. E.g. tell in that commit
message that ASN.1 loader will handle loading old blobs.

> The benefit of the ASN.1 format is that it's a standard and thus the
> exported key can be used by userspace tools.  The format includes
> policy specifications, thus it gets us out of having to construct
> policy handles in userspace and the format includes the parent meaning
> you don't have to keep passing it in each time.

Please be explicit with the tools you are referring. Point out what
you are using if there is variable number of choices.

In high-level the code change itself looks good.

/Jarkko
