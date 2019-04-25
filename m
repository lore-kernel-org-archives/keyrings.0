From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 25 Apr 2019 19:46:45 +0000
Subject: Re: [PATCH v2] KEYS: Make use of platform keyring for module signature verify
Message-Id: <1556221605.24945.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1556116431-7129-1-git-send-email-robeholmes@gmail.com>
         <1556193350.3894.92.camel@linux.ibm.com>
In-Reply-To: <1556193350.3894.92.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Robert Holmes <robeholmes@gmail.com>, jeyu@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, stable@vger.kernel.org

On Thu, 2019-04-25 at 07:55 -0400, Mimi Zohar wrote:
> On Wed, 2019-04-24 at 14:33 +0000, Robert Holmes wrote:
> > This patch completes commit 278311e417be ("kexec, KEYS: Make use of
> > platform keyring for signature verify") which, while adding the
> > platform keyring for bzImage verification, neglected to also add
> > this keyring for module verification.
> > 
> > As such, kernel modules signed with keys from the MokList variable
> > were not successfully verified.
> 
> Using the platform keyring keys for verifying kernel modules was not
> neglected, but rather intentional.  This patch description should
> clearly explain the reason for needing to verify kernel module
> signatures based on the pre-boot keys.  (Hint: verifying kernel
> modules based on the pre-boot keys was previously rejected.)

To clarify here: most Linux systems use shim/mok to pivot the root of
trust away from the Secure Boot db variable to the new MokList/shim
built in keys.  This makes the actual secure boot db outside the
expected Linux Kernel trust boundary *unless* the user has taken
ownership of the system and is actually using db for their own trusted
keys.  This makes the policy for what pre-boot keys to trust within the
Linux boundary very complex, which is why we default to not using the
pre-boot keys at all.

James
