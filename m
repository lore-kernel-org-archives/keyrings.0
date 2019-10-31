From: Sasha Levin <sashal@kernel.org>
Date: Thu, 31 Oct 2019 09:10:41 +0000
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key create or update
Message-Id: <20191031091041.GO1554@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
 <20191031011910.2574-2-nramas@linux.microsoft.com>
In-Reply-To: <20191031011910.2574-2-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, prsriva@linux.microsoft.com

On Wed, Oct 30, 2019 at 06:19:02PM -0700, Lakshmi Ramasubramanian wrote:
>Asymmetric keys used for verifying file signatures or certificates
>are currently not included in the IMA measurement list.
>
>This patch defines a new IMA hook namely ima_post_key_create_or_update()
>to measure asymmetric keys.
>
>Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

What are the prerequisites for this patch?

-- 
Thanks,
Sasha
