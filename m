From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Wed, 07 Mar 2018 17:59:46 +0000
Subject: Re: [PATCH 1/3] certs: define a trusted platform keyring
Message-Id: <8873df7f-490f-28e0-249e-34bb3b133015@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
 <31489.1520438598@warthog.procyon.org.uk>
In-Reply-To: <31489.1520438598@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org



On 03/07/2018 09:33 PM, David Howells wrote:
> Nayna Jain <nayna@linux.vnet.ibm.com> wrote:
>
>> +		key = key_create_or_update(make_key_ref(keyring, 1),
>> +				"asymmetric",
>> +				NULL,
>> +				p,
>> +				plen,
>> +				((KEY_POS_ALL & ~KEY_POS_SETATTR) |
>> +				 KEY_USR_VIEW | KEY_USR_READ),
>> +				KEY_ALLOC_NOT_IN_QUOTA |
>> +				KEY_ALLOC_BUILT_IN |
>> +				KEY_ALLOC_BYPASS_RESTRICTION);
> There's no need to reindent here.  Please line up all the arguments: either
> push the first argument over onto the next line if you need to or line them
> all up with the char after the opening bracket.

Thanks David for the feedback. I will post the v2 version with this fix. 
Are there any other changes ?

Thanks & Regards,
    - Nayna

>
> David
>

