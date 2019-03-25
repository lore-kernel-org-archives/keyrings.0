From: Joe Perches <joe@perches.com>
Date: Mon, 25 Mar 2019 21:27:05 +0000
Subject: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
Message-Id: <20190325212705.26837-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
To: linux-kernel@vger.kernel.org
Cc: James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, Denis Kenzior <denkenz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, James Morris <james.morris@microsoft.com>

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	8587	KEYS-TRUSTED
	8588	M:	James Bottomley <jejb@linux.ibm.com>
	8589	M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
	8590	M:	Mimi Zohar <zohar@linux.ibm.com>
	8591	L:	linux-integrity@vger.kernel.org
	8592	L:	keyrings@vger.kernel.org
	8593	S:	Supported
	8594	F:	Documentation/security/keys/trusted-encrypted.rst
	8595	F:	include/keys/trusted-type.h
	8596	F:	security/keys/trusted.c
-->	8597	F:	security/keys/trusted.h

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'security/keys/trusted.h':

commit 7f3c68bee977ab872827e44de017216736fe21d7
Author: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Tue Jan 18 09:07:13 2011 -0500

    keys: add trusted and encrypted maintainers
    
    Add myself and David Safford as maintainers for trusted/encrypted keys.
    
    Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
    Acked-by: David Howells <dhowells@redhat.com>
    Signed-off-by: James Morris <jmorris@namei.org>

 MAINTAINERS | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

3: ---------------------------------------------------------------------------

The last commit with a real presence of file pattern 'security/keys/trusted.h':

commit 22447981fc050b5f1bdd0e7cbee89b4152a2b2d8
Author: Denis Kenzior <denkenz@gmail.com>
Date:   Tue Oct 9 17:48:49 2018 +0100

    KEYS: Move trusted.h to include/keys [ver #2]
    
    Signed-off-by: Denis Kenzior <denkenz@gmail.com>
    Signed-off-by: David Howells <dhowells@redhat.com>
    Tested-by: Marcel Holtmann <marcel@holtmann.org>
    Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: James Morris <james.morris@microsoft.com>

 {security => include}/keys/trusted.h | 0
 security/keys/trusted.c              | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
