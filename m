From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 23 Jan 2019 18:36:00 +0000
Subject: Re: [PATCH v5 0/2] let kexec_file_load use platform keyring to verify the kernel image
Message-Id: <1548268560.3971.2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190121095929.26915-1-kasong@redhat.com>
In-Reply-To: <20190121095929.26915-1-kasong@redhat.com>
To: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org

On Mon, 2019-01-21 at 17:59 +0800, Kairui Song wrote:
> This patch series adds a .platform_trusted_keys in system_keyring as the
> reference to .platform keyring in integrity subsystem, when platform
> keyring is being initialized it will be updated, so it will be
> accessable for verifying PE signed kernel image.

There were some scripts/checkpatch.pl errors/warnings emitted on these
patches.  I've fixed them, but in the future please follow the
guidelines in Documentation/process/submitting-patches.rst.

These patches are now queued in the next-integrity branch of
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

Mimi
