From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 16 Apr 2020 17:46:17 +0000
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust source
Message-Id: <20200416174617.GI199110@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1585636165-22481-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1585636165-22481-1-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net, casey@schaufler-ca.com, janne.karhunen@gmail.com, kgoldman@us.ibm.com, david.safford@ge.com, monty.wiseman@ge.com, daniel.thompson@linaro.org, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org

On Tue, Mar 31, 2020 at 11:59:25AM +0530, Sumit Garg wrote:
> Update documentation for Trusted and Encrypted Keys with TEE as a new
> trust source. Following is brief description of updates:
> 
> - Add a section to demostrate a list of supported devices along with
>   their security properties/guarantees.
> - Add a key generation section.
> - Updates for usage section including differences specific to a trust
>   source.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Overally this works for me. Can you bundle this with the code
changes. Maybe some details needs to be fine tuned but easier
to look into them in the context of rest of the patches.

/Jarkko
