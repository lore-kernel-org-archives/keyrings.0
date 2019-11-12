From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 12 Nov 2019 18:06:03 +0000
Subject: Re: [PATCH v5 04/10] IMA: Updated IMA policy functions to return keyrings option read from the polic
Message-Id: <1573581963.17949.63.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
         <20191111193303.12781-5-nramas@linux.microsoft.com>
         <1573578316.17949.43.camel@linux.ibm.com>
         <407b93e1-f474-7b01-816f-62b45690f417@linux.microsoft.com>
In-Reply-To: <407b93e1-f474-7b01-816f-62b45690f417@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2019-11-12 at 09:47 -0800, Lakshmi Ramasubramanian wrote:
> On 11/12/2019 9:05 AM, Mimi Zohar wrote:
> 
> >>   int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> >>   		     enum ima_hooks func, int mask, int flags, int *pcr,
> >> -		     struct ima_template_desc **template_desc)
> >> +		     struct ima_template_desc **template_desc,
> >> +		     char **keyrings)
> >>   {
> >>   	struct ima_rule_entry *entry;
> >>   	int action = 0, actmask = flags | (flags << 1);
> >> @@ -527,6 +529,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> >>   		if ((pcr) && (entry->flags & IMA_PCR))
> >>   			*pcr = entry->pcr;
> >>   
> >> +		if ((keyrings) && (entry->flags & IMA_KEYRINGS))
> >> +			*keyrings = entry->keyrings;
> > 
> > ima_match_rules() determines whether the rule is in policy or not. It
> > returns true on rule match, false on failure.  There's no need to
> > return the list of keyrings.
> 
> But the above code change is in ima_match_policy() - not in 
> ima_match_rules() function.
> 
> ima_match_rules() function is updated in Patch #1 -
> [PATCH v5 01/10] IMA: Added KEYRING_CHECK func in IMA policy to measure keys
> 
> I've updated that function to check if func is "KEYRING_CHECK" and 
> return true\false as appropriate.
> 
> Am I missing something?

The first patch adds basic support for the new "func".  This allows
measuring all keys.  ima_match_rules() then needs to be updated in the
patch that adds the "keyrings=" or "keyring=" support to limit it to a
specific keyring.

Mimi
