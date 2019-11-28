From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 28 Nov 2019 00:44:22 +0000
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
Message-Id: <18b30666-7c44-f81e-8515-189052007e47@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
 <20191127015654.3744-6-nramas@linux.microsoft.com>
 <1574880741.4793.292.camel@linux.ibm.com>
In-Reply-To: <1574880741.4793.292.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 11/27/19 10:52 AM, Mimi Zohar wrote:

Hi Mimi,

>> +static bool ima_match_keyring(struct ima_rule_entry *rule,
>> +			      const char *keyring)
>> +{
>> +	/*
>> +	 * "keyrings=" is specified in the policy in the format below:
>> +	 *   keyrings=.builtin_trusted_keys|.ima|.evm
>> +	 *
>> +	 * Each keyring name in the option is separated by a '|' and
>> +	 * the last keyring name is null terminated.
>> +	 *
>> +	 * The given keyring is considered matched only if
>> +	 * the whole keyring name matched a keyring name specified
>> +	 * in the "keyrings=" option.
>> +	 */
>> +	p = strstr(rule->keyrings, keyring);
>> +	if (p) {
>> +		/*
>> +		 * Found a substring match. Check if the character
>> +		 * at the end of the keyring name is | (keyring name
>> +		 * separator) or is the terminating null character.
>> +		 * If yes, we have a whole string match.
>> +		 */
>> +		p += strlen(keyring);
>> +		if (*p = '|' || *p = '\0')
>> +			return true;
>> +	}
>> +
> 
> Using "while strsep()" would simplify this code, removing the need for
> such a long comment.
> 
> Mimi

strsep() modifies the source string (replaces the delimiter with '\0' 
and also updates the source string pointer). I am not sure it can be 
used for our scenario. Please correct me if I am wrong.

Initial IMA policy:
-------------------
measure func=KEY_CHECK 
keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist template=ima-buf

Policy after adding a key to .ima keyring:
------------------------------------------
measure func=KEY_CHECK keyrings=.evm|.builtin_trusted_keys|.blacklist 
template=ima-buf

Policy after adding a key to a keyring that is not listed in the policy:
------------------------------------------------------------------------
measure func=KEY_CHECK keyrings= template=ima-buf

********************************************************************************

Please see the description from the man page for strsep():

http://man7.org/linux/man-pages/man3/strsep.3.html

char *strsep(char **stringp, const char *delim);

This function finds the first token in the string *stringp, that is 
delimited by one of the bytes in the string delim.  This token is 
terminated by overwriting the delimiter with a null byte ('\0'), and 
*stringp is updated to point past the token.

thanks,
  -lakshmi
