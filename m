From: David Howells <dhowells@redhat.com>
Date: Mon, 16 Mar 2020 14:24:32 +0000
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer allocation
Message-Id: <1809107.1584368672@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200313152102.1707-4-longman@redhat.com> <20200313152102.1707-1-longman@redhat.com>
In-Reply-To: <20200313152102.1707-4-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

I wonder if it's worth merging this into patch 2.  I'm not sure it's really
worth its own patch.  If you want to generalise kvzfree(), then that could go
as its own patch first.

David
