From: Kairui Song <kasong@redhat.com>
Date: Fri, 18 Jan 2019 12:07:30 +0000
Subject: Re: [PATCH v4 0/2] let kexec_file_load use platform keyring to verify the kernel image
Message-Id: <CACPcB9ffvpHbGdp5xz4R5cwXxERsVwzkQEKO9C50c+_hj+n_0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190118091733.29940-1-kasong@redhat.com> <1547812432.3982.55.camel@linux.ibm.com>
In-Reply-To: <1547812432.3982.55.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com, Dave Young <dyoung@redhat.com>, linux-integrity <linux-integrity@vger.kernel.org>, kexec@lists.infradead.org

On Fri, Jan 18, 2019, 19:54 Mimi Zohar <zohar@linux.ibm.com wrote:
>
> On Fri, 2019-01-18 at 17:17 +0800, Kairui Song wrote:
> > This patch series adds a .platform_trusted_keys in system_keyring as the
> > reference to .platform keyring in integrity subsystem, when platform
> > keyring is being initialized it will be updated. So other component could
> > use this keyring as well.
>
> Kairui, when people review patches, the comments could be specific,
> but are normally generic.  My review included a couple of generic
> suggestions - not to use "#ifdef" in C code (eg. is_enabled), use the
> term "preboot" keys, and remove any references to "other components".
>
> After all the wording suggestions I've made, you are still saying, "So
> other components could use this keyring as well".  Really?!  How the
> platform keyring will be used in the future, is up to you and others
> to convince Linus.  At least for now, please limit its usage to
> verifying the PE signed kernel image.  If this patch set needs to be
> reposted, please remove all references to "other components".
>
> Dave/David, are you ok with Kairui's usage of "#ifdef's"?  Dave, you
> Acked the original post.  Can I include it?  Can we get some
> additional Ack's on these patches?
>
> thanks!
>
> Mimi
>

Hi, Mimi, thanks for your feedback. My bad I reused the old cover
letter without checking it carefully, hopefully, the commit messages
should have a proper wording now. If the cover letter needs to be
updated I can resend the patch, let me just hold a while before update
again.
