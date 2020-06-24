From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 24 Jun 2020 18:37:55 +0000
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used seems to break linux bridge on s
Message-Id: <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
 <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
 <3118dc0d-a3af-9337-c897-2380062a8644@de.ibm.com>
 <20200624144311.GA5839@infradead.org>
 <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
 <20200624160953.GH4332@42.do-not-panic.com>
 <ea41e2a9-61f7-aec1-79e5-7b08b6dd5119@de.ibm.com>
 <4e27098e-ac8d-98f0-3a9a-ea25242e24ec@de.ibm.com>
 <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
In-Reply-To: <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>



On 24.06.20 20:32, Christian Borntraeger wrote:
[...]> 
> So the translations look correct. But your change is actually a sematic change
> if(ret) will only trigger if there is an error
> if (KWIFEXITED(ret)) will always trigger when the process ends. So we will always overwrite -ECHILD
> and we did not do it before. 
> 

So the right fix is

diff --git a/kernel/umh.c b/kernel/umh.c
index f81e8698e36e..a3a3196e84d1 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -154,7 +154,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
                 * the real error code is already in sub_info->retval or
                 * sub_info->retval is 0 anyway, so don't mess with it then.
                 */
-               if (KWIFEXITED(ret))
+               if (KWEXITSTATUS(ret))
                        sub_info->retval = KWEXITSTATUS(ret);
        }
 


I think.
