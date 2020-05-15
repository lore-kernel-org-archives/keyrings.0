From: "Kayaalp, Mehmet" <Mehmet.Kayaalp@unh.edu>
Date: Fri, 15 May 2020 21:03:16 +0000
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-Id: <56688CD4-A4A5-4D98-8724-6CBA10C7E1CE@unh.edu>
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
 <1589571278.3653.22.camel@HansenPartnership.com>
 <1589573417.3653.28.camel@HansenPartnership.com>
In-Reply-To: <1589573417.3653.28.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, David Howells <dhowells@redhat.com>


> On May 15, 2020, at 4:10 PM, James Bottomley <James.Bottomley@hansenpartnership.com> wrote:
> 
> I think that means the solution is not to run the smoke test under sudo
> but to do sudo -s and then run it.
> 
> James

How about "sudo -i":

https://askubuntu.com/questions/376199/sudo-su-vs-sudo-i-vs-sudo-bin-bash-when-does-it-matter-which-is-used

Mehmet
