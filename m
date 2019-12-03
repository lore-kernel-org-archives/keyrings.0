From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 03 Dec 2019 12:25:45 +0000
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
Message-Id: <1575375945.5241.16.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
         <20191127015654.3744-6-nramas@linux.microsoft.com>
In-Reply-To: <20191127015654.3744-6-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Hi Lakshmi,

On Tue, 2019-11-26 at 17:56 -0800, Lakshmi Ramasubramanian wrote:
> Limit measuring keys to those keys being loaded onto a given set of
> keyrings only.
> 
> This patch defines a new IMA policy option namely "keyrings=" that
> can be used to specify a set of keyrings. If this option is specified
> in the policy for "measure func=KEY_CHECK" then only the keys
> loaded onto a keyring given in the "keyrings=" option are measured.
> 
> Added a new parameter namely "keyring" (name of the keyring) to
> process_buffer_measurement(). The keyring name is passed to
> ima_get_action() to determine the required action.
> ima_match_rules() is updated to check keyring in the policy, if
> specified, for KEY_CHECK function.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

A keyring can be created by any user with any keyring name, other than
 ones dot prefixed, which are limited to the trusted builtin keyrings.
 With a policy of "func=KEY_CHECK template=ima-buf keyrings=foo", for
example, keys loaded onto any keyring named "foo" will be measured.
 For files, the IMA policy may be constrained to a particular uid/gid.
 An additional method of identifying or constraining keyring names
needs to be defined.

Mimi 
