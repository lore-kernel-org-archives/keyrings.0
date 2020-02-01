From: Vasily Averin <vvs@virtuozzo.com>
Date: Sat, 01 Feb 2020 07:54:06 +0000
Subject: Re: [PATCH v2] keys: proc_keys_next should increase position index
Message-Id: <bb473a18-3241-9377-3bee-33d4e9381f3d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <22307ecd-3254-6077-8bc7-02693338b586@virtuozzo.com>
 <eaacb0b2-fd0d-480e-1868-0a1284c20185@virtuozzo.com>
 <265151.1580491178@warthog.procyon.org.uk>
In-Reply-To: <265151.1580491178@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>

On 1/31/20 8:19 PM, David Howells wrote:
> Vasily Averin <vvs@virtuozzo.com> wrote:
>> If seq_file .next fuction does not change position index,
> "function"
>>    <<<< and whole last lien again
> "line"
> 
> I can fix these up for you.

thank you!

>> https://bugzilla.kernel.org/show_bug.cgi?id 6283
> 
> I wonder if this should have a tag - it looks kind of out of place without
> one, but I can't find one suggested.

Some maintainers of another subsystems asked me to add 
Cc: stable@vger.kernel.org
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
however frankly speaking I do not think it is required in this case.

Thank you,
	Vasily Averin
