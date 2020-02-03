From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon, 03 Feb 2020 14:48:12 +0000
Subject: Re: SELinux: How to split permissions for keys?
Message-Id: <bd03ab75-7df5-7de8-4d31-9f3e02bcb10e@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <8ee40192da117d9cdf4eab1e63ab5f77b359801c.camel@btinternet.com>
 <4057700.1579792320@warthog.procyon.org.uk>
 <de2c5cda-567b-d310-42f7-46a2c20969c4@tycho.nsa.gov>
 <50f98f04-d00e-ae54-9a90-d0ff10be515a@tycho.nsa.gov>
 <459818a9ad1c808298bf3d7c9bcb130323d30e97.camel@btinternet.com>
 <3d1923ec-f02b-6be7-b0c0-d3d6f539b034@tycho.nsa.gov>
 <de8d82ba7db7abdf2a72d88c8cbc590e289f5f6f.camel@btinternet.com>
In-Reply-To: <de8d82ba7db7abdf2a72d88c8cbc590e289f5f6f.camel@btinternet.com>
To: Richard Haines <richard_c_haines@btinternet.com>, David Howells <dhowells@redhat.com>, paul@paul-moore.com
Cc: keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/3/20 9:03 AM, Richard Haines wrote:
> On Mon, 2020-02-03 at 08:13 -0500, Stephen Smalley wrote:
>> Was that kernel patch ever posted to selinux list and/or the selinux
>> kernel maintainers?  I don't recall seeing it.  If not, please send
>> it
>> to the selinux list for review; at least one selinux maintainer
>> should
>> ack it before it gets accepted into any other tree.
>>
>>
> 
> Not formally. I did post it in a discussion about keys in [2]. Since
> then it's been modified to support the split permissions.

Yes, that doesn't count since a) it wasn't the final version of the 
patch which changed significantly afterward and b) even it had been the 
final version, there was no acked-by or reviewed-by from a selinux 
maintainer, just some suggestions.  A non-trivial patch that modifies 
security/selinux needs to be at least acked by a selinux maintainer and 
often should go through the upstream selinux maintainer (Paul).

> I've extracted the patch from [1] and will post that to list for
> comments.

Thanks.

> [2]
> https://lore.kernel.org/selinux/35455b30b5185780628e92c98ec8191c70f39bde.camel@btinternet.com/
