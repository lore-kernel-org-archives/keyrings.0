From: Denis Kenzior <denkenz@gmail.com>
Date: Sat, 04 Aug 2018 15:29:54 +0000
Subject: Re: [dhowells-fs:keys-asym-keyctl 21/21] crypto/asymmetric_keys/asym_tpm.c:657:8-14: ERROR: referenc
Message-Id: <f5ca9cd5-5582-4f1b-e165-80f8aec45d11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi Julia, David,

On 08/04/2018 12:41 AM, Julia Lawall wrote:
> I can't guess what was intended here, but the kfree on line 652 followed
> by the memcpy on line 657 looks like a problem.
> 

Right.  Somehow I missed a goto here.  This should look like this:

-       if (r)
+       if (r) {
                 kfree(digest);
-       else if (out_digest_len)
+               goto error_free_req;
+       } else if (out_digest_len)

I can fix this in the next version, or if David wants to silently amend 
that is fine as well.

However, I'd really like to get some feedback on this first regarding 
whether the hash OIDs are desired to be shared somehow and whether 
there's a problem in pkcs1pad_sign.

Regards,
-Denis
