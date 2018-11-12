From: Denis Kenzior <denkenz@gmail.com>
Date: Mon, 12 Nov 2018 16:42:35 +0000
Subject: Re: [PATCH] integrity: support new struct public_key_signature encoding field
Message-Id: <ddcdddf8-bdfd-4bf8-463b-84f7d3ed7623@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1541946593-4812-1-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1541946593-4812-1-git-send-email-zohar@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

Hi Mimi,

On 11/11/2018 08:29 AM, Mimi Zohar wrote:
> On systems with IMA-appraisal enabled with a policy requiring file
> signatures, the "good" signature values are stored on the filesystem as
> extended attributes (security.ima).  Signature verification failure
> would normally be limited to just a particular file (eg. executable),
> but during boot signature verification failure could result in a system
> hang.
> 
> Defining and requiring a new public_key_signature field requires all
> callers of asymmetric signature verification to be updated to reflect
> the change.  This patch updates the integrity asymmetric_verify()
> caller.
> 
> Fixes: 82f94f24475c ("KEYS: Provide software public key query function [ver #2]")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Denis Kenzior <denkenz@gmail.com>
> ---
>   security/integrity/digsig_asymmetric.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Acked/Reviewed by: Denis Kenzior <denkenz@gmail.com>

Regards,
-Denis
