From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 30 Jan 2020 08:38:49 +0000
Subject: Re: [PATCH 1/1] proc_keys_next should increase position index
Message-Id: <c227488f2b52e43fa28d3ff5581172bb739fd791.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <af9dcaa7-6e4f-281a-2bae-fb605cc55d2d@virtuozzo.com>
In-Reply-To: <af9dcaa7-6e4f-281a-2bae-fb605cc55d2d@virtuozzo.com>
To: Vasily Averin <vvs@virtuozzo.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Fri, 2020-01-24 at 09:25 +0300, Vasily Averin wrote:
> if seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id 6283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Similar comments as I gave here:

https://patchwork.kernel.org/patch/11346943/

/Jarkko
