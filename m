From: David Howells <dhowells@redhat.com>
Date: Thu, 16 Aug 2018 13:05:23 +0000
Subject: [PATCH 2/2] Fix kexec forbidding kernels signed with keys in the secondary keyring to boot
Message-Id: <153442472298.17751.5395559214488109936.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
In-Reply-To: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Yannik Sembritzki <yannik@sembritzki.me>

The split of .system_keyring into .builtin_trusted_keys and
.secondary_trusted_keys broke kexec, thereby preventing kernels signed by
keys which are now in the secondary keyring from being kexec'd.

Fix this by passing VERIFY_USE_SECONDARY_KEYRING to
verify_pefile_signature().

Fixes: d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: kexec@lists.infradead.org
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
cc: stable@vger.kernel.org
---

 arch/x86/kernel/kexec-bzimage64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7326078eaa7a..278cd07228dd 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loader_data)
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
 	return verify_pefile_signature(kernel, kernel_len,
-				       NULL,
+				       VERIFY_USE_SECONDARY_KEYRING,
 				       VERIFYING_KEXEC_PE_SIGNATURE);
 }
 #endif
