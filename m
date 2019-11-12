From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Tue, 12 Nov 2019 17:43:57 +0000
Subject: Re: [PATCH v5 02/10] IMA: Added keyrings= option in IMA policy to only measure keys added to the spe
Message-Id: <1f940f9d-fb1b-a0a4-b5f4-3f3532dbc041@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
 <20191111193303.12781-3-nramas@linux.microsoft.com>
 <1573578305.17949.42.camel@linux.ibm.com>
In-Reply-To: <1573578305.17949.42.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/12/2019 9:05 AM, Mimi Zohar wrote:

> The C maximum line length is 80 characters.  The subject line is even
> less than that (~50).  The Subject line here could be "ima: add
> support to limit measuring keys".
I'll update the subject line for the patches - limit to max 50 chars.

> 
> On Mon, 2019-11-11 at 11:32 -0800, Lakshmi Ramasubramanian wrote:
>> IMA policy needs to support measuring only those keys linked to
>> a specific set of keyrings.
> 
> Patch descriptions should be written in the imperative.  For example,
> "Limit measuring keys to those keys being loaded onto a specific
> keyring."
Will update.

> 
>>
>> This patch defines a new IMA policy option namely "keyrings=" that
>> can be used to specify a set of keyrings. If this option is specified
>> in the policy for func=KEYRING_CHECK then only the keys linked to
>> the keyrings given in "keyrings=" option are measured.
> 
> This description does not seem to match the code, which for some
> reason isn't included in this patch, nor in 3/10.  Please
> combine/squash patches 2 & 3.  Missing from the combined patch is the
> keyring matching code in ima_match_rules().

This patch defines "keyrings=" option in the IMA policy and adds the 
related field in ima_rule_entry struct.

The code for updating the new field in ima_rule_entry is in patch #4
[PATCH v5 04/10] IMA: Updated IMA policy functions to return keyrings 
option read from the policy

I'll update the description for this patch (#2).

  -lakshmi
