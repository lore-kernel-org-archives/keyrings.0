From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 11 Jan 2019 16:13:40 +0000
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for signature verify
Message-Id: <1547223220.19931.471.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190109164824.19708-1-kasong@redhat.com>
         <20190109164824.19708-3-kasong@redhat.com>
         <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
To: Dave Young <dyoung@redhat.com>, Kairui Song <kasong@redhat.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org

On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
[snip]

> Personally I would like to see platform key separated from integrity.
> But for the kexec_file part I think it is good at least it works with
> this fix.
> 
> Acked-by: Dave Young <dyoung@redhat.com>

The original "platform" keyring patches that Nayna posted multiple
times were in the certs directory, but nobody commented/responded.  So
she reworked the patches, moving them to the integrity directory and
posted them (cc'ing the kexec mailing list).  It's a bit late to be
asking to move it, isn't it?

Mimi
