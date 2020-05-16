From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sat, 16 May 2020 12:33:22 +0000
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-Id: <4d2ff03c7869b5f5ba5c84da6720078628040980.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515191758.ieojyk5xhsx2hzzd@cantor>
In-Reply-To: <20200515191758.ieojyk5xhsx2hzzd@cantor>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Fri, 2020-05-15 at 12:17 -0700, Jerry Snitselaar wrote:
> > > > sudo ./keyctl-smoke.sh
> > > > 566201053 (0x80000000)
> > > > keyctl_read_alloc: Permission denied
> 
> I get keyctl_read_alloc -EPERM when I 'sudo su' and try to play with keyctl print.
> If I 'sudo su -' and then try it works as expected. Also works for normal user.

Can confirm these results with NUC7PJYH (Gemini Lake).

/Jarkko
