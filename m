From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 13 Nov 2019 22:02:08 +0000
Subject: Re: [PATCH v6 0/3] KEYS: Measure keys when they are created or updated
Message-Id: <1573682528.4793.3.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
In-Reply-To: <20191113184658.2862-1-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2019-11-13 at 10:46 -0800, Lakshmi Ramasubramanian wrote:
> Keys created or updated in the system are currently not measured.
> Therefore an attestation service, for instance, would not be able to
> attest whether or not the trusted keys keyring(s), for instance, contain
> only known good (trusted) keys.
> 
> IMA measures system files, command line arguments passed to kexec,
> boot aggregate, etc. It can be used to measure keys as well.
> But there is no mechanism available in the kernel for IMA to
> know when a key is created or updated.
> 
> This change aims to address measuring keys created or updated
> in the system:
> 
> To achieve the above the following changes have been made:
> 
>  - Added a new IMA hook namely, ima_post_key_create_or_update, which
>    measures the key. This IMA hook is called from key_create_or_update
>    function. The key measurement can be controlled through IMA policy.
> 
>    A new IMA policy function KEY_CHECK has been added to measure keys.
> 
>    # measure keys loaded onto any keyring
>    measure func=KEY_CHECK

When re-posting this patch set, please include the support for
specifying the "keyrings=" policy option, as an additional patch.

Mimi
