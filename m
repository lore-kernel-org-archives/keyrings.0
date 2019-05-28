From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 28 May 2019 20:06:09 +0000
Subject: Re: [PATCH v10 09/12] ima: Implement support for module-style appended signatures
Message-Id: <1559073969.4139.38.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
         <20190418035120.2354-10-bauerman@linux.ibm.com>
         <1557442868.10635.87.camel@linux.ibm.com>
         <87zhn65qor.fsf@morokweng.localdomain>
In-Reply-To: <87zhn65qor.fsf@morokweng.localdomain>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>

On Tue, 2019-05-28 at 16:23 -0300, Thiago Jung Bauermann wrote:
> Mimi Zohar <zohar@linux.ibm.com> writes:
> 
> > Hi Thiago,
> >
> >> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> >> index fca7a3f23321..a7a20a8c15c1 100644
> >> --- a/security/integrity/ima/ima_policy.c
> >> +++ b/security/integrity/ima/ima_policy.c
> >> @@ -1144,6 +1144,12 @@ void ima_delete_rules(void)
> >>  	}
> >>  }
> >>
> >> +#define __ima_hook_stringify(str)	(#str),
> >> +
> >> +const char *const func_tokens[] = {
> >> +	__ima_hooks(__ima_hook_stringify)
> >> +};
> >> +
> >>  #ifdef	CONFIG_IMA_READ_POLICY
> >>  enum {
> >>  	mask_exec = 0, mask_write, mask_read, mask_append
> >> @@ -1156,12 +1162,6 @@ static const char *const mask_tokens[] = {
> >>  	"MAY_APPEND"
> >>  };
> >>
> >> -#define __ima_hook_stringify(str)	(#str),
> >> -
> >> -static const char *const func_tokens[] = {
> >> -	__ima_hooks(__ima_hook_stringify)
> >> -};
> >> -
> >>  void *ima_policy_start(struct seq_file *m, loff_t *pos)
> >>  {
> >>  	loff_t l = *pos;
> >
> > Is moving this something left over from previous versions or there is
> > a need for this change?
> 
> Well, it's not a strong need, but it's still relevant in the current
> version. I use func_tokens in ima_read_modsig() in order to be able to
> mention the hook name in mod_check_sig()'s error message:
> 
> In ima_read_modsig():
> 
> 	rc = mod_check_sig(sig, buf_len, func_tokens[func]);
> 
> And in mod_check_sig():
> 
> 		pr_err("%s: Module is not signed with expected PKCS#7 message\n",
> 		       name);
> 
> If you think it's not worth it to expose func_tokens, I can make
> ima_read_modsig() pass a more generic const string such as "IMA modsig"
> for example.

This is fine.  I somehow missed moving func_tokens[] outside of the
ifdef was in order to make it independent of "CONFIG_IMA_READ_POLICY".

thanks,

Mimi
