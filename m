From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 29 Jan 2020 00:42:51 +0000
Subject: [PATCH] generic/581: try to avoid flakiness in keys quota test
Message-Id: <20200129004251.133747-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, Murphy Zhou <xzhou@redhat.com>

From: Eric Biggers <ebiggers@google.com>

generic/581 passes for me, but Murphy Zhou reported that it started
failing for him.  The part that failed is the part that sets the key
quota to the fsgqa user's current number of keys plus 5, then tries to
add 6 filesystem encryption keys as the fsgqa user.  Adding the 6th key
unexpectedly succeeded.

What I think is happening is that because the kernel's keys subsystem
garbage-collects keys asynchronously, the quota may be freed up later
than expected after removing fscrypt keys.  Thus the test is flaky.

It would be nice to fix this in the kernel, but unfortunately there
doesn't seem to be an easy fix, and the keys subsystem has always worked
this way.  And it seems unlikely to cause real-world problems, as the
keys quota really just exists to prevent denial-of-service attacks.

So, for now just try to make the test more reliable by:

(1) Reduce the scope of the modified keys quota to just the part of the
    test that needs it.
(2) Before getting the current number of keys for the purpose of setting
    the quota, wait for any invalidated keys to be garbage-collected.

Tested with a kernel that has a 1 second sleep hacked into the beginning
of key_garbage_collector().  With that, this test fails before this
patch and passes afterwards.

Reported-by: Murphy Zhou <xzhou@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/581 | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tests/generic/581 b/tests/generic/581
index 89aa03c2..bc49eadc 100755
--- a/tests/generic/581
+++ b/tests/generic/581
@@ -45,14 +45,6 @@ _require_scratch_encryption -v 2
 _scratch_mkfs_encrypted &>> $seqres.full
 _scratch_mount
 
-# Set the fsgqa user's key quota to their current number of keys plus 5.
-orig_keys=$(_user_do "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4}' /proc/key-users | cut -d/ -f1")
-: ${orig_keys:=0}
-echo "orig_keys=$orig_keys" >> $seqres.full
-orig_maxkeys=$(</proc/sys/kernel/keys/maxkeys)
-keys_to_add=5
-echo $((orig_keys + keys_to_add)) > /proc/sys/kernel/keys/maxkeys
-
 dir=$SCRATCH_MNT/dir
 
 raw_key=""
@@ -98,6 +90,24 @@ _user_do_rm_enckey $SCRATCH_MNT $keyid
 
 _scratch_cycle_mount	# Clear all keys
 
+# Wait for any invalidated keys to be garbage-collected.
+i=0
+while grep -E -q '^[0-9a-f]+ [^ ]*i[^ ]*' /proc/keys; do
+	if ((++i >= 20)); then
+		echo "Timed out waiting for invalidated keys to be GC'ed" >> $seqres.full
+		break
+	fi
+	sleep 0.5
+done
+
+# Set the user key quota to the fsgqa user's current number of keys plus 5.
+orig_keys=$(_user_do "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4}' /proc/key-users | cut -d/ -f1")
+: ${orig_keys:=0}
+echo "orig_keys=$orig_keys" >> $seqres.full
+orig_maxkeys=$(</proc/sys/kernel/keys/maxkeys)
+keys_to_add=5
+echo $((orig_keys + keys_to_add)) > /proc/sys/kernel/keys/maxkeys
+
 echo
 echo "# Testing user key quota"
 for i in `seq $((keys_to_add + 1))`; do
@@ -106,6 +116,9 @@ for i in `seq $((keys_to_add + 1))`; do
 	    | sed 's/ with identifier .*$//'
 done
 
+# Restore the original key quota.
+echo "$orig_maxkeys" > /proc/sys/kernel/keys/maxkeys
+
 rm -rf $dir
 echo
 _user_do "mkdir $dir"
-- 
2.25.0.341.g760bfbb309-goog
